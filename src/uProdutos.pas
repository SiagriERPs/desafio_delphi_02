unit uProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBasico, Vcl.StdCtrls, Data.DB,
  Datasnap.DBClient, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrmProdutos = class(TfrmBasico)
    qryTabelaPROD_ID: TIntegerField;
    qryTabelaPROD_NOME: TStringField;
    qryTabelaPROD_VALOR: TFMTBCDField;
    qryTabelaPROD_CONTROLE: TStringField;
    Label2: TLabel;
    Label3: TLabel;
    edtValor: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryTabelaAfterInsert(DataSet: TDataSet);
  private
    function ValidaDados() : Boolean;
  public
    { Public declarations }
  end;

var
  frmProdutos: TfrmProdutos;

implementation

{$R *.dfm}

procedure TfrmProdutos.btnSalvarClick(Sender: TObject);
begin
  if not ValidaDados() then Exit;
  inherited;
end;

procedure TfrmProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  GeneID := 'PROD_ID';
  Table  := 'PRODUTOS';
end;

procedure TfrmProdutos.FormShow(Sender: TObject);
begin
  SQL := 'SELECT * FROM PRODUTOS ORDER BY PROD_ID DESC';
  inherited;
end;

procedure TfrmProdutos.qryTabelaAfterInsert(DataSet: TDataSet);
begin
  qryTabela.FieldByName('PROD_CONTROLE').AsString := 'N';
  inherited;
end;

function TfrmProdutos.ValidaDados: Boolean;
begin
  Result := false;
  if Trim(edtNome.Text) = '' then begin
    ShowMessage('Necessário informar um nome antes de continuar!');
    if edtNome.CanFocus then
      edtNome.SetFocus;
    Exit;
  end;
  if edtValor.DataSource.DataSet.FieldByName(edtValor.DataField).AsFloat = 0 then
  begin
    ShowMessage('Informe o valor do produto antes de continuar!');
    if edtValor.CanFocus then
      edtValor.SetFocus;
    Exit;
  end;

  Result := true;
end;

initialization
  frmProdutos := TfrmProdutos.Create(nil);
finalization
  FreeAndNil(frmProdutos);

end.
