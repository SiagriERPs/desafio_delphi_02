unit UMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,View.Cliente,View.Produto,View.Venda,
  View.ConferenciaReceita;

type
  TFMenu = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Clientes1: TMenuItem;
    Produtos1: TMenuItem;
    Vendas1: TMenuItem;
    Vendas2: TMenuItem;
    Conferncia1: TMenuItem;
    VendascomsolicitaodeReceita1: TMenuItem;
    procedure Clientes1Click(Sender: TObject);
    procedure Produtos1Click(Sender: TObject);
    procedure Vendas2Click(Sender: TObject);
    procedure VendascomsolicitaodeReceita1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMenu: TFMenu;

implementation

{$R *.dfm}

procedure TFMenu.Clientes1Click(Sender: TObject);
begin
  Application.CreateForm(TFormCliente,FormCliente);
  FormCliente.ShowModal;
  FormCliente.Destroy;
end;

procedure TFMenu.Produtos1Click(Sender: TObject);
begin
  Application.CreateForm(TFormProduto,FormProduto);
  FormProduto.ShowModal;
  FormProduto.Destroy;
end;

procedure TFMenu.Vendas2Click(Sender: TObject);
begin
  Application.CreateForm(TFormVenda,FormVenda);
  FormVenda.ShowModal;
  FormVenda.Destroy;
end;

procedure TFMenu.VendascomsolicitaodeReceita1Click(Sender: TObject);
begin
  Application.CreateForm(TFormConferenciaReceita,FormConferenciaReceita);
  FormConferenciaReceita.ShowModal;
  FormConferenciaReceita.Destroy;
end;

end.
