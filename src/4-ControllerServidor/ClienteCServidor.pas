unit ClienteCServidor;

interface
uses ClienteVO,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  FireDAC.DApt,
  FDConexao,SysUtils, System.Classes;

type
  TClienteCServidor = class
    private
    // SQL's CRUD
    class function SQL_Inserir():String;
    class function SQL_Editar():String;
    class function SQL_Excluir():String;
    class function SQL_ConsultaGridPesquisa(iItem:Integer;sValorPesquisa : string):string;
    class function SQL_ConsultaObjId():string;

    public
      //funções de crud
    class function Editar(objCliente: TClienteVO): boolean;
    class function Excluir(iId: Integer): boolean;
    class function Inserir(objCliente: TClienteVO): boolean;

    class function ConsultaGridPesquisa(iItem:Integer;sValorPesquisa: String;
      fdmt_Pesquisa: TFDMemTable): TFDMemTable;
    class function ConsultaObjId(iId: Integer; objCliente: TClienteVO):TClienteVO;

    class function CarregaComboBoxPadrao(Lista : TStringList):TStringList;
    class function MontaFiltro(item:Integer;sValorPesquisa:string):string;
  end;

implementation

{ TClienteCServidor }

class function TClienteCServidor.CarregaComboBoxPadrao(
  Lista: TStringList): TStringList;
begin
  Lista.add('Id');
  Lista.add('Nome');
  Lista.add('CPF');
  Result := Lista;
end;

class function TClienteCServidor.ConsultaGridPesquisa(iItem:Integer;
  sValorPesquisa: String; fdmt_Pesquisa: TFDMemTable): TFDMemTable;
var
  sqq_Pesquisa: TFDQuery;
begin
  sqq_Pesquisa := TFDQuery.Create(nil);
  sqq_Pesquisa.Name := 'sqq_pesquisa';
  sqq_Pesquisa.Close;
  sqq_Pesquisa.SQL.Clear;
  sqq_Pesquisa.Connection := DataModule1.FB;
  sqq_Pesquisa.SQL.Add(SQL_ConsultaGridPesquisa(iItem,sValorPesquisa));
  sqq_Pesquisa.Open;
  if not(sqq_Pesquisa.IsEmpty) then
  begin
    sqq_Pesquisa.FetchAll;
    fdmt_Pesquisa.Data := sqq_Pesquisa.Data;
  end;
  Result := fdmt_Pesquisa;
end;

class function TClienteCServidor.ConsultaObjId(iId: Integer;
  objCliente: TClienteVO): TClienteVO;
var
  sqq_Pesquisa: TFDQuery;
begin
  try
    sqq_Pesquisa := TFDQuery.Create(nil);
    sqq_Pesquisa.Name := 'sqq_pesquisa';
    sqq_Pesquisa.SQL.Clear;
    sqq_Pesquisa.Params.Clear;
    sqq_Pesquisa.Connection := DataModule1.FB;
    try
      sqq_Pesquisa.SQL.Add(SQL_ConsultaObjId);
      sqq_Pesquisa.Params.ParamByName('iId').AsInteger := iId;
      sqq_Pesquisa.Open;
      if not(sqq_Pesquisa.IsEmpty) then
      begin
        objCliente.ID    := sqq_Pesquisa.Fields.FieldByName('ID').AsInteger;
        objCliente.CPF 	 := sqq_Pesquisa.Fields.FieldByName('CPF').AsString;
        objCliente.NOME  := sqq_Pesquisa.Fields.FieldByName('NOME').AsString;
      end;
      result := objCliente;
    except
      on E: Exception do
      begin
        Raise Exception.Create(
        'Erro ao consultar cliente id: '+ IntToStr(iId)+' '+
        E.Message);
      end;
    end;
  finally
    FreeAndNil(sqq_Pesquisa);
  end;

end;


class function TClienteCServidor.Editar(objCliente: TClienteVO): boolean;
var
  sqq_Editar: TFDQuery;
