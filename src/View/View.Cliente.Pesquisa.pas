unit View.Cliente.Pesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UViewPadraoPesquisa, Data.DB,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,Controller.Interfaces;

type
  TFormClientePesquisa = class(TFormPadraoPesquisa)
    procedure GridDblClick(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    //Controller:iController;
    procedure PreencheDadosCliente;
  public
    { Public declarations }
    procedure ListarRegistros;override;
    procedure AjustarLayoutGrid;override;
  end;

var
  FormClientePesquisa: TFormClientePesquisa;

implementation

uses
View.Venda;

{$R *.dfm}

{ TFormClientePesquisa }

procedure TFormClientePesquisa.AjustarLayoutGrid;
begin
  inherited;
  DsGrid.DataSet.FieldByName('ID').Visible:=false;
  DsGrid.DataSet.FieldByName('NOME').DisplayLabel:='Nome';
  DsGrid.DataSet.FieldByName('NOME').DisplayWidth:=80;
  DsGrid.DataSet.FieldByName('CPF').DisplayWidth:=20;
  DsGrid.DataSet.FieldByName('CPF').EditMask:='999.999.999-99;0; ';
end;

procedure TFormClientePesquisa.GridDblClick(Sender: TObject);
begin
  inherited;
  if DsGrid.DataSet.RecordCount > 0 then
  PreencheDadosCliente
end;

procedure TFormClientePesquisa.GridKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if key = #13 then
  if DsGrid.DataSet.RecordCount > 0 then
  PreencheDadosCliente;
end;

procedure TFormClientePesquisa.ListarRegistros;
begin
  inherited;
  FController
  .Entidades
  .Cliente
  .ConsultarLista
  .DataSet(DsGrid);
end;

procedure TFormClientePesquisa.PreencheDadosCliente;
begin
  FormVenda.EditIdCliente.Text:=DsGrid.DataSet.Fieldbyname('ID').AsString;
  FormVenda.EditClienteNome.Text:=DsGrid.DataSet.Fieldbyname('NOME').AsString;
  FormVenda.DBGridVendaDetalhe.SetFocus;
  Close;
end;

end.
