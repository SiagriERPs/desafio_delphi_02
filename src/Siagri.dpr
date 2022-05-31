program Siagri;

uses
  Vcl.Forms,
  Biblioteca in 'Infra\Biblioteca.pas',
  Tipos in 'Infra\Tipos.pas',
  UDatamoduleGeral in 'Infra\UDatamoduleGeral.pas' {DataModuleGeral: TDataModule},
  Model.Conexao.Firedac in 'Model\Conexao\Model.Conexao.Firedac.pas',
  Model.Conexao.Interfaces in 'Model\Conexao\Model.Conexao.Interfaces.pas',
  Model.DAO.Interfaces in 'Model\DAO\Model.DAO.Interfaces.pas',
  Model.DAOCliente in 'Model\DAO\Model.DAOCliente.pas',
  Model.DAOProduto in 'Model\DAO\Model.DAOProduto.pas',
  Model.DAOTecnicoAgricola in 'Model\DAO\Model.DAOTecnicoAgricola.pas',
  Model.DAOVendaCabecalho in 'Model\DAO\Model.DAOVendaCabecalho.pas',
  Model.DAOVendaDetalhe in 'Model\DAO\Model.DAOVendaDetalhe.pas',
  Model.Entidade.Cliente in 'Model\Entidades\Model.Entidade.Cliente.pas',
  Model.Entidade.Produto in 'Model\Entidades\Model.Entidade.Produto.pas',
  Model.Entidade.TecnicoAgricola in 'Model\Entidades\Model.Entidade.TecnicoAgricola.pas',
  Model.Entidade.VendaCabecalho in 'Model\Entidades\Model.Entidade.VendaCabecalho.pas',
  Model.Entidade.VendaDetalhe in 'Model\Entidades\Model.Entidade.VendaDetalhe.pas',
  Controller.Controller in 'Controller\Controller.Controller.pas',
  Controller.Entidades in 'Controller\Controller.Entidades.pas',
  Controller.Interfaces in 'Controller\Controller.Interfaces.pas',
  Controller.VendaCabecalho in 'Controller\Controller.VendaCabecalho.pas',
  UMenu in 'View\UMenu.pas' {FMenu},
  UViewPadrao in 'View\UViewPadrao.pas' {FPadrao},
  UViewPadraoDetalhe in 'View\UViewPadraoDetalhe.pas' {FPadraoDetalhe},
  UViewPadraoPesquisa in 'View\UViewPadraoPesquisa.pas' {FormPadraoPesquisa},
  View.Cliente in 'View\View.Cliente.pas' {FormCliente},
  View.Cliente.Pesquisa in 'View\View.Cliente.Pesquisa.pas' {FormClientePesquisa},
  View.ConferenciaReceita in 'View\View.ConferenciaReceita.pas' {FormConferenciaReceita},
  View.Produto in 'View\View.Produto.pas' {FormProduto},
  View.Produto.Pesquisa in 'View\View.Produto.Pesquisa.pas' {FormProdutoPesquisa},
  View.TecnicoAgricola.Pesquisa in 'View\View.TecnicoAgricola.Pesquisa.pas' {FormTecnicoAgricolaPesquisa},
  View.Venda in 'View\View.Venda.pas' {FormVenda},
  View.VendaDetalhe in 'View\View.VendaDetalhe.pas' {FormVendaDetalhe};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModuleGeral, DataModuleGeral);
  Application.CreateForm(TFMenu, FMenu);
  Application.Run;
end.
