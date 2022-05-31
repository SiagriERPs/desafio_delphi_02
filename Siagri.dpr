program Siagri;

uses
  Vcl.Forms,
  Biblioteca in 'src\Infra\Biblioteca.pas',
  Tipos in 'src\Infra\Tipos.pas',
  UDatamoduleGeral in 'src\Infra\UDatamoduleGeral.pas' {DataModuleGeral: TDataModule},
  Model.Conexao.Firedac in 'src\Model\Conexao\Model.Conexao.Firedac.pas',
  Model.Conexao.Interfaces in 'src\Model\Conexao\Model.Conexao.Interfaces.pas',
  Model.Entidade.Cliente in 'src\Model\Entidades\Model.Entidade.Cliente.pas',
  Model.Entidade.Produto in 'src\Model\Entidades\Model.Entidade.Produto.pas',
  Model.Entidade.TecnicoAgricola in 'src\Model\Entidades\Model.Entidade.TecnicoAgricola.pas',
  Model.Entidade.VendaCabecalho in 'src\Model\Entidades\Model.Entidade.VendaCabecalho.pas',
  Model.Entidade.VendaDetalhe in 'src\Model\Entidades\Model.Entidade.VendaDetalhe.pas',
  Model.DAO.Interfaces in 'src\Model\DAO\Model.DAO.Interfaces.pas',
  Model.DAOCliente in 'src\Model\DAO\Model.DAOCliente.pas',
  Model.DAOProduto in 'src\Model\DAO\Model.DAOProduto.pas',
  Model.DAOTecnicoAgricola in 'src\Model\DAO\Model.DAOTecnicoAgricola.pas',
  Model.DAOVendaCabecalho in 'src\Model\DAO\Model.DAOVendaCabecalho.pas',
  Model.DAOVendaDetalhe in 'src\Model\DAO\Model.DAOVendaDetalhe.pas',
  Controller.Controller in 'src\Controller\Controller.Controller.pas',
  Controller.Entidades in 'src\Controller\Controller.Entidades.pas',
  Controller.Interfaces in 'src\Controller\Controller.Interfaces.pas',
  Controller.VendaCabecalho in 'src\Controller\Controller.VendaCabecalho.pas',
  UMenu in 'src\View\UMenu.pas' {FMenu},
  UViewPadrao in 'src\View\UViewPadrao.pas' {FPadrao},
  UViewPadraoDetalhe in 'src\View\UViewPadraoDetalhe.pas' {FPadraoDetalhe},
  UViewPadraoPesquisa in 'src\View\UViewPadraoPesquisa.pas' {FormPadraoPesquisa},
  View.Cliente in 'src\View\View.Cliente.pas' {FormCliente},
  View.Cliente.Pesquisa in 'src\View\View.Cliente.Pesquisa.pas' {FormClientePesquisa},
  View.ConferenciaReceita in 'src\View\View.ConferenciaReceita.pas' {FormConferenciaReceita},
  View.Produto in 'src\View\View.Produto.pas' {FormProduto},
  View.Produto.Pesquisa in 'src\View\View.Produto.Pesquisa.pas' {FormProdutoPesquisa},
  View.TecnicoAgricola.Pesquisa in 'src\View\View.TecnicoAgricola.Pesquisa.pas' {FormTecnicoAgricolaPesquisa},
  View.Venda in 'src\View\View.Venda.pas' {FormVenda},
  View.VendaDetalhe in 'src\View\View.VendaDetalhe.pas' {FormVendaDetalhe};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModuleGeral, DataModuleGeral);
  Application.CreateForm(TFMenu, FMenu);
  Application.CreateForm(TFPadraoDetalhe, FPadraoDetalhe);
  Application.CreateForm(TFormPadraoPesquisa, FormPadraoPesquisa);
  Application.CreateForm(TFormCliente, FormCliente);
  Application.CreateForm(TFormClientePesquisa, FormClientePesquisa);
  Application.CreateForm(TFormConferenciaReceita, FormConferenciaReceita);
  Application.CreateForm(TFormProduto, FormProduto);
  Application.CreateForm(TFormProdutoPesquisa, FormProdutoPesquisa);
  Application.CreateForm(TFormTecnicoAgricolaPesquisa, FormTecnicoAgricolaPesquisa);
  Application.CreateForm(TFormVenda, FormVenda);
  Application.CreateForm(TFormVendaDetalhe, FormVendaDetalhe);
  Application.Run;
end.
