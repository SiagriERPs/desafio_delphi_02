unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons;

type
  TfrmPrincipal = class(TForm)
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uClientes, uProdutos, uVendas;

procedure TfrmPrincipal.SpeedButton1Click(Sender: TObject);
begin
  frmClientes.ShowModal;
end;

procedure TfrmPrincipal.SpeedButton2Click(Sender: TObject);
begin
  frmProdutos.ShowModal;
end;

procedure TfrmPrincipal.SpeedButton3Click(Sender: TObject);
begin
  frmVendas.ShowModal;
end;

end.
