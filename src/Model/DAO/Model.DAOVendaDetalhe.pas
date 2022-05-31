unit Model.DAOVendaDetalhe;

interface
uses
  System.SysUtils,
  Model.DAO.Interfaces,
  Model.Entidade.VendaDetalhe,
  Data.DB,
  Model.Conexao.Interfaces,
  Model.Conexao.Firedac;
type
  TDAOVendaDetalhe = class(TInterfacedObject,iDAOEntidade<TVendaDetalhe>)
  private
    FVendaDetalhe : TVendaDetalhe;
    FConexao: iConexao;
    FDataSet : TDataSet;



  public
    constructor Create;
    destructor Destroy;override;
    class function New : iDAOEntidade<TVendaDetalhe>;
    function ConsultarLista : iDAOEntidade<TVendaDetalhe>;overload;
    function ConsultarLista(IdCabecalho:Integer) : iDAOEntidade<TVendaDetalhe>;overload;
    function ConsultaLista(Filtro:String): iDAOEntidade<TVendaDetalhe>;overload;
    function ConsultaItemUnico(Id:Variant):iDAOEntidade<TVendaDetalhe>;
    function ConsultaUltimoRegistroInserido:iDAOEntidade<TVendaDetalhe>;
    function Excluir(Id:Integer):iDAOEntidade<TVendaDetalhe>;overload;
    function Excluir:iDAOEntidade<TVendaDetalhe>;overload;
    function Atualizar : iDAOEntidade<TVendaDetalhe>;
    function Inserir:iDAOEntidade<TVendaDetalhe>;
    function DataSet(DataSource:TDataSource):iDAOEntidade<TVendaDetalhe>;
    function DataSet1(DataSet: TDataSet): iDAOEntidade<TVendaDetalhe>;
    function This:TVendaDetalhe;



  end;

implementation

{ TDAOVendaDetalhe }

constructor TDAOVendaDetalhe.Create;
begin
  FConexao:=TModelConexao.New;
  FVendaDetalhe:= TVendaDetalhe.Create(Self);
end;

destructor TDAOVendaDetalhe.Destroy;
begin
  FVendaDetalhe.Destroy;
  inherited;
end;

class function TDAOVendaDetalhe.New: iDAOEntidade<TVendaDetalhe>;
begin
  Result:=Self.Create;
end;

function TDAOVendaDetalhe.ConsultarLista: iDAOEntidade<TVendaDetalhe>;
begin
  Result:= Self;
  FDataSet:=
    FConexao
    .SQL('SELECT v.ID,v.ID_PRODUTO, p.NOME AS PRODUTONOME,v.QUANTIDADE,'+
    ' v.VALOR_UNITARIO,v.VALOR_TOTAL,v.CONTROLE_ESPECIAL,v.ID_TECNICO_AGRICOLA,'+
    ' ta.nome as TECNICO_AGRICOLANOME,v.ID_VENDA_CABECALHO FROM venda_detalhe v'+
    ' LEFT JOIN produto p ON (v.ID_PRODUTO = p.ID)'+
    ' LEFT JOIN tecnico_agricola ta on (v.ID_TECNICO_AGRICOLA = ta.ID)'+
    ' ORDER BY v.ID ')
    .Open
    .DataSet;
end;

function TDAOVendaDetalhe.ConsultarLista(IdCabecalho: Integer): iDAOEntidade<TVendaDetalhe>;
begin
  Result:= Self;
  FDataSet:=
    FConexao
    .SQL('SELECT v.ID,v.ID_PRODUTO, p.NOME AS PRODUTONOME,v.QUANTIDADE,'+
    ' v.VALOR_UNITARIO,v.VALOR_TOTAL,v.CONTROLE_ESPECIAL,v.ID_TECNICO_AGRICOLA,'+
    ' ta.nome as TECNICO_AGRICOLANOME,v.ID_VENDA_CABECALHO FROM venda_detalhe v'+
    ' LEFT JOIN produto p ON (v.ID_PRODUTO = p.ID)'+
    ' LEFT JOIN tecnico_agricola ta on (v.ID_TECNICO_AGRICOLA = ta.ID)'+
    ' WHERE ID_VENDA_CABECALHO=:ID_VENDA_CABECALHO'+
    ' ORDER BY v.ID ')
    .Params('ID_VENDA_CABECALHO',IdCabecalho)
    .Open
    .DataSet;
end;

function TDAOVendaDetalhe.ConsultaUltimoRegistroInserido: iDAOEntidade<TVendaDetalhe>;
begin

end;

function TDAOVendaDetalhe.ConsultaItemUnico(Id: Variant): iDAOEntidade<TVendaDetalhe>;
begin
  Result:= Self;
  FDataSet:=
    FConexao
     .SQL('SELECT v.ID,v.ID_PRODUTO, p.NOME AS PRODUTONOME,v.QUANTIDADE,'+
    ' v.VALOR_UNITARIO,v.VALOR_TOTAL,v.CONTROLE_ESPECIAL,v.ID_TECNICO_AGRICOLA,'+
    ' ta.nome as TECNICO_AGRICOLANOME,v.ID_VENDA_CABECALHO FROM venda_detalhe v'+
    ' LEFT JOIN produto p ON (v.ID_PRODUTO = p.ID)'+
    ' LEFT JOIN tecnico_agricola ta on (v.ID_TECNICO_AGRICOLA = ta.ID)'+
    ' WHERE ID=:ID'+
    ' ORDER BY v.ID ')
    .Params('ID',Id)
    .Open
    .DataSet;
end;


