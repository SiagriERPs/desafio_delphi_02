unit uVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBasico, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids;

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
    Label8: TLabel;
    lbTotal: TLabel;
    qryTabelaPEDI_ID: TIntegerField;
    qryTabelaPEDI_CLIE_ID: TIntegerField;
    qryTabelaPEDI_TOTAL: TBCDField;
    qryTabelaPEDI_DT_CADASTRO: TDateField;
    qryTabelaPEDI_STATUS: TStringField;
    qryTabelaPEDI_CLIE_NOME: TStringField;
    qryTabelaPEDI_CLIE_CPF: TStringField;
    qryTabelaPEDI_ASSINADO: TStringField;
    qryTabelaPEDI_TECN_ID: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAdicionaClick(Sender: TObject);
    procedure qryItensCalcFields(DataSet: TDataSet);
    procedure qryTabelaAfterApplyUpdates(DataSet: TFDDataSet; AErrors: Integer);
    procedure qryItensAfterInsert(DataSet: TDataSet);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodItemExit(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBGrid2Enter(Sender: TObject);
    procedure btnRetiraClick(Sender: TObject);
    procedure qryTabelaNewRecord(DataSet: TDataSet);
    procedure btnNovoClick(Sender: TObject);
    procedure qryItensBeforePost(DataSet: TDataSet);
    procedure qryItensBeforeDelete(DataSet: TDataSet);
  private
    function ValidaItens: Boolean;
    function ValidaDados: Boolean;
    procedure OpenFDQuery;
    procedure TotalPedido(fltValor: Real = 0);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fltTotal : Real;
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

procedure TfrmVendas.btnNovoClick(Sender: TObject);
begin
  inherited;
  if edtCodCliente.CanFocus then
    edtCodCliente.SetFocus;
end;

procedure TfrmVendas.btnRetiraClick(Sender: TObject);
begin
  inherited;
  if not qryItens.IsEmpty then
    qryItens.Delete;
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
  try
    qryItens.DisableControls;
    qryItens.First;
    while not qryItens.Eof do
    begin
      if qryItens.FieldByName('ITEM_PROD_CONTROLE').AsString = 'S' then
      begin
        ShowMessage('A T E N Ç Ã O ! ! !'+#13#13+
                    'Um ou mais produto(s) possuem controle especial e vão precisar ser(em) assinado(s) por um técnico agrícola!');
        qryTabela.FieldByName('PEDI_ASSINADO').AsString := 'N';
        qryTabela.FieldByName('PEDI_STATUS').AsString   := 'A';
        Break;
      end;
      qryItens.Next;
    end;
  finally
    qryItens.EnableControls;
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
  if Trim(edtCodCliente.Text) = '' then Exit;
  if not edtCodCliente.Modified then Exit;
  if not (qryTabela.State in [dsEdit,dsInsert]) then Exit;
  inherited;
  dmDados.PesquisaCliente(qryTabela,edtCodCliente.Text);
end;

procedure TfrmVendas.edtCodItemExit(Sender: TObject);
begin
  if Trim(edtCodItem.Text) = '' then Exit;
  if not edtCodItem.Modified then Exit;
  if not (qryItens.State in [dsEdit,dsInsert]) then Exit;
  inherited;
  dmDados.PesquisaProduto(qryItens,edtCodItem.Text);
end;

procedure TfrmVendas.FormCreate(Sender: TObject);
begin
  inherited;
  GeneID := 'PEDI_ID';
  Table  := 'PEDIDOS';
end;

procedure TfrmVendas.FormShow(Sender: TObject);
begin
  SQL := 'SELECT * FROM PEDIDOS';
  inherited;
  qryTabela.Append;
  edtCodCliente.SetFocus;
end;

procedure TfrmVendas.TotalPedido(fltValor : Real = 0);
begin
  fltTotal := fltTotal + fltValor;
  lbTotal.Caption := FormatFloat('$#,##0.00',fltTotal);
end;

procedure TfrmVendas.qryItensAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryItens.FieldByName('ITEM_ID').AsInteger      := dmDados.Generation('ITENSPEDIDO');
  qryItens.FieldByName('ITEM_PEDI_ID').AsInteger := qryTabela.FieldByName('PEDI_ID').AsInteger;
end;

procedure TfrmVendas.qryItensBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  TotalPedido(qryItensTOTAL_ITEM.AsFloat*-1);
end;

procedure TfrmVendas.qryItensBeforePost(DataSet: TDataSet);
begin
  inherited;
  TotalPedido(qryItensTOTAL_ITEM.AsFloat);
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

procedure TfrmVendas.qryTabelaNewRecord(DataSet: TDataSet);
begin
  inherited;
  qryTabela.FieldByName('PEDI_DT_CADASTRO').AsDateTime := Now;
  qryTabela.FieldByName('PEDI_STATUS').AsString        := 'C';
  OpenFDQuery;
  fltTotal := 0;
  TotalPedido();
end;

procedure TfrmVendas.OpenFDQuery;
begin
  qryItens.Close;
  qryItens.ParamByName('PEDI_ID').AsInteger := qryTabela.FieldByName('PEDI_ID').AsInteger;
  qryItens.Open();
end;

initialization
  frmVendas := TfrmVendas.Create(nil);
finalization
  FreeAndNil(frmVendas);

end.
