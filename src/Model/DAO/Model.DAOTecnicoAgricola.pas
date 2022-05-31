unit Model.DAOTecnicoAgricola;

interface
uses
  System.SysUtils,
  Model.DAO.Interfaces,
  Model.Entidade.TecnicoAgricola,
  Data.DB,
  Model.Conexao.Interfaces,
  Model.Conexao.Firedac;
type
  TDAOTecnicoAgricola = class(TInterfacedObject,iDAOEntidade<TTecnicoAgricola>)
  private
    FTecnicoAgricola : TTecnicoAgricola;
    FConexao: iConexao;
    FDataSet : TDataSet;
  public
    constructor Create;
    destructor Destroy;override;
    class function New : iDAOEntidade<TTecnicoAgricola>;
    function ConsultarLista : iDAOEntidade<TTecnicoAgricola>;overload;
    function ConsultarLista(IdCabecalho:Integer) : iDAOEntidade<TTecnicoAgricola>;overload;
    function ConsultaLista(Filtro:String): iDAOEntidade<TTecnicoAgricola>;overload;
    function ConsultaItemUnico(Id:Variant):iDAOEntidade<TTecnicoAgricola>;
    function ConsultaUltimoRegistroInserido:iDAOEntidade<TTecnicoAgricola>;
    function Excluir(Id:Integer):iDAOEntidade<TTecnicoAgricola>;overload;
    function Excluir:iDAOEntidade<TTecnicoAgricola>;overload;
    function Atualizar:iDAOEntidade<TTecnicoAgricola>;
    function Inserir:iDAOEntidade<TTecnicoAgricola>;
    function DataSet(DataSource:TDataSource):iDAOEntidade<TTecnicoAgricola>;
    function DataSet1(DataSet: TDataSet): iDAOEntidade<TTecnicoAgricola>;
    function This:TTecnicoAgricola;

  end;

implementation

{ TDAOTecnicoAgricola }

constructor TDAOTecnicoAgricola.Create;
begin
  FConexao:=TModelConexao.New;
  FTecnicoAgricola:= TTecnicoAgricola.Create(Self);
end;

destructor TDAOTecnicoAgricola.Destroy;
begin
  FTecnicoAgricola.Destroy;
  inherited;
end;

class function TDAOTecnicoAgricola.New: iDAOEntidade<TTecnicoAgricola>;
begin
  Result:=Self.Create;
end;

function TDAOTecnicoAgricola.ConsultarLista: iDAOEntidade<TTecnicoAgricola>;
begin
  Result:= Self;
  FDataSet:=
    FConexao
    .SQL('SELECT * FROM TECNICO_AGRICOLA ORDER BY ID DESC')
    .Open
    .DataSet;
end;

function TDAOTecnicoAgricola.ConsultaUltimoRegistroInserido: iDAOEntidade<TTecnicoAgricola>;
begin

end;

function TDAOTecnicoAgricola.ConsultaItemUnico(Id: Variant): iDAOEntidade<TTecnicoAgricola>;
begin
  Result:= Self;
  FDataSet:=
    FConexao
    .SQL('SELECT * FROM TECNICO_AGRICOLA WHERE ID=:ID')
    .Params('ID',Id)
    .Open
    .DataSet;
end;

function TDAOTecnicoAgricola.ConsultaLista(Filtro: String): iDAOEntidade<TTecnicoAgricola>;
begin
  Result:= Self;
  FDataSet:=
    FConexao
    .SQL('SELECT * FROM TECNICO_AGRICOLA WHERE '+Filtro)
    .Open
    .DataSet;
end;

function TDAOTecnicoAgricola.ConsultarLista(IdCabecalho: Integer): iDAOEntidade<TTecnicoAgricola>;
begin

end;

function TDAOTecnicoAgricola.Excluir(Id: Integer): iDAOEntidade<TTecnicoAgricola>;
begin

end;

function TDAOTecnicoAgricola.Excluir: iDAOEntidade<TTecnicoAgricola>;
begin

end;

function TDAOTecnicoAgricola.Atualizar: iDAOEntidade<TTecnicoAgricola>;
begin

end;

function TDAOTecnicoAgricola.Inserir: iDAOEntidade<TTecnicoAgricola>;
begin

end;

function TDAOTecnicoAgricola.DataSet(DataSource: TDataSource): iDAOEntidade<TTecnicoAgricola>;
begin
  Result := Self;
  if not Assigned(FDataSet) then
    DataSource.DataSet:= FConexao.DataSet
  else
    DataSource.DataSet:=FDataSet;
end;

function TDAOTecnicoAgricola.DataSet1(DataSet: TDataSet): iDAOEntidade<TTecnicoAgricola>;
begin

end;

function TDAOTecnicoAgricola.This: TTecnicoAgricola;
begin
  Result := FTecnicoAgricola;
end;

end.
