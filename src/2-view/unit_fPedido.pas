unit unit_fPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, unit_fPadrao, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  PedidoVO, PedidoCCliente, PesquisaCCliente, unit_fPesquisa, ClienteVO,
  ClienteCCliente, ProdutoVO, ProdutoCCliente, PedidoItemVO,
  PedidoItemCCliente, Vcl.Mask, biblioteca, ReceitaVO, ReceitaItemVO,
  ReceitaCCliente, TecnicoVO, TecnicoCCliente, Vcl.Imaging.pngimage;

type
  TfPedido = class(TfPadrao)
    pgc_pedido: TPageControl;
    ts_pedido_item: TTabSheet;
    DBG_item: TDBGrid;
    Panel1: TPanel;
    ts_pedido_cab: TTabSheet;
    edt_id: TLabeledEdit;
    edt_data_abertura: TLabeledEdit;
    edt_total: TLabeledEdit;
    edt_id_produto: TButtonedEdit;
    edt_nome_produto: TEdit;
    edt_quantidade: TLabeledEdit;
    edt_valor_produto: TLabeledEdit;
    edt_total_produto: TLabeledEdit;
    BitBtn1: TBitBtn;
    edt_nome_cliente: TEdit;
    edt_nome_tecnico: TEdit;
    edt_id_cliente: TButtonedEdit;
    Label3: TLabel;
    edt_id_tecnico: TButtonedEdit;
    Label4: TLabel;
    Label5: TLabel;
    ds_pesquisaItem: TDataSource;
    fdmt_pesquisaItem: TFDMemTable;
    btn_finalizar: TBitBtn;
    cb_especial: TComboBox;
    Label6: TLabel;
    procedure edt_id_clienteRightButtonClick(Sender: TObject);
    procedure edt_id_clienteExit(Sender: TObject);
    procedure edt_id_clienteLeftButtonClick(Sender: TObject);
    procedure edt_id_produtoExit(Sender: TObject);
    procedure edt_quantidadeExit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure edt_quantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edt_id_produtoRightButtonClick(Sender: TObject);
    procedure edt_id_produtoLeftButtonClick(Sender: TObject);
    procedure btn_finalizarClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure edt_id_tecnicoRightButtonClick(Sender: TObject);
    procedure edt_id_tecnicoLeftButtonClick(Sender: TObject);
    procedure edt_id_tecnicoExit(Sender: TObject);
  private
    { Private declarations }
    procedure LimparFormulario;
    procedure TelaParaObjPedido(objPedido : TPedidoVO);
    procedure GridParaObjeto(objPedido : TPedidoVO);
    procedure ObjetoParaTela(objPedido : TPedidoVO);

    procedure pesquisaCliente();
    procedure pesquisaClienteId(id:Integer);
    procedure limpaCliente;

    procedure pesquisaProduto();
    procedure pesquisaProdutoId(id:Integer);
    procedure limpaProduto;
    procedure calculaProduto;

    procedure pesquisaTecnico();
    procedure pesquisaTecnicoId(id:Integer);
    procedure limpaTecnico;

  public
    { Public declarations }
    function editar():Boolean; override;
    function excluir():Boolean; override;
    function gravar():Boolean; override;
    function inserir():Boolean; override;

    procedure gridCarrega(); override;

    //ações pedido item
    function gravarItem():Boolean;
    function TelaParaObjPedidoItem(objPedidoItem : TPedidoItemVO):TPedidoItemVO;
    procedure gridCarregaItem;
    procedure habilitaPageControlItens(bSituacao:Boolean);
    procedure recalculaTotal();

    //finalizando receita

    function verificaProdutoEspecial():Boolean;
    function validaFinalizacao():Boolean;
    function finalizaPedido():Boolean;

    //gravação de receita
    function gravarReceita():Boolean;

  end;

var
  fPedido: TfPedido;

implementation

{$R *.dfm}

{ TfPedido }

procedure TfPedido.BitBtn1Click(Sender: TObject);
begin
  inherited;
  gravarItem;
end;