function TDAOVendaDetalhe.ConsultaLista(Filtro: String): iDAOEntidade<TVendaDetalhe>;
begin
  Result:= Self;
  FDataSet:=
    FConexao
    .SQL('SELECT v.ID,v.ID_PRODUTO, p.NOME AS PRODUTONOME,v.QUANTIDADE,'+
    ' v.VALOR_UNITARIO,v.VALOR_TOTAL,v.CONTROLE_ESPECIAL,v.ID_TECNICO_AGRICOLA,'+
    ' ta.nome as TECNICO_AGRICOLANOME,v.ID_VENDA_CABECALHO FROM venda_detalhe v'+
    ' LEFT JOIN produto p ON (v.ID_PRODUTO = p.ID)'+
    ' LEFT JOIN tecnico_agricola ta on (v.ID_TECNICO_AGRICOLA = ta.ID)'+
    ' where '+Filtro +' ORDER BY v.ID')
    .Open
    .DataSet;
end;

function TDAOVendaDetalhe.Excluir(Id: Integer): iDAOEntidade<TVendaDetalhe>;
begin
  Result:= Self;
  try
    FConexao.SQL('DELETE FROM venda_detalhe WHERE ID=:ID')
    .Params('ID',Id)
    .ExecSQL;
  except on e:Exception do
    raise Exception.Create('Erro ao tentar deletar registros: '+e.Message);
  end;
end;

function TDAOVendaDetalhe.Excluir: iDAOEntidade<TVendaDetalhe>;
begin
  Result := Self;
  try
    FConexao
    .SQL('DELETE FROM venda_detalhe WHERE ID=:ID')
    .Params('ID',FVendaDetalhe.Id)
    .ExecSQL;
  except on e:Exception do
    raise Exception.Create('Error ao tentar exluir o registro: '+e.Message);
  end;
end;

function TDAOVendaDetalhe.Atualizar: iDAOEntidade<TVendaDetalhe>;
begin
  Result := Self;
  try
    FConexao
      .SQL('UPDATE venda_detalhe SET ID_VENDA_CABECALHO=:ID_VENDA_CABECALHO,ID_PRODUTO=:ID_PRODUTO,'+
      ' QUANTIDADE=:QUANTIDADE,VALOR_UNITARIO=:VALOR_UNITARIO,VALOR_TOTAL=:VALOR_TOTAL,'+
      ' ID_TECNICO_AGRICOLA=:ID_TECNICO_AGRICOLA,CONTROLE_ESPECIAL=:CONTROLE_ESPECIAL '+
      ' WHERE ID=:ID')
      .Params('ID_VENDA_CABECALHO',FVendaDetalhe.IdVendaCabecalho)
      .Params('ID_PRODUTO',FVendaDetalhe.IdProduto)
      .Params('QUANTIDADE',FVendaDetalhe.Quantidade)
      .Params('VALOR_UNITARIO',FVendaDetalhe.ValorUnitario)
      .Params('VALOR_TOTAL',FVendaDetalhe.ValorTotal)
      .Params('ID_TECNICO_AGRICOLA',FVendaDetalhe.IdTecnicoAgricola)
      .Params('CONTROLE_ESPECIAL',FVendaDetalhe.ControleEspecial)
      .Params('ID',FVendaDetalhe.Id)
      .ExecSQL;
  except on e:Exception do
    raise Exception.Create('Error ao tentar atualizar o resgistro: '+e.Message);
  end;
end;

function TDAOVendaDetalhe.Inserir: iDAOEntidade<TVendaDetalhe>;
begin
  Result := Self;
  try
    FConexao
      .SQL('INSERT INTO VENDA_Detalhe (ID_VENDA_CABECALHO,ID_PRODUTO,'+
      ' QUANTIDADE,VALOR_UNITARIO,VALOR_TOTAL,'+
      ' CONTROLE_ESPECIAL,ID_TECNICO_AGRICOLA) VALUES'+
      ' (:ID_VENDA_CABECALHO,:ID_PRODUTO,'+
      ' :QUANTIDADE,:VALOR_UNITARIO,:VALOR_TOTAL,'+
      ' :CONTROLE_ESPECIAL,:ID_TECNICO_AGRICOLA)')
      .Params('ID_VENDA_CABECALHO',FVendaDetalhe.IdVendaCabecalho)
      .Params('ID_PRODUTO',FVendaDetalhe.IdProduto)
      .Params('QUANTIDADE',FVendaDetalhe.Quantidade)
      .Params('VALOR_UNITARIO',FVendaDetalhe.ValorUnitario)
      .Params('VALOR_TOTAL',FVendaDetalhe.ValorTotal)
      .Params('ID_TECNICO_AGRICOLA',FVendaDetalhe.IdTecnicoAgricola)
      .Params('CONTROLE_ESPECIAL',FVendaDetalhe.ControleEspecial)
      .ExecSQL;
  except on e:Exception do
    raise Exception.Create('Erro ao tentar inserir os dados: '+ e.Message);
  end;
end;

function TDAOVendaDetalhe.DataSet(DataSource: TDataSource): iDAOEntidade<TVendaDetalhe>;
begin
  Result := Self;
  if not Assigned(FDataSet) then
    DataSource.DataSet:= FConexao.DataSet
  else
    DataSource.DataSet:=FDataSet;
end;



function TDAOVendaDetalhe.DataSet1(DataSet: TDataSet): iDAOEntidade<TVendaDetalhe>;
begin

end;

function TDAOVendaDetalhe.This: TVendaDetalhe;
begin
  Result := FVendaDetalhe;
end;

end.
