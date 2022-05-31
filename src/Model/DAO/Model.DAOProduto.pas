unit Model.DAOProduto;

interface
uses
  System.SysUtils,
  Model.DAO.Interfaces,
  Model.Entidade.Produto,
  Data.DB,
  Model.Conexao.Interfaces,
  Model.Conexao.Firedac;
type
  TDAOProduto = class(TInterfacedObject,iDAOEntidade<TProduto>)
  private
    FProduto : TProduto;
    FConexao: iConexao;
    FDataSet : TDataSet;
    function VerificaPermissaoParaExclusaoProduto(IdProduto:Integer): boolean;
  public
    constructor Create;
    destructor Destroy;override;
    class function New : iDAOEntidade<TProduto>;
    function ConsultarLista : iDAOEntidade<TProduto>;overload;
    function ConsultarLista(IdCabecalho:Integer) : iDAOEntidade<TProduto>;overload;
    function ConsultaLista(Filtro:String): iDAOEntidade<TProduto>;overload;
    function ConsultaItemUnico(Id:Variant):iDAOEntidade<TProduto>;
    function ConsultaUltimoRegistroInserido:iDAOEntidade<TProduto>;
    function Excluir(Id:Integer):iDAOEntidade<TProduto>;overload;
    function Excluir:iDAOEntidade<TProduto>;overload;
    function Atualizar:iDAOEntidade<TProduto>;
    function Inserir:iDAOEntidade<TProduto>;
    function DataSet(DataSource:TDataSource):iDAOEntidade<TProduto>;
    function DataSet1(DataSet: TDataSet): iDAOEntidade<TProduto>;
    function This:TProduto;

  end;

implementation

{ TDAOProduto }

constructor TDAOProduto.Create;
begin
  FConexao:=TModelConexao.New;
  FProduto:= TProduto.Create(Self);
end;

destructor TDAOProduto.Destroy;
begin
  FProduto.Destroy;
  inherited;
end;

class function TDAOProduto.New: iDAOEntidade<TProduto>;
begin
  Result:=Self.Create;
end;

function TDAOProduto.ConsultarLista: iDAOEntidade<TProduto>;
begin
  Result:= Self;
  FDataSet:=
    FConexao
    .SQL('SELECT * FROM PRODUTO ORDER BY ID DESC')
    .Open
    .DataSet;
end;

function TDAOProduto.ConsultaUltimoRegistroInserido: iDAOEntidade<TProduto>;
begin
  Result:= Self;
  FDataSet:=
    FConexao
    .SQL('SELECT first 1 ID,NOME,VALOR,CONTROLE_ESPECIAL FROM PRODUTO ORDER BY ID DESC')
    .Open
    .DataSet;
end;

function TDAOProduto.ConsultaItemUnico(Id: Variant): iDAOEntidade<TProduto>;
begin
  Result:= Self;
  FDataSet:=
    FConexao
    .SQL('SELECT * FROM PRODUTO WHERE ID=:ID')
    .Params('ID',Id)
    .Open
    .DataSet;
end;

function TDAOProduto.ConsultaLista(Filtro: String): iDAOEntidade<TProduto>;
begin
  Result:= Self;
  FDataSet:=
    FConexao
    .SQL('SELECT * FROM PRODUTO WHERE '+Filtro)
    .Open
    .DataSet;
end;

function TDAOProduto.ConsultarLista(
  IdCabecalho: Integer): iDAOEntidade<TProduto>;
begin

end;

function TDAOProduto.Excluir(Id: Integer): iDAOEntidade<TProduto>;
begin
  Result:= Self;
  try
    if VerificaPermissaoParaExclusaoProduto(Id) = false then
    raise Exception.Create('Este produto não pode ser excluído porque já existem vendas vinculadas a este produto!');
    FConexao.SQL('DELETE FROM PRODUTO WHERE ID=:ID')
    .Params('ID',Id)
    .ExecSQL;
  except on e:Exception do
    raise Exception.Create('Erro ao tentar deletar registros: '+e.Message);
  end;
end;

function TDAOProduto.Excluir: iDAOEntidade<TProduto>;
begin
  Result := Self;
  try
    if VerificaPermissaoParaExclusaoProduto(FProduto.Id) = false then
    raise Exception.Create('Este produto não pode ser excluído porque já existem vendas vinculadas a este produto!');
    FConexao
    .SQL('DELETE FROM PRODUTO WHERE ID=:ID')
    .Params('ID',FProduto.Id)
    .ExecSQL;
  except on e:Exception do
    raise Exception.Create('Error ao tentar exluir o registro: '+e.Message);
  end;
end;

function TDAOProduto.Atualizar: iDAOEntidade<TProduto>;
begin
  Result := Self;
  try
    FConexao
      .SQL('UPDATE PRODUTO SET NOME=:NOME,VALOR=:VALOR,CONTROLE_ESPECIAL=:CONTROLE_ESPECIAL WHERE ID=:ID')
      .Params('NOME',FProduto.Nome)
      .Params('VALOR',FProduto.Valor)
      .Params('CONTROLE_ESPECIAL',FProduto.ControleEspecial)
      .Params('ID',FProduto.Id)
      .ExecSQL;
  except on e:Exception do
    raise Exception.Create('Error ao tentar atualizar o resgistro: '+e.Message);
  end;
end;

function TDAOProduto.Inserir: iDAOEntidade<TProduto>;
begin
  Result := Self;
  try
    FConexao
      .SQL('INSERT INTO PRODUTO (NOME,VALOR,CONTROLE_ESPECIAL) VALUES (:NOME,:VALOR,:CONTROLE_ESPECIAL)')
      .Params('NOME',FProduto.Nome)
      .Params('VALOR',FProduto.Valor)
      .Params('CONTROLE_ESPECIAL',FProduto.ControleEspecial)
      .ExecSQL;

      FConexao
      .SQL('SELECT first 1 ID,NOME,VALOR,CONTROLE_ESPECIAL FROM PRODUTO ORDER BY ID DESC')
      .Open
      .DataSet;


  except on e:Exception do
    raise Exception.Create('Erro ao tentar inserir os dados: '+ e.Message);
  end;
end;

function TDAOProduto.DataSet(DataSource: TDataSource): iDAOEntidade<TProduto>;
begin
  Result := Self;
  if not Assigned(FDataSet) then
    DataSource.DataSet:= FConexao.DataSet
  else
    DataSource.DataSet:=FDataSet;
end;

function TDAOProduto.DataSet1(DataSet: TDataSet): iDAOEntidade<TProduto>;
begin

end;

function TDAOProduto.This: TProduto;
begin
  Result := FProduto;
end;


function TDAOProduto.VerificaPermissaoParaExclusaoProduto(IdProduto:Integer): boolean;
var Conexao:iConexao;
Ds:TDataSource;
begin
   Result:=true;
   try
     Ds:=TDataSource.Create(nil);
     Self.ConsultaLista(' ID IN (SELECT ID_PRODUTO FROM VENDA_DETALHE WHERE ID_PRODUTO = '+IdProduto.ToString+')').DataSet(Ds);
     //Conexao.SQL('SELECT * FROM venda_cabecalho where ID_CLIENTE = '+FCliente.Id.ToString).Open.DataSet(DS);
     if Ds.DataSet.RecordCount > 0 then
     Result:=False;
   finally
      Ds.Free;
   end;
end;

end.