procedure TfPedido.btn_finalizarClick(Sender: TObject);
begin
  inherited;
  finalizaPedido;

end;

procedure TfPedido.btn_cancelarClick(Sender: TObject);
begin
  inherited;
  LimparFormulario;
end;

procedure TfPedido.calculaProduto;
var cValor,cQuantidade,cTotal:Currency;
begin
  try
    if StrToCurrDef(edt_quantidade.Text,0) = 0 then exit;

    cValor      := StrToCurr(edt_valor_produto.Text);
    cQuantidade := StrToCurr(edt_quantidade.Text);
    cTotal      := cValor * cQuantidade;
    edt_total_produto.Text := MaskReal(CurrToStr(cTotal));
  Except
    on E: Exception do
    erro('Erro ao calcular produto: ' + E.Message );
  end;
end;

function TfPedido.editar: Boolean;
var
objPedido : TPedidoVO;
begin
  try
    Result := false;
    if  fdmt_pesquisaPadrao.Active = true then
    begin
      if fdmt_pesquisaPadrao.RecordCount > 0 then
      begin
        if fdmt_pesquisaPadrao.FieldByName('Status').AsString <> 'Aberto' then
        begin
          Erro('Este pedido não esta mais aberto');
          exit;
        end;

        LimparFormulario;
        objPedido := TPedidoVO.Create();
        GridParaObjeto(objPedido);
        ObjetoParaTela(objPedido);
        habilitaPageControlItens(true);
        gridCarregaItem;
        recalculaTotal;
        btn_finalizar.Enabled := true;
        Result := true;
      end;
    end;
  finally

  end;
end;

procedure TfPedido.edt_id_clienteExit(Sender: TObject);
begin
  inherited;
  if StrToIntDef(edt_id_cliente.Text,0) > 0 then
    pesquisaClienteId(StrToIntDef(edt_id_cliente.Text,0));

end;

procedure TfPedido.edt_id_clienteLeftButtonClick(Sender: TObject);
begin
  inherited;
  limpaCliente;
end;

procedure TfPedido.edt_id_clienteRightButtonClick(Sender: TObject);
begin
  PesquisaCliente;
end;

procedure TfPedido.edt_id_produtoExit(Sender: TObject);
begin
  inherited;
  if StrToIntDef(edt_id_produto.Text,0) > 0 then
    pesquisaProdutoId(StrToIntDef(edt_id_produto.Text,0));
end;

procedure TfPedido.edt_id_produtoLeftButtonClick(Sender: TObject);
begin
  inherited;
  limpaProduto;
end;

procedure TfPedido.edt_id_produtoRightButtonClick(Sender: TObject);
begin
  inherited;
  pesquisaProduto;
end;

procedure TfPedido.edt_id_tecnicoExit(Sender: TObject);
begin
  inherited;
  if StrToIntDef(edt_id_tecnico.Text,0) > 0 then
    pesquisaTecnicoId(StrToIntDef(edt_id_tecnico.Text,0));
end;

procedure TfPedido.edt_id_tecnicoLeftButtonClick(Sender: TObject);
begin
  inherited;
  limpaTecnico;
end;

procedure TfPedido.edt_id_tecnicoRightButtonClick(Sender: TObject);
begin
  inherited;
  pesquisaTecnico;
end;

procedure TfPedido.edt_quantidadeExit(Sender: TObject);
begin
  inherited;
  calculaProduto;
end;

