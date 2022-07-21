unit ProdutoCServidor;

interface
uses ProdutoVO,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  FireDAC.DApt,
  FDConexao,SysUtils, System.Classes;

type
  TProdutoCServidor = class
    private
    // SQL's CRUD
    class function SQL_Inserir():String;
    class function SQL_Editar():String;
    class function SQL_Excluir():String;
    class function SQL_ConsultaGridPesquisa(iItem:integer;sValorPesquisa : string):string;
    class function SQL_ConsultaObjId():string;

    public
    //funções de crud
    class function Editar(objProduto: TProdutoVO): boolean;
    class function Excluir(iId: Integer): boolean;
    class function Inserir(objProduto: TProdutoVO): boolean;

    //funcões de consultas
    class function ConsultaObjId(iId : Integer; objProduto: TProdutoVO):TProdutoVO;
    class function ConsultaGridPesquisa(iItem:Integer;sValorPesquisa: String;
      fdmt_Pesquisa: TFDMemTable): TFDMemTable;

    class function CarregaComboBoxPadrao(Lista : TStringList):TStringList;
    class function MontaFiltro(item:Integer;sValorPesquisa:string):string;
  end;

implementation

{ TClienteCServidor }

class function TProdutoCServidor.CarregaComboBoxPadrao(
  Lista: TStringList): TStringList;
begin
  Lista.add('Id');
  Lista.add('Nome');
  Result := Lista;
end;

class function TProdutoCServidor.ConsultaGridPesquisa(iItem:Integer;
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

class function TProdutoCServidor.ConsultaObjId(iId : Integer;
objProduto: TProdutoVO):TProdutoVO;
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
        objProduto.ID           := sqq_Pesquisa.Fields.FieldByName('ID').AsInteger;
        objProduto.NOME 	      := sqq_Pesquisa.Fields.FieldByName('NOME').AsString;
        objProduto.VALOR        := sqq_Pesquisa.Fields.FieldByName('VALOR').AsCurrency;
        objProduto.CONTROLE_ESP := sqq_Pesquisa.Fields.FieldByName('CONTROLE_ESP').AsInteger;
      end;
      result := objProduto;
    except
      on E: Exception do
      begin
        Raise Exception.Create(
        'Erro ao consultar produto id: '+ IntToStr(iId)+' '+
        E.Message);
      end;
    end;
  finally
    FreeAndNil(sqq_Pesquisa);
  end;

end;

class function TProdutoCServidor.Editar(objProduto: TProdutoVO): boolean;
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
      sqq_Editar.Params.ParamByName('id').AsInteger            := objProduto.ID;
      sqq_Editar.Params.ParamByName('nome').AsString           := objProduto.NOME;
      sqq_Editar.Params.ParamByName('valor').AsBCD             := objProduto.VALOR;
      sqq_Editar.Params.ParamByName('controle_esp').AsInteger  := objProduto.CONTROLE_ESP;
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

class function TProdutoCServidor.Excluir(iId: Integer): boolean;
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

class function TProdutoCServidor.Inserir(objProduto: TProdutoVO): boolean;
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
      sqq_Inserir.Params.ParamByName('nome').AsString          := objProduto.NOME;
      sqq_Inserir.Params.ParamByName('valor').AsBCD            := objProduto.VALOR;
      sqq_Inserir.Params.ParamByName('controle_esp').AsInteger := objProduto.CONTROLE_ESP;
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

class function TProdutoCServidor.MontaFiltro(item: Integer;
  sValorPesquisa: string): string;
  var sfiltro:String;
begin
  sfiltro := '';
  if Length(sValorPesquisa)>0 then
  begin
    case item of
     0: sfiltro := 'where Id = '+sValorPesquisa;
     1: sfiltro := 'where Nome like ''%'+sValorPesquisa+'%''';
    end;
  end;
  Result := sfiltro;
end;

class function TProdutoCServidor.SQL_ConsultaGridPesquisa(iItem:integer;
sValorPesquisa: string): string;
begin
  Result := 'select id, nome, valor,                  '+
            'case controle_esp when                   '+
            '0 then ''Não'' else ''Sim''              '+
            'end as Especial                          '+
            'from produto                             '+
            MontaFiltro(iItem,sValorPesquisa)         +
            'order by nome                            ';
end;

class function TProdutoCServidor.SQL_ConsultaObjId: string;
begin
  Result := 'select id, nome, valor, controle_esp '+
            'from produto                         '+
            'where id = :iId                      ';
end;

class function TProdutoCServidor.SQL_Editar: String;
begin
  result := 'update produto                     '+
            'set id = :id,                      '+
            '     nome = :nome,                 '+
            '     valor = :valor,               '+
            '     controle_esp = :controle_esp  '+
            'where (id = :id)                   ';
end;

class function TProdutoCServidor.SQL_Excluir: String;
begin
  Result := 'delete from produto '+
            'where (id = :id)    ';
end;

class function TProdutoCServidor.SQL_Inserir: String;
begin
  result := 'insert into produto (id, nome, valor, controle_esp)          '+
            'values (gen_id(gen_produto,1), :nome, :valor, :controle_esp) ';
end;

end.
