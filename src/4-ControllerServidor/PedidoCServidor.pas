unit PedidoCServidor;

interface
uses PedidoVO,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  FireDAC.DApt,
  FDConexao,SysUtils, ClienteCServidor, TecnicoCServidor;

type
  TPedidoCServidor = class
    private
    // SQL's CRUD
    class function SQL_Inserir():String;
    class function SQL_Editar():String;
    class function SQL_Excluir():String;
    class function SQL_ConsultaGridPesquisa(sValorPesquisa : string):string;
    class function SQL_ConsultaObjId():string;

    class function sql_AlteraStatus():string;

    public
    //funções de crud
    class function Editar(objPedido: TPedidoVO): boolean;
    class function Excluir(iId: Integer): boolean;
    class function Inserir(objPedido: TPedidoVO): boolean;

    class function AlteraStatusPedido(iId,iStatus:integer):boolean;

    //funcões de consultas
    class function ConsultaObjId(iId : Integer; objPedido: TPedidoVO): TPedidoVO;
    class function ConsultaGridPesquisa(sValorPesquisa: String;
      fdmt_Pesquisa: TFDMemTable): TFDMemTable;
  end;

implementation

{ TClienteCServidor }

class function TPedidoCServidor.AlteraStatusPedido(iId,
  iStatus: integer): boolean;
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
      sqq_Editar.SQL.Add(sql_AlteraStatus);
      sqq_Editar.Prepared := True;
      sqq_Editar.Params.ParamByName('id').AsInteger     := iID;
      sqq_Editar.Params.ParamByName('STATUS').AsInteger := iStatus;
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

class function TPedidoCServidor.ConsultaGridPesquisa(
  sValorPesquisa: String; fdmt_Pesquisa: TFDMemTable): TFDMemTable;
var
  sqq_Pesquisa: TFDQuery;
begin
  sqq_Pesquisa := TFDQuery.Create(nil);
  sqq_Pesquisa.Name := 'sqq_pesquisa';
  sqq_Pesquisa.Close;
  sqq_Pesquisa.SQL.Clear;
  sqq_Pesquisa.Connection := DataModule1.FB;
  sqq_Pesquisa.SQL.Add(SQL_ConsultaGridPesquisa(sValorPesquisa));
  sqq_Pesquisa.Open;
  if not(sqq_Pesquisa.IsEmpty) then
  begin
    sqq_Pesquisa.FetchAll;
    fdmt_Pesquisa.Data := sqq_Pesquisa.Data;
  end;
  Result := fdmt_Pesquisa;
end;

class function TPedidoCServidor.ConsultaObjId(iId : Integer;
objPedido: TPedidoVO): TPedidoVO;
var
  sqq_Pesquisa: TFDQuery;
  objCliente: TClienteCServidor;
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
        objPedido.ID            := sqq_Pesquisa.Fields.FieldByName('ID').AsInteger;
        objPedido.ID_CLIENTE 	  := sqq_Pesquisa.Fields.FieldByName('ID_CLIENTE').AsInteger;
        objPedido.ID_TECNICO    := sqq_Pesquisa.Fields.FieldByName('ID_TECNICO').AsInteger;
        objPedido.DATA_ABERTURA := sqq_Pesquisa.Fields.FieldByName('DATA_ABERTURA').AsDateTime;
        objPedido.STATUS        := sqq_Pesquisa.Fields.FieldByName('STATUS').AsInteger;
        objPedido.ClienteVO     := TClienteCServidor.ConsultaObjId
                                   (objPedido.ID_CLIENTE,objPedido.ClienteVO);
        objPedido.TecnicoVO     := TTecnicoCServidor.ConsultaObjId
                                   (objPedido.ID_TECNICO,objPedido.TecnicoVO);
      end;
      result := objPedido;
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

class function TPedidoCServidor.Editar(objPedido: TPedidoVO): boolean;
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
      sqq_Editar.Params.ParamByName('id').AsInteger          := objPedido.ID;
      sqq_Editar.Params.ParamByName('ID_CLIENTE').AsInteger  := objPedido.ID_CLIENTE;
      sqq_Editar.Params.ParamByName('ID_TECNICO').AsInteger  := objPedido.ID_TECNICO;
      sqq_Editar.Params.ParamByName('DATA_ABERTURA').AsDate  := objPedido.DATA_ABERTURA;
      sqq_Editar.Params.ParamByName('STATUS').AsInteger      := objPedido.STATUS;
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

class function TPedidoCServidor.Excluir(iId: Integer): boolean;
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

class function TPedidoCServidor.Inserir(objPedido: TPedidoVO): boolean;
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
      sqq_Inserir.Params.ParamByName('ID_CLIENTE').AsInteger  :=  objPedido.ID_CLIENTE;
      sqq_Inserir.Params.ParamByName('ID_TECNICO').AsInteger  :=  objPedido.ID_TECNICO;
      sqq_Inserir.Params.ParamByName('DATA_ABERTURA').AsDate  :=  objPedido.DATA_ABERTURA;
      sqq_Inserir.Params.ParamByName('STATUS').AsInteger      :=  objPedido.STATUS;
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

class function TPedidoCServidor.sql_AlteraStatus: string;
begin
  result := 'update pedido set  '+
            ' status = :status  '+
            'where (id = :id)   ';
end;

class function TPedidoCServidor.SQL_ConsultaGridPesquisa(sValorPesquisa: string): string;
begin
  Result := 'select                                         '+
            'p.id,                                          '+
            'case p.status                                  '+
            'when 0 then ''Aberto''                         '+
            'when 1 then ''Aguardando Receita''             '+
            'when 2 then ''Pedido concluído''               '+
            'end status,                                     '+
            'p.id_cliente, c.nome as Cliente,               '+
            'p.id_tecnico, t.nome as Tecnico,               '+
            'p.data_abertura                                '+
            'from pedido p                                  '+
            'left join cliente c on (c.id = p.id_cliente)   '+
            'left join tecnico t on (t.id = p.id_tecnico)   '+
            'order by id                                    ';
end;

class function TPedidoCServidor.SQL_ConsultaObjId: string;
begin
  Result := 'select                        '+
            'id, id_cliente, id_tecnico,   '+
            'data_abertura, status         '+
            'from pedido                   '+
            'where id = :iId               ';
end;

class function TPedidoCServidor.SQL_Editar: String;
begin
  result := 'update pedido                        '+
            'set id_cliente = :id_cliente,        '+
            '    id_tecnico = :id_tecnico,        '+
            '    data_abertura = :data_abertura,  '+
            '    status = :status                 '+
            'where (id = :id)                     ';
end;

class function TPedidoCServidor.SQL_Excluir: String;
begin
  Result := 'delete from pedido '+
            'where (id = :id)    ';
end;

class function TPedidoCServidor.SQL_Inserir: String;
begin
  result := 'insert into pedido (id, id_cliente, id_tecnico, data_abertura, '+
            'status)                                                        '+
            'values (gen_id(gen_pedido,1), :id_cliente, :id_tecnico,        '+
            ':data_abertura, :status)                                       ';
end;

end.