procedure TfPedido.edt_quantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not((Key in ['0' .. '9', #8]) or (Key = ',')) then
    Key := #0;
end;

function TfPedido.excluir: Boolean;
begin

end;

function TfPedido.finalizaPedido: Boolean;
begin
  if validaFinalizacao then
  begin
    if verificaProdutoEspecial then
      gravarReceita()
    else
      TPedidoCCliente.AlteraStatusPedido(StrToInt(edt_id.Text),2);

    LimparFormulario;
    habilitaPageControl(false);
    gridCarrega;
  end;
end;

function TfPedido.gravar: Boolean;
var
objPedido : TPedidoVO;
begin
  result := false;

  try
    objPedido := TPedidoVO.Create();
    TelaParaObjPedido(objPedido);
    if (sAcao = 'Inserir') then
    begin
      result := TPedidoCCliente.Inserir(objPedido);
    end else
    if (sAcao = 'Editar') then
    begin
      result := TPedidoCCliente.editar(objPedido);
    end;

    LimparFormulario;

    if Result then
      MsgCrud(sAcao)

  finally
    objPedido.Free;
  end;
end;

function TfPedido.gravarItem: Boolean;
var
objPedidoItem : TPedidoITemVO;
begin
  objPedidoItem := TPedidoITemVO.Create();
  try
    TelaParaObjPedidoItem(objPedidoItem);
    TPedidoItemCCliente.Inserir(objPedidoItem);
    limpaProduto;
    gridCarregaItem;
    recalculaTotal;
  finally
    objPedidoItem.Free;
  end;

end;

function TfPedido.gravarReceita: Boolean;
var objReceita : TReceitaVO;
    objReceitaItem : TReceitaItemVO;
begin
    objReceita            := TReceitaVO.Create();
    objReceita.ID_PEDIDO  := StrToInt(edt_id.Text);
    objReceita.ID_TECNICO := StrToInt(edt_id_tecnico.Text);
    objReceita.ASSINADO   := 0;

    fdmt_pesquisaItem.First;
    while not(fdmt_pesquisaItem.eof) do
    begin
      if fdmt_pesquisaItem.FieldByName('Controle Especial').AsString = 'Sim' then
      begin
        objReceitaItem := TReceitaItemVO.Create();
        objReceitaItem.ID_PRODUTO :=  fdmt_pesquisaItem.FieldByName('id_produto').AsInteger;
        objReceita.ItemVO.add(objReceitaItem);
      end;
      fdmt_pesquisaItem.Next;
    end;
    tReceitaccliente.Inserir(objReceita);
    Aviso('Pedido salvo com sucesso!');
end;

procedure TfPedido.gridCarrega;
begin
  fdmt_pesquisaPadrao.close;
  fdmt_pesquisaPadrao := TPedidoCCliente.ConsultaGridPesquisa
    (eTexto.Text, fdmt_pesquisaPadrao);
end;

procedure TfPedido.gridCarregaItem;
begin
  fdmt_pesquisaItem.close;
  fdmt_pesquisaItem := TPedidoItemCCliente.ConsultaGridPesquisa
    (StrToIntDef(edt_id.Text,1), fdmt_pesquisaItem);
end;

procedure TfPedido.GridParaObjeto(objPedido: TPedidoVO);
begin
  if (fdmt_pesquisaPadrao.fields.FieldByName('Id').AsInteger) > 0 then
  begin
    TPedidoCCliente.ConsultaObjId(
              fdmt_pesquisaPadrao.fields.FieldByName('Id').AsInteger,
              objPedido);
  end;

end;

procedure TfPedido.habilitaPageControlItens(bSituacao: Boolean);
begin
  pgc_pedido.ActivePageIndex := 0;
  pgc_pedido.Pages[0].TabVisible := true;
  pgc_pedido.Pages[1].TabVisible := bSituacao;
end;

function TfPedido.inserir: Boolean;
begin
  edt_id_cliente.SetFocus;
  edt_data_abertura.Text := DateToStr(now);
  habilitaPageControlItens(false);
  recalculaTotal;
  btn_finalizar.Enabled := false;
end;

procedure TfPedido.limpaCliente;
begin
  edt_id_cliente.Clear;
  edt_nome_cliente.clear;
end;

procedure TfPedido.limpaProduto;
begin
  edt_id_produto.clear;
  edt_nome_produto.clear;
  edt_valor_produto.clear;
  edt_quantidade.Clear;
  edt_total_produto.Clear;
end;

procedure TfPedido.LimparFormulario;
begin
  edt_id.Clear;
  edt_data_abertura.Clear;
  edt_total.Clear;
  limpaProduto;
  limpaCliente;
  limpaTecnico;
end;

procedure TfPedido.limpaTecnico;
begin
  edt_id_tecnico.Clear;
  edt_nome_tecnico.Clear;
end;

procedure TfPedido.ObjetoParaTela(objPedido: TPedidoVO);
begin
  edt_id.Text             := IntToStr(objPedido.ID);
  edt_id_cliente.Text     := IntToStr(objPedido.ID_CLIENTE);
  edt_id_tecnico.Text     := IntToStr(objPedido.ID_TECNICO);
  edt_total.Text          := CurrToStr(objPedido.TOTAL);
  edt_data_abertura.Text  := DateToStr(objPedido.DATA_ABERTURA);
  edt_nome_cliente.Text   := objPedido.ClienteVO.nome;
  edt_nome_Tecnico.Text   := objPedido.TecnicoVO.nome;
end;

procedure TfPedido.pesquisaCliente;
var
  fPesquisa : TfPesquisa;
begin
  fPesquisa := TfPesquisa.Create(Self);
  with fPesquisa do
  begin
    try
      lb_titulo.Caption   := 'Pesquisa de Cliente.';
      sTabela := 'Cliente';
      if  ShowModal = mrOk then
      begin
        edt_id_cliente.Text   := fdmt_pesquisaPadrao.FieldByName('Id').AsString;
        edt_nome_cliente.Text := fdmt_pesquisaPadrao.FieldByName('Nome').AsString;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TfPedido.pesquisaClienteId(id: Integer);
var objCliente : TClienteVO;
begin
  try
    objCliente := TClienteVO.Create;
    TClienteCCliente.ConsultaObjId(Id, objCliente);
    if objCliente.ID > 0 then
    begin
      edt_id_cliente.Text       := IntToStr(objCliente.ID);
      edt_nome_cliente.Text     := objCliente.NOME;
    end
    else
    begin
      Erro('Cliente não encontrado!');
      limpaCliente;
    end;
  finally
    objCliente.Free;
  end;
end;

procedure TfPedido.pesquisaProduto;
var
  fPesquisa : TfPesquisa;
begin
  fPesquisa := TfPesquisa.Create(Self);
  with fPesquisa do
  begin
    try
      lb_titulo.Caption   := 'Pesquisa de Produto.';
      sTabela := 'Produto';
      if  ShowModal = mrOk then
      begin
        edt_id_produto.Text    := fdmt_pesquisaPadrao.FieldByName('Id').AsString;
        edt_nome_produto.Text  := fdmt_pesquisaPadrao.FieldByName('Nome').AsString;
        edt_valor_produto.Text := fdmt_pesquisaPadrao.FieldByName('Valor').AsString;
        if fdmt_pesquisaPadrao.FieldByName('Especial').AsString = 'Sim' then
          cb_especial.ItemIndex  := 1
        else
          cb_especial.ItemIndex  := 0;
        edt_quantidade.SetFocus;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TfPedido.pesquisaProdutoId(id: Integer);
var objProduto : TProdutoVO;
begin
  try
    objProduto := TProdutoVO.Create;
    TProdutoCCliente.ConsultaObjId(Id, objProduto);
    if(objProduto.ID >0) then
    begin
      edt_id_produto.Text     := IntToStr(objProduto.ID);
      edt_nome_produto.Text   := objProduto.NOME;
      edt_valor_produto.Text  := MaskReal(CurrToStr(objProduto.VALOR));
      cb_especial.ItemIndex  :=  objProduto.CONTROLE_ESP;
    end
    else
    begin
      showmessage('Produto Não Encontrado');
      limpaProduto;
    end;
  finally
    objProduto.Free;
  end;
end;

procedure TfPedido.pesquisaTecnico;
var
  fPesquisa : TfPesquisa;
begin
  fPesquisa := TfPesquisa.Create(Self);
  with fPesquisa do
  begin
    try
      lb_titulo.Caption   := 'Pesquisa de Tecnico.';
      sTabela := 'Tecnico';
      if  ShowModal = mrOk then
      begin
        edt_id_tecnico.Text    := fdmt_pesquisaPadrao.FieldByName('Id').AsString;
        edt_nome_tecnico.Text  := fdmt_pesquisaPadrao.FieldByName('Nome').AsString;
      end;
    finally
      Free;
    end;
  end;
end;

procedure TfPedido.pesquisaTecnicoId(id: Integer);
var objTecnico : TTecnicoVO;
begin
  try
    objTecnico := TTecnicoVO.Create;
    TTecnicoCCliente.ConsultaObjId(Id, objTecnico);
    if(objTecnico.ID >0) then
    begin
      edt_id_tecnico.Text     := IntToStr(objTecnico.ID);
      edt_nome_tecnico.Text   := objTecnico.NOME;
    end
    else
    begin
      showmessage('Tecnico Nã0 Encontrado');
      limpaProduto;
    end;
  finally
    objTecnico.Free;
  end;
end;

procedure TfPedido.recalculaTotal;
var cTotal:Currency;
begin
  cTotal := 0;
  if fdmt_pesquisaItem.RecordCount > 0 then
  begin
    fdmt_pesquisaItem.First;
    while not(fdmt_pesquisaItem.eof) do
    begin
      cTotal := cTotal + fdmt_pesquisaItem.FieldByName('total').AsCurrency;
      fdmt_pesquisaItem.Next;
    end;
  end;
  edt_total.Text := MaskReal(CurrToStr(cTotal));
end;

procedure TfPedido.TelaParaObjPedido(objPedido: TPedidoVO);
begin
  objPedido.ID             := StrToIntDef(edt_id.Text,0);
  objPedido.ID_CLIENTE     := StrToIntDef(edt_id_cliente.Text,0);
  objPedido.ID_TECNICO     := StrToIntDef(edt_id_tecnico.Text,0);
  objPedido.TOTAL          := StrToCurrDef(edt_total.Text,0);
  objPedido.DATA_ABERTURA  := StrToDate(edt_data_abertura.Text);
end;

function TfPedido.TelaParaObjPedidoItem(
  objPedidoItem: TPedidoItemVO): TPedidoItemVO;
begin
  objPedidoItem.ID_PEDIDO    := StrToIntDef(edt_id.Text,0);
  objPedidoItem.ID_PRODUTO   := StrToIntDef(edt_id_produto.Text,0);
  objPedidoItem.VALOR        := StrToCurrDef(edt_valor_produto.Text,0);
  objPedidoItem.QUANTIDADE   := StrToCurrDef(edt_quantidade.Text,0);
  objPedidoItem.TOTAL        := StrToCurrDef(edt_total_produto.Text,0);
  objPedidoItem.CONTROLE_ESP := cb_especial.ItemIndex;
  result                     := objPedidoItem;
end;

function TfPedido.validaFinalizacao: Boolean;
var bResu: Boolean;
begin
  bResu := true;
  if not(fdmt_pesquisaItem.RecordCount > 0) then
  begin
    erro('Não e possivel finalizar pedido zerado');
    bResu := false;
  end;

  if not(StrToIntdef(edt_id_cliente.Text,0) > 0) then
  begin
    erro('Não e possivel finalizar pedido sem cliente');
    bResu := false;
  end;


  if verificaProdutoEspecial and not(StrToIntdef(edt_id_tecnico.Text,0) > 0) then
  begin
    erro('Este pedido contem produtos de controle especial! '+#13+
                'Inforne um tecnico para poder finalizar.');
    bResu := false;
  end;

  result := bResu;

end;

function TfPedido.verificaProdutoEspecial: Boolean;
var bResu: Boolean;
begin
  bResu := false;
  if fdmt_pesquisaItem.RecordCount > 0 then
  begin
    fdmt_pesquisaItem.First;
    while not(fdmt_pesquisaItem.eof) do
    begin
      if fdmt_pesquisaItem.FieldByName('Controle Especial').AsString = 'Sim' then
        bResu := true;

      fdmt_pesquisaItem.Next;
    end;
  end;
  Result := bResu;
end;

end.
