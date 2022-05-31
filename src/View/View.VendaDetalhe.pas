unit View.VendaDetalhe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UViewPadraoDetalhe, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls,View.Venda,Tipos, Vcl.WinXCtrls,
  View.Produto.Pesquisa,Datasnap.DBClient,Data.DB,Biblioteca,Controller.VendaCabecalho;

type
  TFormVendaDetalhe = class(TFPadraoDetalhe)
    DBEditIdProduto: TDBEdit;
    DBEditValorUnitario: TDBEdit;
    DBEditQuantidade: TDBEdit;
    DBEditValorTotal: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    PesquisaProduto: TSearchBox;
    DBEditProdutoNome: TDBEdit;
    DBCheckBoxControleEspecial: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure BotaoConcluirClick(Sender: TObject);
    procedure BotaoVoltarClick(Sender: TObject);
    procedure PesquisaProdutoInvokeSearch(Sender: TObject);
    procedure DBEditQuantidadeChange(Sender: TObject);
    procedure DBEditValorUnitarioChange(Sender: TObject);
    procedure DBEditQuantidadeExit(Sender: TObject);
  private
    { Private declarations }
    FControllerVenda:TControllerVendaCabecalho;

  public
    { Public declarations }
  end;

var
  FormVendaDetalhe: TFormVendaDetalhe;

implementation

{$R *.dfm}

procedure TFormVendaDetalhe.BotaoConcluirClick(Sender: TObject);
begin
  if FControllerVenda.ValidarRegitroVendaDetalhe(View.Venda.FormVenda.CdsVendaDetalhe) then
  begin
    inherited;
    AcoesPadraoBotaoSalvar(View.Venda.FormVenda.CdsVendaDetalhe);
  end;
end;

procedure TFormVendaDetalhe.BotaoVoltarClick(Sender: TObject);
begin
  inherited;
  AcoesPadraoBotaoVoltar(View.Venda.FormVenda.CdsVendaDetalhe);
end;

procedure TFormVendaDetalhe.DBEditQuantidadeChange(Sender: TObject);
begin
  inherited;
  if DBEditQuantidade.Focused then
  Biblioteca.Formatar(DBEditQuantidade,Valor4);
end;

procedure TFormVendaDetalhe.DBEditQuantidadeExit(Sender: TObject);
begin
  inherited;
  FControllerVenda.CalcularValorTotalItem(FormVenda.CdsVendaDetalhe);
end;

procedure TFormVendaDetalhe.DBEditValorUnitarioChange(Sender: TObject);
begin
  inherited;
  if DBEditQuantidade.Focused then
  Biblioteca.Formatar(DBEditValorUnitario,Valor2);
end;

procedure TFormVendaDetalhe.FormCreate(Sender: TObject);
begin
  inherited;
  FControllerVenda:= TControllerVendaCabecalho.New;
  RegrasCriacaoFormulario(View.Venda.FormVenda.CdsVendaDetalhe);
end;

procedure TFormVendaDetalhe.PesquisaProdutoInvokeSearch(Sender: TObject);
begin
  inherited;
  Application.CreateForm(TFormProdutoPesquisa,FormProdutoPesquisa);
  FormProdutoPesquisa.ShowModal;
  FormProdutoPesquisa.Destroy;
  DBEditQuantidade.SetFocus;
end;

end.