begin
  try
    sqq_Editar := TFDQuery.Create(nil);
    sqq_Editar.Name := 'sqq_Editar';
    sqq_Editar.SQL.Clear;
    sqq_Editar.Params.Clear;
    try
      sqq_Editar.Connection := DataModule1.FB;
      sqq_Editar.Connection.StartTransaction;
      sqq_Editar.SQL.Add(sql_Editar);
      sqq_Editar.Prepared := True;
      sqq_Editar.Params.ParamByName('id').AsInteger  :=  objCliente.ID;
      sqq_Editar.Params.ParamByName('cpf').AsString  :=  objCliente.CPF;
      sqq_Editar.Params.ParamByName('nome').AsString :=  objCliente.NOME;
      sqq_Editar.ExecSQL();
      sqq_Editar.Connection.Commit;
      Result := true;
    except
      on E: Exception do
      begin
        sqq_Editar.Connection.Rollback;
        raise Exception.Create('Erro ao editar registro. ' + E.Message);
        Result := false;
      end;
    end;
  finally
    FreeAndNil(sqq_Editar);
  end;
end;

class function TClienteCServidor.Excluir(iId: Integer): boolean;
var
  sqq_Excluir: TFDQuery;
begin
  try
    sqq_Excluir := TFDQuery.Create(nil);
    sqq_Excluir.Name := 'sqq_Excluir';
    sqq_Excluir.SQL.Clear;
    sqq_Excluir.Params.Clear;
    try
      sqq_Excluir.Connection := DataModule1.FB;
      sqq_Excluir.Connection.StartTransaction;
      sqq_Excluir.SQL.Add(sql_Excluir);
      sqq_Excluir.Prepared := True;
      sqq_Excluir.Params.ParamByName('id').AsInteger  :=  iId;
      sqq_Excluir.ExecSQL();
      sqq_Excluir.Connection.Commit;
      Result := true;
    except
      on E: Exception do
      begin
        sqq_Excluir.Connection.Rollback;
        raise Exception.Create('Erro ao excluir registro. ' + E.Message);
        Result := false;
      end;
    end;
  finally
    FreeAndNil(sqq_Excluir);
  end;
end;

class function TClienteCServidor.Inserir(objCliente: TClienteVO): boolean;
var
  sqq_Inserir: TFDQuery;
begin
  try
    sqq_Inserir := TFDQuery.Create(nil);
    sqq_Inserir.Name := 'sqq_Inserir';
    sqq_Inserir.SQL.Clear;
    sqq_Inserir.Params.Clear;
    try
      sqq_Inserir.Connection := DataModule1.FB;
      sqq_Inserir.Connection.StartTransaction;
      sqq_Inserir.SQL.Add(sql_Inserir);
      sqq_Inserir.Prepared := True;
      sqq_Inserir.Params.ParamByName('cpf').AsString  :=  objCliente.CPF;
      sqq_Inserir.Params.ParamByName('nome').AsString :=  objCliente.NOME;
      sqq_Inserir.ExecSQL();
      sqq_Inserir.Connection.Commit;
      Result := true;
    except
      on E: Exception do
      begin
        sqq_Inserir.Connection.Rollback;
        raise Exception.Create('Erro ao inserir registro. ' + E.Message);
        Result := false;
      end;
    end;
  finally
    FreeAndNil(sqq_Inserir);
  end;
end;

class function TClienteCServidor.MontaFiltro(item: Integer;sValorPesquisa:string): string;
  var sfiltro:String;
begin
  sfiltro := '';
  if Length(sValorPesquisa)>0 then
  begin
    case item of
     0: sfiltro := 'where Id = '+sValorPesquisa;
     1: sfiltro := 'where Nome like ''%'+sValorPesquisa+'%''';
     2: sfiltro := 'where CPF like ''%'+sValorPesquisa+'%''';
    end;
  end;
  Result := sfiltro;
end;

class function TClienteCServidor.SQL_ConsultaGridPesquisa(iItem:Integer;sValorPesquisa: string): string;
begin
  Result := 'select id, cpf, nome '+
            'from cliente         '+
            MontaFiltro(iItem,sValorPesquisa)+' '+
            'order by nome        ';
end;

class function TClienteCServidor.SQL_ConsultaObjId: string;
begin
  Result := 'select id, cpf, nome '+
            'from cliente         '+
            'where id = :iId      ';
end;

class function TClienteCServidor.SQL_Editar: String;
begin
  result := 'update cliente   '+
            'set cpf = :cpf,  '+
            '    nome = :nome '+
            'where (id = :id) ';
end;

class function TClienteCServidor.SQL_Excluir: String;
begin
  Result := 'delete from cliente '+
            'where (id = :id)    ';
end;

class function TClienteCServidor.SQL_Inserir: String;
begin
  result := 'insert into cliente (id, cpf, nome)         '+
            'values (gen_id(gen_cliente,1), :cpf, :nome) ';
end;

end.
