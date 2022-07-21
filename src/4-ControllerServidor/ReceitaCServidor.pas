unit ReceitaCServidor;

interface
uses ClienteVO,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  FireDAC.DApt,
  FDConexao,SysUtils, System.Classes, ReceitaVO, ReceitaItemCServidor,
  PedidoCServidor;

type
  TReceitaCServidor = class
    private
    // SQL's CRUD
    class function SQL_Inserir():String;
    class function SQL_Baixar:string;
    class function SQL_ConsultaGridPesquisa():String;

    public
      //funções de crud
    class function Inserir(objReceita: TReceitaVO): boolean;
    class function baixaReceita(iId_Receita,iIdPedido: Integer):Boolean;

    class function ConsultaGridPesquisa(fdmt_Pesquisa: TFDMemTable): TFDMemTable;

  end;

implementation

{ TClienteCServidor }

class function TReceitaCServidor.baixaReceita(iId_Receita,iIdPedido: Integer): Boolean;
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
      sqq_Editar.SQL.Add(sql_Baixar);
      sqq_Editar.Prepared := True;
      sqq_Editar.Params.ParamByName('id').AsInteger  :=  iId_Receita;
      sqq_Editar.ExecSQL();
      sqq_Editar.Connection.Commit;
      Result := true;
      TPedidoCServidor.AlteraStatusPedido(iIdPedido,2);
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
class function TReceitaCServidor.ConsultaGridPesquisa(
  fdmt_Pesquisa: TFDMemTable): TFDMemTable;
var
  sqq_Pesquisa: TFDQuery;
begin
  sqq_Pesquisa := TFDQuery.Create(nil);
  sqq_Pesquisa.Name := 'sqq_pesquisa';
  sqq_Pesquisa.Close;
  sqq_Pesquisa.SQL.Clear;
  sqq_Pesquisa.Connection := DataModule1.FB;
  sqq_Pesquisa.SQL.Add(SQL_ConsultaGridPesquisa());
  sqq_Pesquisa.Open;
  if not(sqq_Pesquisa.IsEmpty) then
  begin
    sqq_Pesquisa.FetchAll;
    fdmt_Pesquisa.Data := sqq_Pesquisa.Data;
  end;
  Result := fdmt_Pesquisa;
end;

class function TReceitaCServidor.Inserir(objReceita: TReceitaVO): boolean;
var
  sqq_Inserir: TFDQuery;
  i,iId: Integer;
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
      sqq_Inserir.Params.ParamByName('ID_PEDIDO').AsInteger  :=  objReceita.ID_PEDIDO;
      sqq_Inserir.Params.ParamByName('ID_TECNICO').AsInteger :=  objReceita.ID_TECNICO;
      sqq_Inserir.Params.ParamByName('ASSINADO').AsInteger   :=  objReceita.ASSINADO;
      sqq_Inserir.ExecSQL();
      sqq_Inserir.Connection.Commit;
      iId :=   sqq_Inserir.Params.ParamByName('id').AsInteger;
      for I := 0 to objReceita.ItemVO.Count-1 do
      begin
        TReceitaItemCServidor.Inserir(iId,objReceita.ItemVO[i]);
      end;
      TPedidoCServidor.AlteraStatusPedido(objReceita.ID_PEDIDO,1);
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



class function TReceitaCServidor.SQL_Baixar: string;
begin
  result := 'update receita                      '+
            'set data_assinatura = current_date, '+
            '    assinado = 1                    '+
            'where (id = :id)                    ';
end;

class function TReceitaCServidor.SQL_ConsultaGridPesquisa: String;
begin
  result := 'select                                         '+
            '    case r.assinado                            '+
            '    when 0 then ''Não''                        '+
            '    when 1 then ''Sim''                        '+
            '    end as assinado,                           '+
            '    r.data_assinatura,                         '+
            '    r.id, r.id_pedido as Pedido,               '+
            '    r.id_tecnico as Tecnico, t.nome            '+
            'from receita r                                 '+
            'inner join tecnico t on (t.id = r.id_tecnico)  '+
            'order by r.id                                  ';
end;

class function TReceitaCServidor.SQL_Inserir: String;
begin
  result := 'insert into RECEITA (id, ID_PEDIDO, ID_TECNICO,ASSINADO)          '+
            'values (gen_id(gen_receita,1), :ID_PEDIDO, :ID_TECNICO,:ASSINADO) '+
            'RETURNING id {INTO :id}                                           ';
end;

end.
