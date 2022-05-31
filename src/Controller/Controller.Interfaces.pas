unit Controller.Interfaces;

interface

uses
  Model.DAO.Interfaces,Model.Entidade.Cliente,Model.Entidade.Produto,
  Model.Entidade.VendaCabecalho,Model.Entidade.VendaDetalhe,
  Model.Entidade.TecnicoAgricola;

  type
  iControllerEntidades = interface
    function Cliente : iDAOEntidade<TCliente>;
    function Produto : iDAOEntidade<TProduto>;
    function VendaCabecalho: iDAOEntidade<TVendaCabecalho>;
    function VendaDetalhe: iDAOEntidade<TVendaDetalhe>;
    function TecnicoAgricola: iDAOEntidade<TTecnicoAgricola>;
  end;

  iController = interface
    function Entidades:iControllerEntidades;
  end;



implementation

end.
