unit uPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmPesquisa = class(TForm)
    Label1: TLabel;
    edtPesquisa: TEdit;
    DBGrid1: TDBGrid;
    btnOK: TSpeedButton;
    qryPesquisa: TFDQuery;
    dsPesquisa: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public

  end;

var
  frmPesquisa: TfrmPesquisa;

implementation

{$R *.dfm}

uses udmDados, uFuncoes, System.SysUtils;

procedure TfrmPesquisa.btnOKClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmPesquisa.DBGrid1DblClick(Sender: TObject);
begin
  btnOK.Click;
end;

procedure TfrmPesquisa.edtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  qryPesquisa.Filtered := false;
  qryPesquisa.Filter   := qryPesquisa.Fields[0].FieldName + ' LIKE ' + QuotedStr('%'+edtPesquisa.Text+'%');
  qryPesquisa.Filtered := true;
end;

procedure TfrmPesquisa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnOK.Click;
end;

procedure TfrmPesquisa.FormShow(Sender: TObject);
begin
  qryPesquisa.Fields.Clear;
  qryPesquisa.Filtered := false;
  qryPesquisa.Open();
  qryPesquisa.Fields[0].Visible := false;
  edtPesquisa.Clear;
  edtPesquisa.SetFocus;
end;

initialization
  frmPesquisa := TfrmPesquisa.Create(nil);
finalization
  FreeAndNil(frmPesquisa);

end.
