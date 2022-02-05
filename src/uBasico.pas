unit uBasico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Datasnap.DBClient,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrmBasico = class(TForm)
    btnSalvar: TButton;
    btnCancelar: TButton;
    Label1: TLabel;
    dsTabela: TDataSource;
    qryTabela: TFDQuery;
    edtCodigo: TDBEdit;
    Label4: TLabel;
    edtNome: TDBEdit;
    DBGrid2: TDBGrid;
    btnNovo: TButton;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryTabelaAfterInsert(DataSet: TDataSet);
    procedure dsTabelaDataChange(Sender: TObject; Field: TField);
    procedure btnNovoClick(Sender: TObject);
  private
  public
    GeneID,
    Table : String;
  end;

var
  frmBasico: TfrmBasico;

implementation

{$R *.dfm}

uses udmDados;

procedure TfrmBasico.btnNovoClick(Sender: TObject);
begin
  qryTabela.Append;
  if edtNome.CanFocus then
    edtNome.SetFocus;
end;

procedure TfrmBasico.btnSalvarClick(Sender: TObject);
begin
  try
    if (qryTabela.State in [dsEdit,dsInsert]) then
      qryTabela.ApplyUpdates(-1);
  except on e: exception do
    ShowMessage('Erro ao tentar salvar o registro!'+#13#13+'Error: '+e.Message);
  end;
end;

procedure TfrmBasico.dsTabelaDataChange(Sender: TObject; Field: TField);
begin
  if (TDataSource(Sender).DataSet.State in [dsEdit,dsInsert]) then
    btnSalvar.Enabled := true
  else btnSalvar.Enabled := false;
  btnNovo.Enabled := not btnSalvar.Enabled;
end;

procedure TfrmBasico.FormShow(Sender: TObject);
begin
  qryTabela.Active := true;
  if edtNome.CanFocus then
    edtNome.SetFocus;
end;

procedure TfrmBasico.qryTabelaAfterInsert(DataSet: TDataSet);
begin
  qryTabela.FieldByName(GeneID).AsInteger := dmDados.Generation(Table);
end;

procedure TfrmBasico.btnCancelarClick(Sender: TObject);
begin
  Self.Close;
end;

end.
