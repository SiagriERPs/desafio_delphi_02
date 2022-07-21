unit unit_fCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unit_fPadrao, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ExtCtrls, ClienteCCliente,
  ClienteVO, System.ImageList, Vcl.ImgList,Biblioteca, Vcl.Imaging.pngimage;

type
  TfCliente = class(TfPadrao)
    edt_id: TLabeledEdit;
    edt_nome: TLabeledEdit;
    edt_cpf: TLabeledEdit;
    procedure DBG_pesquisaPadraoDblClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
  private
    { Private declarations }
    procedure LimparFormulario;
    procedure TelaParaObjCliente(objCliente : TClienteVO);
    procedure GridParaObjeto(objCliente : TClienteVO);
    procedure ObjetoParaTela(objCliente : TClienteVO);


  public
    { Public declarations }
    function editar():Boolean; override;
    function excluir():Boolean; override;
    function gravar():Boolean; override;
    function inserir():Boolean; override;
    function validacao():Boolean;
    function validacaoNome(sNome:string):Boolean;
    function validacaoCPF(sCPF:string):Boolean;

    procedure gridCarrega(); override;
    procedure gridComboboxFiltro; override;
  end;

var
  fCliente: TfCliente;

implementation

{$R *.dfm}

procedure TfCliente.btn_cancelarClick(Sender: TObject);
begin
  inherited;
  LimparFormulario;
end;

procedure TfCliente.DBG_pesquisaPadraoDblClick(Sender: TObject);
begin
  inherited;
  btn_editarClick(nil);
end;

function TfCliente.editar: Boolean;
var
objCliente : TClienteVO;
begin
  try
    if  fdmt_pesquisaPadrao.Active = true then
    begin
      if fdmt_pesquisaPadrao.RecordCount > 0 then
      begin
        LimparFormulario;
        objCliente := TClienteVO.Create();
        GridParaObjeto(objCliente);
        ObjetoParaTela(objCliente);
      end;
    end;
  finally

  end;
end;

function TfCliente.excluir: Boolean;
begin
  if  fdmt_pesquisaPadrao.Active = true then
  begin
    if fdmt_pesquisaPadrao.RecordCount > 0 then
    begin
      try
        TClienteCCliente.Excluir(fdmt_pesquisaPadrao.FieldByName('id').AsInteger);
        gridCarrega;
      Except
        on E: Exception do
        raise Exception.Create(E.Message);
      end;
    end;
  end;
end;

function TfCliente.gravar: Boolean;
var
objCliente : TClienteVO;
begin
  try
    Result := false;
    objCliente := TClienteVO.Create();
    if (validacao) then
    begin
      TelaParaObjCliente(objCliente);
      if (sAcao = 'Inserir') then
      begin
        result := TClienteCCliente.Inserir(objCliente);
        LimparFormulario;
      end else
      if (sAcao = 'Editar') then
      begin
        result := TClienteCCliente.editar(objCliente);
        LimparFormulario;
      end;

      if Result then
        MsgCrud(sAcao)
    end;
  finally
    objCliente.Free;
  end;

end;

procedure TfCliente.gridCarrega;
begin
  fdmt_pesquisaPadrao.close;
  fdmt_pesquisaPadrao := TClienteCCliente.ConsultaGridPesquisa
    (cb_filtro.ItemIndex, eTexto.Text, fdmt_pesquisaPadrao);
end;

procedure TfCliente.gridComboboxFiltro;
var sLista : TStringList;
begin
  inherited;
  sLista := TStringList.Create;
  sLista.Clear;
  TClienteCCliente.CarregaComboBoxPadrao(sLista);
  cb_filtro.Items := slista;
  cb_filtro.ItemIndex := 0;
end;

procedure TfCliente.GridParaObjeto(objCliente: TClienteVO);
begin
  if (fdmt_pesquisaPadrao.fields.FieldByName('Id').AsInteger) > 0 then
  begin
    TClienteCCliente.ConsultaObjId(
              fdmt_pesquisaPadrao.fields.FieldByName('Id').AsInteger,
              objCliente);
  end;
end;

function TfCliente.inserir: Boolean;
begin
  edt_cpf.SetFocus;
end;

procedure TfCliente.LimparFormulario;
begin
  edt_id.Clear;
  edt_nome.Clear;
  edt_cpf.Clear;
end;

procedure TfCliente.ObjetoParaTela(objCliente: TClienteVO);
begin
  edt_id.Text   := IntToStr(objCliente.ID);
  edt_nome.Text := objCliente.NOME;
  edt_cpf.Text  := objCliente.CPF;
end;

procedure TfCliente.TelaParaObjCliente(objCliente : TClienteVO);
begin
  objCliente.ID   := StrToIntDef(edt_id.Text,0);
  objCliente.NOME := edt_nome.Text;
  objCliente.CPF  := edt_cpf.Text;
end;

function TfCliente.validacao: Boolean;
var bResut:boolean;
begin
  if validacaoCPF(edt_cpf.Text) and
    validacaoNome(edt_nome.Text)
  then
    Result := true
  else
    Result := false;
end;

function TfCliente.validacaoCPF(sCPF: string): Boolean;
begin
  result := validaCpf(sCpf);
end;

function TfCliente.validacaoNome(sNome : string): Boolean;
begin
  if Length(snome) = 0 then
  begin
    Erro('Nome não informado!');
    Result := false;
  end
  else
    Result := true;
end;

end.
