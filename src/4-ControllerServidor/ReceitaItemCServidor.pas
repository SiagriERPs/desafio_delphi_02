unit ReceitaItemCServidor;

interface
uses ClienteVO,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  FireDAC.DApt,
  FDConexao,SysUtils, System.Classes, ReceitaVO, ReceitaItemVO;

type
  TReceitaItemCServidor = class
    private
    // SQL's CRUD
    class function SQL_Inserir():String;
    class function SQL_ConsultaGridPesquisa():String;

    public
      //funções de crud
    class function Inserir(iId: Integer;objReceitaItem: TReceitaItemVO): boolean;
    class function ConsultaGridPesquisa(iId:Integer;fdmt_Pesquisa: TFDMemTable): TFDMemTable;

  end;

implementation

{ TClienteCServidor }

class function TReceitaItemCServidor.ConsultaGridPesquisa(iId: Integer;
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
  sqq_Pesquisa.Params.ParamByName('iId').AsInteger := iId;
  sqq_Pesquisa.Open;
  if not(sqq_Pesquisa.IsEmpty) then
  begin
    sqq_Pesquisa.FetchAll;
    fdmt_Pesquisa.Data := sqq_Pesquisa.Data;
  end;
  Result := fdmt_Pesquisa;
end;

class function TReceitaItemCServidor.Inserir(iId: Integer;objReceitaItem: TReceitaItemVO): boolean;
var
  sqq_InserirLista: TFDQuery;
begin
  try
    sqq_InserirLista := TFDQuery.Create(nil);
    sqq_InserirLista.Name := 'sqq_InserirLista';
    sqq_InserirLista.SQL.Clear;
    sqq_InserirLista.Params.Clear;
    try
      sqq_InserirLista.Connection := DataModule1.FB;
      sqq_InserirLista.Connection.StartTransaction;
      sqq_InserirLista.SQL.Add(sql_Inserir);
      sqq_InserirLista.Prepared := True;
      sqq_InserirLista.Params.ParamByName('ID_PRODUTO').AsInteger
        :=  objReceitaItem.ID_PRODUTO;

      sqq_InserirLista.Params.ParamByName('ID_RECEITA').AsInteger := iId;
      sqq_InserirLista.ExecSQL();
      sqq_InserirLista.Connection.Commit;
      Result := true;
    except
      on E: Exception do
      begin
        sqq_InserirLista.Connection.Rollback;
        raise Exception.Create('Erro ao inserir registro. ' + E.Message);
        Result := false;
      end;
    end;
  finally
    FreeAndNil(sqq_InserirLista);
  end;
end;



class function TReceitaItemCServidor.SQL_ConsultaGridPesquisa: String;
begin
  Result := 'select                                          '+
            'ri.id, ri.id_produto,p.nome                     '+
            'from                                            '+
            'receita_item ri                                 '+
            'inner join produto p on (p.id = ri.id_produto)  '+
            'where rI.id_receita = :iId                      ';
end;

class function TReceitaItemCServidor.SQL_Inserir: String;
begin
  result := 'insert into RECEITA_ITEM (id, ID_PRODUTO,ID_RECEITA)         '+
            'values (gen_id(gen_receita_item,1), :ID_PRODUTO,:ID_RECEITA)  ';

end;

end.
