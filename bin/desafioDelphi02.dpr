program desafioDelphi02;

uses
  Vcl.Forms,
  unit_fPadrao in '..\src\2-view\unit_fPadrao.pas' {fPadrao},
  unit_fMenu in '..\src\2-view\unit_fMenu.pas' {fMenu},
  unit_fCliente in '..\src\2-view\unit_fCliente.pas' {fCliente},
  ClienteCCliente in '..\src\3-Controller\ClienteCCliente.pas',
  ClienteVO in '..\src\1-VO\ClienteVO.pas',
  ClienteCServidor in '..\src\4-ControllerServidor\ClienteCServidor.pas',
  FDConexao in '..\src\5-Conexao\FDConexao.pas' {DataModule1: TDataModule},
  unit_fPedido in '..\src\2-view\unit_fPedido.pas' {fPedido},
  PedidoVO in '..\src\1-VO\PedidoVO.pas',
  PedidoCServidor in '..\src\4-ControllerServidor\PedidoCServidor.pas',
  PedidoCCliente in '..\src\3-Controller\PedidoCCliente.pas',
  unit_fPesquisa in '..\src\2-view\unit_fPesquisa.pas' {fPesquisa},
  PesquisaCCliente in '..\src\3-Controller\PesquisaCCliente.pas',
  PedidoItemVO in '..\src\1-VO\PedidoItemVO.pas',
  PedidoItemCServidor in '..\src\4-ControllerServidor\PedidoItemCServidor.pas',
  PedidoItemCCliente in '..\src\3-Controller\PedidoItemCCliente.pas',
  biblioteca in '..\src\6-Comum\biblioteca.pas',
  ReceitaVO in '..\src\1-VO\ReceitaVO.pas',
  ReceitaItemVO in '..\src\1-VO\ReceitaItemVO.pas',
  ReceitaCServidor in '..\src\4-ControllerServidor\ReceitaCServidor.pas',
  ReceitaCCliente in '..\src\3-Controller\ReceitaCCliente.pas',
  ReceitaItemCServidor in '..\src\4-ControllerServidor\ReceitaItemCServidor.pas',
  TecnicoVO in '..\src\1-VO\TecnicoVO.pas',
  TecnicoCCliente in '..\src\3-Controller\TecnicoCCliente.pas',
  TecnicoCServidor in '..\src\4-ControllerServidor\TecnicoCServidor.pas',
  unit_fBaixaReceita in '..\src\2-view\unit_fBaixaReceita.pas' {FReceitaBaixa},
  ReceitaItemCCliente in '..\src\3-Controller\ReceitaItemCCliente.pas',
  ProdutoVO in '..\src\1-VO\ProdutoVO.pas',
  unit_fProduto in '..\src\2-view\unit_fProduto.pas' {fProduto},
  ProdutoCServidor in '..\src\4-ControllerServidor\ProdutoCServidor.pas',
  ProdutoCCliente in '..\src\3-Controller\ProdutoCCliente.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMenu, fMenu);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
