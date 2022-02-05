program ERP;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uBasico in 'uBasico.pas' {frmBasico},
  uClientes in 'uClientes.pas' {frmClientes},
  uProdutos in 'uProdutos.pas' {frmProdutos},
  udmDados in 'udmDados.pas' {dmDados: TDataModule},
  uVendas in 'uVendas.pas' {frmVendas},
  uSolicitacaoReceita in 'uSolicitacaoReceita.pas' {frmSolicitacaoReceita},
  uFuncoes in 'uFuncoes.pas',
  uPesquisa in 'uPesquisa.pas' {frmPesquisa};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
