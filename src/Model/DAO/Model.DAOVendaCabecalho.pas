unit Model.DAOVendaCabecalho;

interface
uses
  System.SysUtils,
  Model.DAO.Interfaces,
  Model.Entidade.VendaCabecalho,
  Data.DB,
  Model.Conexao.Interfaces,
  Model.Conexao.Firedac;
type
  TDAOVendaCabecalho = class(TInterfacedObject,iDAOEntidade<TVendaCabecalho>)
  private
    FVendaCabecalho : TVendaCabecalho;
    FConexao: iConexao;
    FDataSet : TDataSet;
  public
    constructor Create;
    destructor Destroy;override;
    class function New : iDAOEntidade<TVendaCabecalho>;


    function ConsultarLista : iDAOEntidade<TVendaCabecalho>;overload;
    function ConsultarLista(IdCabecalho:Integer) : iDAOEntidade<TVendaCabecalho>;overload;
    function ConsultaLista(Filtro:String): iDAOEntidade<TVendaCabecalho>;overload;
    function ConsultaItemUnico(Id:Variant):iDAOEntidade<TVendaCabecalho>;
    function ConsultaUltimoRegistroInserido:iDAOEntidade<TVendaCabecalho>;
    function Excluir(Id:Integer):iDAOEntidade<TVendaCabecalho>;overload;
    function Excluir:iDAOEntidade<TVendaCabecalho>;overload;
    function Atualizar:iDAOEntidade<TVendaCabecalho>;
    function Inserir:iDAOEntidade<TVendaCabecalho>;
    function DataSet(DataSource:TDataSource):iDAOEntidade<TVendaCabecalho>;
    function DataSet1(DataSet: TDataSet): iDAOEntidade<TVendaCabecalho>;
    function This:TVendaCabecalho;

    function AssinarReceita(IdVenda,IdTecnicoAgricola:Integer):iDAOEntidade<TVendaCabecalho>;

    function AtualizarStatus(IdVenda:Integer):iDAOEntidade<TVendaCabecalho>;

  end;

implementation

{ TDAOVendaCabecalho }

constructor TDAOVendaCabecalho.Create;
begin
  FConexao:=TModelConexao.New;
  FVendaCabecalho:= TVendaCabecalho.Create(Self);
end;

destructor TDAOVendaCabecalho.Destroy;
begin
  FVendaCabecalho.Destroy;
  inherited;
end;

class function TDAOVendaCabecalho.New: iDAOEntidade<TVendaCabecalho>;
begin
  Result:=Self.Create;
end;

function TDAOVendaCabecalho.ConsultarLista: iDAOEntidade<TVendaCabecalho>;
begin
  Result:= Self;
  FDataSet:=
    FConexao
    .SQL('SELECT v.ID, v.DATA_VENDA, v.ID_CLIENTE, c.NOME, v.VALOR, v.STATUS_VENDA FROM venda_cabecalho v'+
    ' LEFT JOIN cliente c ON (v.ID_CLIENTE = c.ID) ORDER BY v.ID DESC')
    .Open
    .DataSet;
end;

function TDAOVendaCabecalho.ConsultaUltimoRegistroInserido: iDAOEntidade<TVendaCabecalho>;
begin
  Result:= Self;
  FDataSet:=
    FConexao
    .SQL('SELECT first 1 v.ID, v.DATA_VENDA, v.ID_CLIENTE, c.NOME, v.VALOR, v.STATUS_VENDA FROM venda_cabecalho v'+
    ' LEFT JOIN cliente c ON (v.ID_CLIENTE = c.ID) ORDER BY v.ID DESC')
    .Open
    .DataSet;
end;

function TDAOVendaCabecalho.ConsultaItemUnico(Id: Variant): iDAOEntidade<TVendaCabecalho>;
begin
  Result:= Self;
  FDataSet:=
    FConexao
    .SQL('SELECT v.ID, v.DATA_VENDA, v.ID_CLIENTE, c.NOME, v.VALOR, v.STATUS_VENDA FROM venda_cabecalho v'+
    ' LEFT JOIN cliente c ON (v.ID_CLIENTE = c.ID) WHERE ID=:ID')
    .Params('ID',Id)
    .Open
    .DataSet;
end;

function TDAOVendaCabecalho.ConsultaLista(
  Filtro: String): iDAOEntidade<TVendaCabecalho>;
begin
   Result:= Self;
  FDataSet:=
    FConexao
    .SQL('SELECT v.ID, v.DATA_VENDA, v.ID_CLIENTE, c.NOME, v.VALOR FROM venda_cabecalho v'+
    ' LEFT JOIN cliente c ON (v.ID_CLIENTE = c.ID) WHERE '+Filtro)
    .Open
    .DataSet;
end;

function TDAOVendaCabecalho.ConsultarLista(
  IdCabecalho: Integer): iDAOEntidade<TVendaCabecalho>;
begin

end;

function TDAOVendaCabecalho.Excluir(Id: Integer): iDAOEntidade<TVendaCabecalho>;
begin
  Result:= Self;
  try
    FConexao.SQL('DELETE FROM VENDA_CABECALHO WHERE ID=:ID')
    .Params('ID',Id)
    .ExecSQL;
  except on e:Exception do
    raise Exception.Create('Erro ao tentar deletar registros: '+e.Message);
  end;
