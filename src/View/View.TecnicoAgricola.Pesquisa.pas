unit View.TecnicoAgricola.Pesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UViewPadraoPesquisa, Data.DB,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TFormTecnicoAgricolaPesquisa = class(TFormPadraoPesquisa)
    procedure GridDblClick(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure PreencheDadosTecnicoAgricola;
  public
    { Public declarations }
    procedure ListarRegistros;override;
    procedure AjustarLayoutGrid;override;
  end;

var
  FormTecnicoAgricolaPesquisa: TFormTecnicoAgricolaPesquisa;

implementation

uses View.ConferenciaReceita;

{$R *.dfm}

{ TFormTecnicoAgricolaPesquisa }

procedure TFormTecnicoAgricolaPesquisa.AjustarLayoutGrid;
begin
  inherited;
  DsGrid.DataSet.FieldByName('ID').Visible:=false;
  DsGrid.DataSet.FieldByName('NOME').DisplayLabel:='Nome';
  DsGrid.DataSet.FieldByName('NOME').DisplayWidth:=80;
  DsGrid.DataSet.FieldByName('NUMERO_REGISTRO').DisplayWidth:=20;
  DsGrid.DataSet.FieldByName('NUMERO_REGISTRO').DisplayLabel:='Nome';
end;

procedure TFormTecnicoAgricolaPesquisa.GridDblClick(Sender: TObject);
begin
  inherited;
  PreencheDadosTecnicoAgricola;
end;

procedure TFormTecnicoAgricolaPesquisa.GridKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if key = #13 then
  PreencheDadosTecnicoAgricola;
end;

procedure TFormTecnicoAgricolaPesquisa.ListarRegistros;
begin
  inherited;
  FController
  .Entidades
  .TecnicoAgricola
  .ConsultarLista
  .DataSet(DsGrid);
end;

procedure TFormTecnicoAgricolaPesquisa.PreencheDadosTecnicoAgricola;
begin
  FormConferenciaReceita.IdTecnicoAgricolaSelecionado:=0;
  if DsGrid.DataSet.RecordCount > 0 then
  begin
    FormConferenciaReceita.IdTecnicoAgricolaSelecionado:=DsGrid.DataSet.Fieldbyname('ID').AsInteger;
    Close;
  end;
end;

end.
