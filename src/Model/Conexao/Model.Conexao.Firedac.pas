unit Model.Conexao.Firedac;

interface

uses
 Firedac.Stan.Intf,
  Firedac.Stan.Option,
  Firedac.Stan.Error,
  Firedac.UI.Intf,
  Firedac.Phys.Intf,
  Firedac.Stan.Def,
  Firedac.Stan.Pool,
  Firedac.Stan.Async,
  Firedac.Phys,
  Firedac.Phys.FB,
  Firedac.Phys.FBDef,
  Firedac.Stan.ExprFuncs,
  Firedac.VCLUI.Wait,
  Firedac.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.UI,
  FireDAC.Phys.IBBase,
  Model.Conexao.Interfaces,
  Data.DB,
  Biblioteca;

  type
    TModelConexao = class(TInterfacedObject,iConexao)
      private
        FConexao: TFDConnection;
        FQuery: TFDQuery;
        //FTransacao:TFDTransaction;
      public
      constructor Create;
      destructor Destroy;override;
      class function New:iConexao;
      function Params(Param:String; Value:Variant): iConexao;overload;
      function DataSet(DataSource:TDataSource):iConexao; overload;
      function DataSet: TDataset; overload;
      function ExecSQL: iConexao;
      function Open : iConexao;
      function SQL (Value:String): iConexao;
    end;
implementation

{ TModelConexao }

constructor TModelConexao.Create;
begin
  //FTransacao:=TFDTransaction.Create(nil);
  //FTransacao.Options.AutoCommit:=false;

  FConexao := TFDConnection.Create(nil);
  //FConexao.Transaction:= FTransacao;


  FQuery:= TFdQuery.Create(nil);
  FQuery.Connection:= FConexao;
  //FQuery.Transaction:=FTransacao;
  //FQuery.Connection.TxOptions.AutoCommit:=false;

  FConexao.Params.Clear;
  FConexao.Params.Add('DriverID=FB');
  FConexao.Params.Add('DataBase='+Biblioteca.CaminhoBD+'ALIARE.FDB');
  FConexao.Params.Add('User_Name=SYSDBA');
  FConexao.Params.Add('Password=masterkey');
  FConexao.Params.Add('Port=3050');
  FConexao.Params.Add('Server=localhost');
  //FConexao.Params.Add('LockingMode=Normal');
  FConexao.Connected:=True;
end;

function TModelConexao.DataSet(DataSource:TDataSource):iConexao;
begin
  Result:=Self;
  DataSource.Dataset:= FQuery;
end;

function TModelConexao.DataSet: TDataset;
begin
  Result:=FQuery;
end;

destructor TModelConexao.Destroy;
begin
  FConexao.DisposeOf;
  FQuery.DisposeOf;
  inherited;
end;

function TModelConexao.ExecSQL: iConexao;
begin
  try
    //FTransacao.StartTransaction;
    Result:= Self;
    FQuery.ExecSQL;
    //FTransacao.Commit;
  except
    //FTransacao.Rollback;
  end;
end;

class function TModelConexao.New: iConexao;
begin
  Result:=Self.Create;
end;

function TModelConexao.Open: iConexao;
begin
  Result:=Self;
  FQuery.Open;
end;

function TModelConexao.Params(Param: String; Value: Variant): iConexao;
begin
  Result := Self;
  FQuery.ParamByName(Param).Value:=Value;
end;

function TModelConexao.SQL(Value: String): iConexao;
begin
  Result:=Self;
  Fquery.SQL.Clear;
  FQuery.SQL.Add(Value);
end;

end.