end;

function TDAOVendaCabecalho.Excluir: iDAOEntidade<TVendaCabecalho>;
begin
  Result := Self;
  try
    FConexao
    .SQL('DELETE FROM VENDA_CABECALHO WHERE ID=:ID')
    .Params('ID',FVendaCabecalho.Id)
    .ExecSQL;
  except on e:Exception do
    raise Exception.Create('Error ao tentar exluir o registro: '+e.Message);
  end;
end;

function TDAOVendaCabecalho.AssinarReceita(IdVenda,IdTecnicoAgricola:Integer): iDAOEntidade<TVendaCabecalho>;
begin
  Result := Self;
  try
    FConexao
      .SQL('UPDATE VENDA_CABECALHO SET STATUS_VENDA = '+QuotedStr('C')+' where ID=:ID')
      .Params('ID',IdVenda)
      .ExecSQL;

    FConexao
      .SQL('UPDATE VENDA_DETALHE SET ID_TECNICO_AGRICOLA = :ID_TECNICO_AGRICOLA '+
      ' WHERE ID_VENDA_CABECALHO = :ID_VENDA_CABECALHO AND CONTROLE_ESPECIAL = '+QuotedStr('S'))
      .Params('ID_TECNICO_AGRICOLA',IdTecnicoAgricola)
      .Params('ID_VENDA_CABECALHO',IdVenda)
      .ExecSQL;

  except on e:Exception do
    raise Exception.Create('Error ao tentar atualizar o resgistro: '+e.Message);
  end;
end;

function TDAOVendaCabecalho.Atualizar: iDAOEntidade<TVendaCabecalho>;
begin
  Result := Self;
  try
    FConexao
      .SQL('UPDATE VENDA_CABECALHO SET DATA_VENDA=:DATA_VENDA,ID_CLIENTE=:ID_CLIENTE,VALOR=:VALOR,STATUS_VENDA=:STATUS_VENDA WHERE ID=:ID')
      .Params('DATA_VENDA',FVendaCabecalho.DataVenda)
      .Params('ID_CLIENTE',FVendaCabecalho.IdCliente)
      .Params('VALOR',FVendaCabecalho.Valor)
      .Params('STATUS_VENDA',FVendaCabecalho.StatusVenda)
      .Params('ID',FVendaCabecalho.Id)
      .ExecSQL;
  except on e:Exception do
    raise Exception.Create('Error ao tentar atualizar o resgistro: '+e.Message);
  end;
end;

function TDAOVendaCabecalho.AtualizarStatus(IdVenda: Integer): iDAOEntidade<TVendaCabecalho>;
begin
  Result:=Self;
  try
    FConexao
    .SQL('UPDATE VENDA_CABECALHO SET STATUS_VENDA = '+QuotedStr('C')+
    ' WHERE (ID=:ID_VENDA_CABECALHO) and (ID NOT IN (SELECT ID_VENDA_CABECALHO FROM VENDA_DETALHE WHERE'+
    ' ID_VENDA_CABECALHO = :ID_VENDA_CABECALHO and CONTROLE_ESPECIAL = '+QuotedStr('S')+'))')
    .Params('ID_VENDA_CABECALHO',IdVenda)
    .ExecSQL
  except on e:Exception do
    raise Exception.Create('Erro ao tentar atualizar status da venda: '+ e.Message);

  end;
end;

function TDAOVendaCabecalho.Inserir: iDAOEntidade<TVendaCabecalho>;
begin
  Result := Self;
  try
    FConexao
      .SQL('INSERT INTO VENDA_CABECALHO (DATA_VENDA,ID_CLIENTE,VALOR,STATUS_VENDA) VALUES (:DATA_VENDA,:ID_CLIENTE,:VALOR,:STATUS_VENDA)')
      .Params('DATA_VENDA',FVendaCabecalho.DataVenda)
      .Params('ID_CLIENTE',FVendaCabecalho.IdCliente)
      .Params('VALOR',FVendaCabecalho.Valor)
      .Params('STATUS_VENDA',FVendaCabecalho.StatusVenda)
      .ExecSQL;
      FConexao
      .SQL('SELECT first 1 v.ID, v.DATA_VENDA, v.ID_CLIENTE, c.NOME, v.VALOR, v.STATUS_VENDA FROM venda_cabecalho v'+
      ' LEFT JOIN cliente c ON (v.ID_CLIENTE = c.ID) ORDER BY v.ID DESC')
      .Open
      .DataSet;


  except on e:Exception do
    raise Exception.Create('Erro ao tentar inserir os dados: '+ e.Message);
  end;
end;

function TDAOVendaCabecalho.DataSet(DataSource: TDataSource): iDAOEntidade<TVendaCabecalho>;
begin
  Result := Self;
  if not Assigned(FDataSet) then
    DataSource.DataSet:= FConexao.DataSet
  else
    DataSource.DataSet:=FDataSet;
end;



function TDAOVendaCabecalho.DataSet1(
  DataSet: TDataSet): iDAOEntidade<TVendaCabecalho>;
begin

end;

function TDAOVendaCabecalho.This: TVendaCabecalho;
begin
  Result := FVendaCabecalho;
end;

end.
