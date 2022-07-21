unit PedidoItemCServidor;

interface
uses PedidoVO,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  FireDAC.DApt,
  FDConexao,SysUtils, ClienteCServidor, PedidoItemVO;

type
  TPedidoItemCServidor = class
    private
    // SQL's CRUD
    class function SQL_Inserir():String;
    class function SQL_Excluir():String;
    class function SQL_ConsultaGridPesquisa():string;

    public
    //funções de crud
    class function Excluir(iId: Integer): boolean;
    class function Inserir(objPedidoItem: TPedidoItemVO): boolean;

    //funcões de consultas
    class function ConsultaGridPesquisa(iId: Integer;
      fdmt_Pesquisa: TFDMemTable): TFDMemTable;
  end;

implementation

{ TClienteCServidor }

class function TPedidoItemCServidor.ConsultaGridPesquisa(
  iId: Integer; fdmt_Pesquisa: TFDMemTable): TFDMemTable;
var
  sqq_Pesquisa: TFDQuery;
begin
  sqq_Pesquisa := TFDQuery.Create(nil);
  sqq_Pesquisa.Name := 'sqq_pesquisa';
  sqq_Pesquisa.Close;
  sqq_Pesquisa.SQL.Clear;
  sqq_Pesquisa.Connection := DataModule1.FB;
  sqq_Pesquisa.SQL.Add(SQL_ConsultaGridPesquisa());
  sqq_Pesquisa.Params.ParamByName('iId').AsInteger  :=  iId;
  sqq_Pesquisa.Open;
  if not(sqq_Pesquisa.IsEmpty) then
  begin
    sqq_Pesquisa.FetchAll;
    fdmt_Pesquisa.Data := sqq_Pesquisa.Data;
  end;
  Result := fdmt_Pesquisa;
end;

class function TPedidoItemCServidor.Excluir(iId: Integer): boolean;
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

class function TPedidoItemCServidor.Inserir(objPedidoItem: TPedidoItemVO): boolean;
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
      sqq_Inserir.Params.ParamByName('ID_PEDIDO').AsInteger     :=  objPedidoItem.ID_PEDIDO;
      sqq_Inserir.Params.ParamByName('ID_PRODUTO').AsInteger    :=  objPedidoItem.ID_PRODUTO;
      sqq_Inserir.Params.ParamByName('VALOR').AsBCD             :=  objPedidoItem.VALOR;
      sqq_Inserir.Params.ParamByName('QUANTIDADE').AsBCD        :=  objPedidoItem.QUANTIDADE;
      sqq_Inserir.Params.ParamByName('TOTAL').AsBCD             :=  objPedidoItem.TOTAL;
      sqq_Inserir.Params.ParamByName('CONTROLE_ESP').AsInteger  :=  objPedidoItem.CONTROLE_ESP;

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

class function TPedidoItemCServidor.SQL_ConsultaGridPesquisa(): string;
begin
  Result := 'select                     '+
            'id, id_pedido, id_produto, '+
            'valor, quantidade, total,  '+
            'case controle_esp          '+
            'when 0 then ''Não''        '+
            'when 1 then ''Sim''        '+
            'end as "Controle Especial" '+
            'from pedido_item           '+
            'where id_pedido = :iId     '+
            'order by id                ';
end;

class function TPedidoItemCServidor.SQL_Excluir: String;
begin
  Result := 'delete from pedido_item '+
            'where (id = :id)    ';
end;

class function TPedidoItemCServidor.SQL_Inserir: String;
begin
  result := 'insert into pedido_item (id, id_pedido, id_produto, valor,  '+
            'quantidade, total, controle_esp)                            '+
            'values (gen_id(gen_pedido_item,1), :id_pedido, :id_produto,   '+
            ':valor, :quantidade, :total, :controle_esp)                 ';
end;

end.
