unit uSolicitacaoReceita;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBasico, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TfrmSolicitacaoReceita = class(TfrmBasico)
    qryTabelaPEDI_ID: TIntegerField;
    qryTabelaPEDI_CLIE_ID: TIntegerField;
    qryTabelaPEDI_DT_CADASTRO: TDateField;
    qryTabelaPEDI_STATUS: TStringField;
    qryTabelaPEDI_TOTAL: TBCDField;
    qryTabelaPEDI_CLIE_NOME: TStringField;
    qryTabelaPEDI_CLIE_CPF: TStringField;
    qryTabelaPEDI_ASSINADO: TStringField;
    qryTabelaPEDI_TECN_ID: TIntegerField;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    Label5: TLabel;
    DBEdit3: TDBEdit;
    Label6: TLabel;
    DBEdit4: TDBEdit;
    Label7: TLabel;
    edtCodTecnico: TDBEdit;
    qryTabelaPEDI_TECN_NOME: TStringField;
    qryTabelaPEDI_TECN_CPF: TStringField;
    qryTabelaPEDI_TECN_NR_REGISTRO: TStringField;
    Label8: TLabel;
    DBEdit6: TDBEdit;
    Label9: TLabel;
    DBEdit7: TDBEdit;
    Label10: TLabel;
    DBEdit8: TDBEdit;
    Label11: TLabel;
    DBGrid1: TDBGrid;
    Label12: TLabel;
    qryItens: TFDQuery;
    qryItensITEM_ID: TIntegerField;
    qryItensITEM_PEDI_ID: TIntegerField;
    qryItensITEM_PROD_ID: TIntegerField;
    qryItensITEM_PROD_NOME: TStringField;
    qryItensITEM_PROD_CONTROLE: TStringField;
    qryItensITEM_QTDADE: TFMTBCDField;
    qryItensITEM_VLRUNIT: TFMTBCDField;
    qryItensITEM_TOTAL: TBCDField;
    qryItensTOTAL_ITEM: TCurrencyField;
    dsItens: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure edtCodTecnicoExit(Sender: TObject);
    procedure qryTabelaAfterScroll(DataSet: TDataSet);
    procedure btnNovoClick(Sender: TObject);
    procedure qryTabelaNewRecord(DataSet: TDataSet);
  private
    function ValidaDados: Boolean;
    procedure OpenFDQuery;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSolicitacaoReceita: TfrmSolicitacaoReceita;

implementation

{$R *.dfm}

uses udmDados, uFuncoes;

procedure TfrmSolicitacaoReceita.btnNovoClick(Sender: TObject);
begin
  Exit;
  inherited;
end;

procedure TfrmSolicitacaoReceita.btnSalvarClick(Sender: TObject);
begin
  if not ValidaDados() then Exit;
  inherited;
  OpenFDQuery;
end;

procedure TfrmSolicitacaoReceita.OpenFDQuery;
begin
  qryTabela.Close;
  qryTabela.Unprepare;
  qryTabela.Open;
end;

procedure TfrmSolicitacaoReceita.qryTabelaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  qryItens.Close;
  qryItens.ParamByName('PEDI_ID').AsInteger := qryTabela.FieldByName('PEDI_ID').AsInteger;
  qryItens.Open();
end;

procedure TfrmSolicitacaoReceita.qryTabelaNewRecord(DataSet: TDataSet);
begin
//  inherited;
end;

function TfrmSolicitacaoReceita.ValidaDados() : Boolean;
begin
  Result := false;
  if qryTabela.FieldByName('PEDI_TECN_ID').IsNull then
  begin
    ShowMessage('Informe o Técnico Agrícola que assinará este controle antes de continuar!');
    if edtCodTecnico.CanFocus then
      edtCodTecnico.SetFocus;
    Exit;
  end;
  if MessageDlg('Confirma a assinatura deste pedido?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
    Exit;
  qryTabela.FieldByName('PEDI_ASSINADO').AsString := 'S';
  qryTabela.FieldByName('PEDI_STATUS').AsString   := 'C';
  Result := true;
end;

procedure TfrmSolicitacaoReceita.edtCodTecnicoExit(Sender: TObject);
begin
  if not (qryTabela.State in [dsEdit,dsInsert]) then
    qryTabela.Edit;
  if Trim(edtCodTecnico.Text) = '' then Exit;
  if not edtCodTecnico.Modified then Exit;
  inherited;
  PesquisaTecnico(qryTabela,edtCodTecnico.Text);
end;

procedure TfrmSolicitacaoReceita.FormShow(Sender: TObject);
begin
  SQL := 'SELECT * FROM PEDIDOS WHERE PEDI_STATUS = ''A'' ORDER BY PEDI_ID DESC';
  inherited;
  if not qryTabela.IsEmpty then
    qryTabela.Edit;
end;

initialization
  frmSolicitacaoReceita := TfrmSolicitacaoReceita.Create(nil);
finalization
  FreeAndNil(frmSolicitacaoReceita);

end.
