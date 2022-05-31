unit Model.DAO.Interfaces;

interface
uses Data.DB,Biblioteca;

type
  iDAOEntidade<T> = interface
    function ConsultarLista : iDAOEntidade<T>;overload;
    function ConsultarLista(IdCabecalho:Integer) : iDAOEntidade<T>;overload;
    function ConsultaLista(Filtro:String): iDAOEntidade<T>;overload;
    function ConsultaItemUnico(Id:Variant):iDAOEntidade<T>;
    function ConsultaUltimoRegistroInserido:iDAOEntidade<T>;
    function Excluir(Id:Integer):iDAOEntidade<T>;overload;
    function Excluir:iDAOEntidade<T>;overload;
    function Atualizar : iDAOEntidade<T>;
    function Inserir:iDAOEntidade<T>;
    function DataSet(DataSource:TDataSource):iDAOEntidade<T>;
    function DataSet1(DataSet: TDataSet): iDAOEntidade<T>;
    function This:T;
  end;

implementation

end.
