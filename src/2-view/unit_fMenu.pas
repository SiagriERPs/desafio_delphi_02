unit unit_fMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,unit_fPadrao, unit_fCliente,
  unit_fProduto, unit_fPedido, unit_fBaixaReceita;

type
  TfMenu = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    Venda1: TMenuItem;
    CadastrodeClientes1: TMenuItem;
    CadastrodeProdutos1: TMenuItem;
    Pedido1: TMenuItem;
    Receita1: TMenuItem;
    procedure base1Click(Sender: TObject);
    procedure CadastrodeClientes1Click(Sender: TObject);
    procedure CadastrodeProdutos1Click(Sender: TObject);
    procedure Pedido1Click(Sender: TObject);
    procedure Receita1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMenu: TfMenu;

implementation

{$R *.dfm}

procedure TfMenu.base1Click(Sender: TObject);
var fbase: TfPadrao;
begin
  fbase := TfPadrao.Create(nil);
  fbase.Show;
end;

procedure TfMenu.CadastrodeClientes1Click(Sender: TObject);
var fCliente : TfCliente;
begin
  fCliente := TfCliente.create(nil);
  fCliente.Show;
end;

procedure TfMenu.CadastrodeProdutos1Click(Sender: TObject);
var fProduto : TfProduto;
begin
  fProduto := TfProduto.create(self);
  fProduto.Show;
end;

procedure TfMenu.Pedido1Click(Sender: TObject);
var fPedido : TfPedido;
begin
  fPedido := TfPedido.create(nil);
  fPedido.Show;
end;

procedure TfMenu.Receita1Click(Sender: TObject);
var FReceitaBaixa : TFReceitaBaixa;
begin
  FReceitaBaixa := TFReceitaBaixa.create(self);
  FReceitaBaixa.Show;
end;

end.
