unit UViewPadraoPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids,Controller.Controller,Controller.Interfaces;

type
  TFormPadraoPesquisa = class(TForm)
    GroupBox1: TGroupBox;
    Grid: TDBGrid;
    DsGrid: TDataSource;
    GroupBoxPesquisa: TGroupBox;
    LabelPesquisa: TLabel;
    EditPesquisa: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure EditPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure PesquisaPadrao(Ds: TDataSet; Grid: TDBGrid; Pesquisa: String);
  public
    { Public declarations }
    FController:iController;
    procedure ListarRegistros;virtual;
    procedure AjustarLayoutGrid;virtual;

  end;

var
  FormPadraoPesquisa: TFormPadraoPesquisa;

implementation

{$R *.dfm}

{ TFormPadraoPesquisa }

procedure TFormPadraoPesquisa.AjustarLayoutGrid;
begin

end;

procedure TFormPadraoPesquisa.EditPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
  begin
    PesquisaPadrao(DsGrid.DataSet,Grid,EditPesquisa.Text);
    Grid.SetFocus;
  end;
end;

procedure TFormPadraoPesquisa.FormCreate(Sender: TObject);
begin
  FController:=TController.New;
  ListarRegistros;
  AjustarLayoutGrid;
end;

procedure TFormPadraoPesquisa.FormShow(Sender: TObject);
begin
  EditPesquisa.SetFocus;
end;

procedure TFormPadraoPesquisa.ListarRegistros;
begin

end;

procedure TFormPadraoPesquisa.PesquisaPadrao(Ds: TDataSet; Grid: TDBGrid; Pesquisa: String);
var NomeCampo:String;
IdentificaTipoFiltro:Integer;
begin
  NomeCampo:=Grid.Columns.Grid.SelectedField.FieldName;
  IdentificaTipoFiltro:=Grid.Columns.Grid.SelectedField.Tag;
  // Se Tag = 0 entao o filtro será exato . Se Tag = 1 entao o filtro será com like
  begin
    ds.Filtered:=false;
    if Pesquisa <> '' then
    begin
      ds.FilterOptions := [foCaseInsensitive];
      if IdentificaTipoFiltro = 0 then
      ds.Filter:=NomeCampo+' LIKE '+QuotedStr('%'+Pesquisa+'%')
      else
      ds.Filter:=NomeCampo+' = '+QuotedStr(Pesquisa);

      ds.Filtered:=true;

      if ds.RecordCount > 0 then
      Grid.SetFocus
      else
      Showmessage('Nenhum dado encontrado com estes parametros de pesquisa');

    end;
  end;
end;

end.
