program desafioDelphi02Tests;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  Testunit_fCliente in 'Testunit_fCliente.pas',
  ClienteVO in '..\..\src\1-VO\ClienteVO.pas',
  unit_fCliente in '..\..\src\2-view\unit_fCliente.pas' {fCliente},
  unit_fPadrao in '..\..\src\2-view\unit_fPadrao.pas' {fPadrao},
  ClienteCCliente in '..\..\src\3-Controller\ClienteCCliente.pas',
  ClienteCServidor in '..\..\src\4-ControllerServidor\ClienteCServidor.pas',
  FDConexao in '..\..\src\5-Conexao\FDConexao.pas' {DataModule1: TDataModule},
  biblioteca in '..\..\src\6-Comum\biblioteca.pas',
  Testunit_fProduto in 'Testunit_fProduto.pas',
  ProdutoVO in '..\..\src\1-VO\ProdutoVO.pas',
  unit_fProduto in '..\..\src\2-view\unit_fProduto.pas' {fProduto},
  ProdutoCCliente in '..\..\src\3-Controller\ProdutoCCliente.pas',
  ProdutoCServidor in '..\..\src\4-ControllerServidor\ProdutoCServidor.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

