unit uVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBasico, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids;

const
  SQL  = 'SELECT * FROM PEDIDOS ORDER BY PEDI_ID DESC';

type
  TfrmVendas = class(TfrmBasico)
    qryItens: TFDQuery;
    dsItens: TDataSource;
    qryItensITEM_ID: TIntegerField;
    qryItensITEM_PEDI_ID: TIntegerField;
    qryItensITEM_PROD_ID: TIntegerField;
    qryItensITEM_QTDADE: TFMTBCDField;
    qryItensITEM_VLRUNIT: TFMTBCDField;
    qryItensITEM_PROD_NOME: TStringField;
    qryItensITEM_PROD_CONTROLE: TStringField;
    qryItensITEM_TOTAL: TBCDField;
    Label2: TLabel;
    edtCodCliente: TDBEdit;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    Label5: TLabel;
    DBEdit3: TDBEdit;
    Itens: TGroupBox;
    Label6: TLabel;
    edtCodItem: TDBEdit;
    Label7: TLabel;
    edtNomeItem: TDBEdit;
    Label9: TLabel;
    edtQtdade: TDBEdit;
    Label10: TLabel;
    edtValor: TDBEdit;
    btnRetira: TButton;
    btnAdiciona: TButton;
    qryItensTOTAL_ITEM: TCurrencyField;
    qryTabelaPEDI_ID: TIntegerField;
    qryTabelaPEDI_CLIE_ID: TIntegerField;
    qryTabelaPEDI_TOTAL: TBCDField;
    qryTabelaPEDI_DT_CADASTRO: TDateField;
    qryTabelaPEDI_CLIE_NOME: TStringField;
    qryTabelaPEDI_CLIE_CPF: TStringField;
    qryTabelaPEDI_STATUS: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAdicionaClick(Sender: TObject);
    procedure qryTabelaAfterInsert(DataSet: TDataSet);
    procedure qryItensCalcFields(DataSet: TDataSet);
    procedure qryTabelaAfterApplyUpdates(DataSet: TFDDataSet; AErrors: Integer);
    procedure qryItensAfterInsert(DataSet: TDataSet);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodItemExit(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure qryTabelaBeforeOpen(DataSet: TDataSet);
    procedure DBGrid2Enter(Sender: TObject);
  private
    procedure PesquisaCliente;
    procedure PesquisaProduto;
    function ValidaItens: Boolean;
    function ValidaDados: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVendas: TfrmVendas;

implementation

{$R *.dfm}

uses udmDados;

procedure TfrmVendas.btnAdicionaClick(Sender: TObject);
begin
  if not ValidaItens() then Exit;
  inherited;
  if qryItens.State in [dsEdit,dsInsert] then
  begin
    qryItens.ApplyUpdates(-1);
    if edtCodItem.CanFocus then
      edtCodItem.SetFocus;
  end;
  qryItens.Append;
end;

function TfrmVendas.ValidaItens() : Boolean;
begin
  Result := false;
  if Trim(edtCodItem.Text) = '' then
  begin
    ShowMessage('Informe um produto antes de continuar!');
    if edtCodItem.CanFocus then
      edtCodItem.SetFocus;
    Exit;
  end;
  if edtQtdade.DataSource.DataSet.FieldByName(edtQtdade.DataField).AsFloat <= 0 then
  begin
    ShowMessage('Quantidade não pode ser menor ou igual a 0 ( Zero )!');
    if edtQtdade.CanFocus then
      edtQtdade.SetFocus;
    Exit;
  end;
  if edtValor.DataSource.DataSet.FieldByName(edtValor.DataField).AsFloat <= 0 then
  begin
    ShowMessage('Valor do Produto não pode ser menor ou igual a 0 ( Zero )!');
    if edtValor.CanFocus then
      edtValor.SetFocus;
    Exit;
  end;
  Result := true;
end;

procedure TfrmVendas.btnSalvarClick(Sender: TObject);
begin
  if not ValidaDados() then Exit;
  inherited;
end;

function TfrmVendas.ValidaDados() : Boolean;
begin
  Result := false;
  if (qryItens.State in [dsEdit,dsInsert]) then
    qryItens.Cancel;
  if qryTabela.FieldByName('PEDI_CLIE_ID').IsNull then begin
    ShowMessage('Informe um cliente antes de continuar!');
    if edtCodCliente.CanFocus then
      edtCodCliente.SetFocus;
    Exit;
  end;
  if qryItens.RecordCount <= 0 then
  begin
    ShowMessage('Necessário haver ao menos um 1 no pedido!');
    if edtCodItem.CanFocus then
      edtCodItem.SetFocus;
    Exit;
  end;
  Result := true;
end;

procedure TfrmVendas.DBGrid2Enter(Sender: TObject);
begin
  inherited;
  if (qryItens.State in [dsEdit,dsInsert]) and qryItens.FieldByName('ITEM_PROD_ID').IsNull then
    qryItens.Cancel;
end;

procedure TfrmVendas.edtCodClienteExit(Sender: TObject);
begin
  inherited;
  PesquisaCliente();
end;

procedure TfrmVendas.edtCodItemExit(Sender: TObject);
begin
  inherited;
  PesquisaProduto();
end;

procedure TfrmVendas.PesquisaProduto();
var
  qryCons : TFDQuery;
begin
  if Trim(edtCodItem.Text) = '' then Exit;
  if not edtCodItem.Modified then Exit;
  if not (qryItens.State in [dsEdit,dsInsert]) then Exit;
  try
    qryCons := TFDQuery.Create(nil);
    qryCons.Connection := dmDados.Conexao;
    qryCons.Close;
    qryCons.SQL.Clear;
    qryCons.sql.Add('SELECT PROD_NOME,PROD_VALOR,PROD_CONTROLE FROM PRODUTOS WHERE PROD_ID = ' + edtCodItem.Text);
    qryCons.Open();
    qryItens.FieldByName('ITEM_PROD_NOME').AsString     := qryCons.Fields[0].AsString;
    qryItens.FieldByName('ITEM_VLRUNIT').AsFloat        := qryCons.Fields[1].AsFloat;
    qryItens.FieldByName('ITEM_PROD_CONTROLE').AsString := qryCons.Fields[2].AsString;
  finally
    FreeAndNil(qryCons);
    edtCodItem.Modified := false;
  end;
end;

procedure TfrmVendas.PesquisaCliente();
var
  qryCons : TFDQuery;
begin
  if Trim(edtCodCliente.Text) = '' then Exit;
  if not edtCodCliente.Modified then Exit;
  if not (qryTabela.State in [dsEdit,dsInsert]) then Exit;
  try
    qryCons := TFDQuery.Create(nil);
    qryCons.Connection := dmDados.Conexao;
    qryCons.Close;
    qryCons.SQL.Clear;
    qryCons.sql.Add('SELECT CLIE_NOME,CLIE_CPF FROM CLIENTES WHERE CLIE_ID = ' + edtCodCliente.Text);
    qryCons.Open();
    qryTabela.FieldByName('PEDI_CLIE_NOME').AsString := qryCons.Fields[0].AsString;
    qryTabela.FieldByName('PEDI_CLIE_CPF').AsString  := qryCons.Fields[1].AsString;
  finally
    FreeAndNil(qryCons);
    edtCodCliente.Modified := false;
  end;
end;

procedure TfrmVendas.FormCreate(Sender: TObject);
begin
  inherited;
  GeneID := 'PEDI_ID';
  Table  := 'PEDIDOS';
end;

procedure TfrmVendas.FormShow(Sender: TObject);
begin
  qryTabela.SQL.Text := SQL;
  inherited;
  qryTabela.Append;
  edtCodCliente.SetFocus;
end;

procedure TfrmVendas.qryItensAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryItens.FieldByName('ITEM_ID').AsInteger      := dmDados.Generation('ITENSPEDIDO');
  qryItens.FieldByName('ITEM_PEDI_ID').AsInteger := qryTabela.FieldByName('PEDI_ID').AsInteger;
end;

procedure TfrmVendas.qryItensCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryItens.FieldByName('TOTAL_ITEM').AsFloat := qryItens.FieldByName('ITEM_QTDADE').AsFloat * qryItens.FieldByName('ITEM_VLRUNIT').AsFloat;
end;

procedure TfrmVendas.qryTabelaAfterApplyUpdates(DataSet: TFDDataSet;
  AErrors: Integer);
begin
  inherited;
  qryItens.ApplyUpdates(-1);
end;

procedure TfrmVendas.qryTabelaAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryTabela.FieldByName('PEDI_DT_CADASTRO').AsDateTime := Now;
  qryTabela.FieldByName('PEDI_STATUS').AsString        := 'C';
end;

procedure TfrmVendas.qryTabelaBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryItens.Close;
  qryItens.ParamByName('PEDI_ID').AsInteger := qryTabela.FieldByName('PEDI_ID').AsInteger;
  qryItens.Open();
end;

initialization
  frmVendas := TfrmVendas.Create(nil);
finalization
  FreeAndNil(frmVendas);

end.
