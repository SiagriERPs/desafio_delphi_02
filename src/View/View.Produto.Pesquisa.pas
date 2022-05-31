unit View.Produto.Pesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UViewPadraoPesquisa, Data.DB,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,BiBlioteca,Controller.VendaCabecalho;

type
  TFormProdutoPesquisa = class(TFormPadraoPesquisa)
    procedure GridDblClick(Sender: TObject);
    procedure GridKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FControllerVenda:TControllerVendaCabecalho;

    procedure PreencheDadosProduto;
    { Public declarations }
    procedure ListarRegistros;override;
    procedure AjustarLayoutGrid;override;
  end;

var
  FormProdutoPesquisa: TFormProdutoPesquisa;

implementation
uses View.VendaDetalhe,View.Venda;

{$R *.dfm}

{ TFormProdutoPesquisa }

procedure TFormProdutoPesquisa.AjustarLayoutGrid;
begin
  inherited;
  DsGrid.DataSet.FieldByName('NOME').DisplayLabel:='Nome';
  DsGrid.DataSet.FieldByName('NOME').DisplayWidth:=60;
  DsGrid.DataSet.FieldByName('VALOR').DisplayWidth:=20;
  DsGrid.DataSet.FieldByName('VALOR').DisplayLabel:='Valor';
  //DsGrid.DataSet.FieldByName('VALOR'):='0.00';
  DsGrid.DataSet.FieldByName('CONTROLE_ESPECIAL').visible:=false;
end;

procedure TFormProdutoPesquisa.FormCreate(Sender: TObject);
begin
  inherited;
  FControllerVenda:= TControllerVendaCabecalho.New;
end;

procedure TFormProdutoPesquisa.GridDblClick(Sender: TObject);
begin
  inherited;
  if DsGrid.DataSet.RecordCount > 0 then
  PreencheDadosProduto;
end;

procedure TFormProdutoPesquisa.GridKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if key = #13 then
  if DsGrid.DataSet.RecordCount > 0 then
  PreencheDadosProduto;
end;

procedure TFormProdutoPesquisa.ListarRegistros;
begin
  inherited;
  FController
  .Entidades
  .Produto
  .ConsultarLista
  .DataSet(DsGrid);
end;

procedure TFormProdutoPesquisa.PreencheDadosProduto;
begin
  if not(FormVenda.CdsVendaDetalhe.FieldByName('QUANTIDADE').AsFloat > 0) then
  FormVenda.CdsVendaDetalhe.FieldByName('QUANTIDADE').AsFloat:=1;
  FormVenda.CdsVendaDetalhe.FieldByName('ID_PRODUTO').AsInteger:=DsGrid.DataSet.Fieldbyname('ID').AsInteger;
  FormVenda.CdsVendaDetalhe.FieldByName('PRODUTONOME').AsString:=DsGrid.DataSet.Fieldbyname('NOME').AsString;
  FormVenda.CdsVendaDetalhe.FieldByName('CONTROLE_ESPECIAL').AsString:=DsGrid.DataSet.Fieldbyname('CONTROLE_ESPECIAL').AsString;
  FormVenda.CdsVendaDetalhe.FieldByName('VALOR_UNITARIO').AsFloat:=DsGrid.DataSet.Fieldbyname('VALOR').AsFloat;
  FControllerVenda.CalcularValorTotalItem(FormVenda.CdsVendaDetalhe);
  Close;
end;

end.
