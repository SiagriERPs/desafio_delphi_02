unit unit_fProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unit_fPadrao, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  ProdutoVO, ProdutoCCliente,biblioteca, Vcl.Imaging.pngimage;

type
  TfProduto = class(TfPadrao)
    edt_id: TLabeledEdit;
    edt_nome: TLabeledEdit;
    edt_valor: TLabeledEdit;
    cb_especial: TComboBox;
    Label3: TLabel;
    procedure btn_cancelarClick(Sender: TObject);
    procedure edt_valorKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure LimparFormulario;
    procedure TelaParaObjProduto(objProduto : TProdutoVO);
    procedure GridParaObjeto(objProduto : TProdutoVO);
    procedure ObjetoParaTela(objProduto : TProdutoVO);

  public
    { Public declarations }
    function editar():Boolean; override;
    function excluir():Boolean; override;
    function gravar():Boolean; override;
    function inserir():Boolean; override;

    procedure gridCarrega(); override;
    procedure gridComboboxFiltro; override;

    function validacao():Boolean;
    function validacaoNome(sNome:string):Boolean;
    function validacaoPreco(cValor:Currency):Boolean;
  end;

var
  fProduto: TfProduto;

implementation

{$R *.dfm}

{ TfProduto }

procedure TfProduto.btn_cancelarClick(Sender: TObject);
begin
  inherited;
  LimparFormulario;
end;

function TfProduto.editar: Boolean;
var
objProduto : TProdutoVO;
begin
  try
    if  fdmt_pesquisaPadrao.Active = true then
    begin
      if fdmt_pesquisaPadrao.RecordCount > 0 then
      begin
        LimparFormulario;
        objProduto := TProdutoVO.Create();
        GridParaObjeto(objProduto);
        ObjetoParaTela(objProduto);
      end;
    end;
  finally

  end;

end;

procedure TfProduto.edt_valorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not((Key in ['0' .. '9', #8]) or (Key = ',')) then
    Key := #0;
end;

function TfProduto.excluir: Boolean;
begin
  if  fdmt_pesquisaPadrao.Active = true then
  begin
    if fdmt_pesquisaPadrao.RecordCount > 0 then
    begin
      try
        TProdutoCCliente.Excluir(fdmt_pesquisaPadrao.FieldByName('id').AsInteger);
        gridCarrega;
      Except
        on E: Exception do
        raise Exception.Create(E.Message);
      end;
    end;
  end;
end;

function TfProduto.gravar: Boolean;
var
objProduto : TProdutoVO;
begin
  try
    objProduto := TProdutoVO.Create();
    if validacao then
    begin
      TelaParaObjProduto(objProduto);
      if (sAcao = 'Inserir') then
      begin
        result := TProdutoCCliente.Inserir(objProduto);
        LimparFormulario;
      end else
      if (sAcao = 'Editar') then
      begin
        result := TProdutoCCliente.editar(objProduto);
        LimparFormulario;
      end;
      if Result then
        MsgCrud(sAcao)
    end;
  finally
    objProduto.Free;
  end;
end;


procedure TfProduto.gridCarrega;
begin
  fdmt_pesquisaPadrao.close;
  fdmt_pesquisaPadrao := TProdutoCCliente.ConsultaGridPesquisa
    (cb_filtro.ItemIndex, eTexto.Text, fdmt_pesquisaPadrao);
end;

procedure TfProduto.gridComboboxFiltro;
var sLista : TStringList;
begin
  inherited;
  sLista := TStringList.Create;
  sLista.Clear;
  TProdutoCCliente.CarregaComboBoxPadrao(sLista);
  cb_filtro.Items := slista;
  cb_filtro.ItemIndex := 0;
end;

procedure TfProduto.GridParaObjeto(objProduto: TProdutoVO);
begin
  if (fdmt_pesquisaPadrao.fields.FieldByName('Id').AsInteger) > 0 then
  begin
    TProdutoCCliente.ConsultaObjId(
              fdmt_pesquisaPadrao.fields.FieldByName('Id').AsInteger,
              objProduto);
  end;
end;

function TfProduto.inserir: Boolean;
begin
  edt_nome.SetFocus;
end;

procedure TfProduto.LimparFormulario;
begin
  edt_id.Clear;
  edt_nome.Clear;
  edt_valor.Clear;
  cb_especial.ItemIndex := 0;
end;

procedure TfProduto.ObjetoParaTela(objProduto: TProdutoVO);
begin
  edt_id.Text           := IntToStr(objProduto.ID);
  edt_nome.Text         := objProduto.NOME;
  edt_valor.Text        := CurrToStr(objProduto.VALOR);
  cb_especial.ItemIndex := objProduto.CONTROLE_ESP;
end;

procedure TfProduto.TelaParaObjProduto(objProduto: TProdutoVO);
begin
  objProduto.ID           := StrToIntDef(edt_id.Text,0);
  objProduto.NOME         := edt_nome.Text;
  objProduto.valor        := StrToCurrDef(edt_valor.Text,0);
  objProduto.CONTROLE_ESP := cb_especial.ItemIndex;
end;

function TfProduto.validacao: Boolean;
begin
  if validacaoPreco(StrToCurrDef(edt_valor.Text,0)) and
    validacaoNome(edt_nome.Text)
  then
    Result := true
  else
    Result := false;
end;

function TfProduto.validacaoNome(sNome: string): Boolean;
begin
  if Length(snome) = 0 then
  begin
    Erro('Informe o nome do produto!');
    Result := false;
  end
  else
    Result := true;
end;

function TfProduto.validacaoPreco(cValor: Currency): Boolean;
begin
  if cValor = 0 then
  begin
    Erro('Informe o valor do produto!');
    result := false
  end
  else
    result := true;

end;

end.
