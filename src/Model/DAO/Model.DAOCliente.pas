unit Model.DAOCliente;

interface
uses
  System.SysUtils,
  Model.DAO.Interfaces,
  Model.Entidade.Cliente,
  Data.DB,
  Model.Conexao.Interfaces,
  Model.Conexao.Firedac,

  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;
type
  TDAOCliente = class(TInterfacedObject,iDAOEntidade<TCliente>)
  private
    FCliente : TCliente;
    FConexao: iConexao;
    FDataSet : TDataSet;
    FQuery:TFDQuery;
    function VerificaPermissaoParaExclusaoCliente(IdCliente:Integer):boolean;
  public

    constructor Create;
    destructor Destroy;override;
    class function New : iDAOEntidade<TCliente>;
    function ConsultarLista : iDAOEntidade<TCliente>;overload;
    function ConsultarLista(IdCabecalho:Integer) : iDAOEntidade<TCliente>;overload;
    function ConsultaLista(Filtro:String): iDAOEntidade<TCliente>;overload;

    function ConsultaItemUnico(Id:Variant):iDAOEntidade<TCliente>;
    function ConsultaUltimoRegistroInserido:iDAOEntidade<TCliente>;
    function Excluir(Id:Integer):iDAOEntidade<TCliente>;overload;
    function Excluir:iDAOEntidade<TCliente>;overload;
    function Atualizar:iDAOEntidade<TCliente>;
    function Inserir:iDAOEntidade<TCliente>;
    function DataSet(DataSource:TDataSource):iDAOEntidade<TCliente>;
    function This:TCliente;

    function DataSet1(DataSet: TDataSet): iDAOEntidade<TCliente>;


  end;

implementation

{ TDAOCliente }


function TDAOCliente.DataSet1(DataSet: TDataSet): iDAOEntidade<TCliente>;
begin
  Result := Self;
  if not Assigned(FDataSet) then
    DataSet:= FConexao.DataSet
  else
    DataSet:=FDataSet;
end;

constructor TDAOCliente.Create;
begin
  FConexao:=TModelConexao.New;
  FCliente:= TCliente.Create(Self);
end;

destructor TDAOCliente.Destroy;
begin
  FCliente.Destroy;
  inherited;
end;

class function TDAOCliente.New: iDAOEntidade<TCliente>;
begin
  Result:=Self.Create;
end;

function TDAOCliente.ConsultarLista: iDAOEntidade<TCliente>;
begin
  Result:= Self;
  FDataSet:=
    FConexao
    .SQL('SELECT * FROM CLIENTE ORDER BY ID DESC')
    .Open
    .DataSet;
end;

function TDAOCliente.ConsultaUltimoRegistroInserido: iDAOEntidade<TCliente>;
begin
  Result:= Self;
  FDataSet:=
    FConexao
    .SQL('SELECT first 1 ID,NOME,CPF FROM CLIENTE ORDER BY ID DESC')
    .Open
    .DataSet;
end;

function TDAOCliente.ConsultaItemUnico(Id: Variant): iDAOEntidade<TCliente>;
begin
  Result:= Self;
  FDataSet:=
    FConexao
    .SQL('SELECT * FROM CLIENTE WHERE ID=:ID')
    .Params('ID',Id)
    .Open
    .DataSet;
end;

function TDAOCliente.ConsultaLista(Filtro: String): iDAOEntidade<TCliente>;
begin
  Result:= Self;
  FDataSet:=
    FConexao
    .SQL('SELECT * FROM CLIENTE WHERE '+Filtro)
    .Open
    .DataSet;
end;

function TDAOCliente.ConsultarLista(IdCabecalho: Integer): iDAOEntidade<TCliente>;
begin

end;

function TDAOCliente.Excluir(Id: Integer): iDAOEntidade<TCliente>;
begin
  Result:= Self;
  try
    if VerificaPermissaoParaExclusaoCliente(Id) = false then
      raise Exception.Create('Este cliente não pode ser excluído porque já existem vendas feitas para ele!');
    FConexao.SQL('DELETE FROM CLIENTE WHERE ID=:ID')
    .Params('ID',Id)
    .ExecSQL;
  except on e:Exception do
    raise Exception.Create('Erro ao tentar deletar registros: '+e.Message);
  end;
end;

function TDAOCliente.Excluir: iDAOEntidade<TCliente>;

begin
  Result := Self;
  try
    if VerificaPermissaoParaExclusaoCliente(FCliente.Id) = false then
    raise Exception.Create('Este cliente não pode ser excluído porque já existem vendas feitas para ele!');
    FConexao
    .SQL('DELETE FROM CLIENTE WHERE ID=:ID')
    .Params('ID',FCliente.Id)
    .ExecSQL;
  except on e:Exception do
    raise Exception.Create('Error ao tentar exluir o registro: '+e.Message);
  end;
end;

function TDAOCliente.Atualizar: iDAOEntidade<TCliente>;
begin
  Result := Self;
  try
    FConexao
      .SQL('UPDATE CLIENTE SET NOME=:NOME,CPF=:CPF WHERE ID=:ID')
      .Params('NOME',FCliente.Nome)
      .Params('CPF',FCliente.Cpf)
      .Params('ID',FCliente.Id)
      .ExecSQL;
  except on e:Exception do
    raise Exception.Create('Error ao tentar atualizar o resgistro: '+e.Message);
  end;
end;

function TDAOCliente.Inserir: iDAOEntidade<TCliente>;
begin
  Result := Self;
  try
    FConexao
      .SQL('INSERT INTO CLIENTE (NOME,CPF) VALUES (:NOME,:CPF)')
      .Params('NOME', FCliente.Nome)
      .Params('CPF', FCliente.Cpf)
      .ExecSQL;

      FConexao
      .SQL('SELECT first 1 ID,NOME,CPF FROM CLIENTE ORDER BY ID DESC')
      .Open
      .DataSet;


  except on e:Exception do
    raise Exception.Create('Erro ao tentar inserir os dados: '+ e.Message);
  end;
end;

function TDAOCliente.DataSet(DataSource: TDataSource): iDAOEntidade<TCliente>;
begin
  Result := Self;
  if not Assigned(FDataSet) then
    DataSource.DataSet:= FConexao.DataSet
  else
    DataSource.DataSet:=FDataSet;
end;

function TDAOCliente.This: TCliente;
begin
  Result := FCliente;
end;

function TDAOCliente.VerificaPermissaoParaExclusaoCliente(IdCliente:Integer): boolean;
var Conexao:iConexao;
Ds:TDataSource;
begin
   Result:=true;
   try
     Ds:=TDataSource.Create(nil);
     Self.ConsultaLista(' ID IN (SELECT ID_CLIENTE FROM VENDA_CABECALHO WHERE ID_CLIENTE = '+IdCliente.ToString+')').DataSet(Ds);
     //Conexao.SQL('SELECT * FROM venda_cabecalho where ID_CLIENTE = '+FCliente.Id.ToString).Open.DataSet(DS);
     if Ds.DataSet.RecordCount > 0 then
     Result:=False;
   finally
      Ds.Free;
   end;
end;

end.
