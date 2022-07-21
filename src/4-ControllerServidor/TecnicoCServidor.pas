unit TecnicoCServidor;

interface
uses
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  FireDAC.DApt,
  FDConexao,SysUtils, System.Classes, TecnicoVO;

type
  TTecnicoCServidor = class
    private
    class function SQL_ConsultaObjId: string;
    class function SQL_ConsultaGridPesquisa(iItem:integer;sValorPesquisa : string):string;

    public
    //funcões de consultas
    class function ConsultaObjId(iId : Integer; objTecnico: TTecnicoVO):TTecnicoVO;
    class function ConsultaGridPesquisa(iItem:Integer;sValorPesquisa: String;
      fdmt_Pesquisa: TFDMemTable): TFDMemTable;
    class function CarregaComboBoxPadrao(Lista : TStringList):TStringList;
    class function MontaFiltro(item: Integer; sValorPesquisa: string): string;
  end;

implementation

{ TClienteCServidor }

class function TTecnicoCServidor.CarregaComboBoxPadrao(
  Lista: TStringList): TStringList;
begin
  Lista.add('Id');
  Lista.add('CPF');
  Lista.add('Nome');
  Lista.add('Num Registro');
  Result := Lista;
end;

class function TTecnicoCServidor.ConsultaGridPesquisa(iItem:Integer;
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

class function TTecnicoCServidor.ConsultaObjId(iId: Integer;
  objTecnico: TTecnicoVO): TTecnicoVO;
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
        objTecnico.ID            := sqq_Pesquisa.Fields.FieldByName('ID').AsInteger;
        objTecnico.CPF 	         := sqq_Pesquisa.Fields.FieldByName('CPF').AsString;
        objTecnico.NOME          := sqq_Pesquisa.Fields.FieldByName('NOME').AsString;
        objTecnico.NUM_REGISTRO  := sqq_Pesquisa.Fields.FieldByName('NUM_REGISTRO').AsString;
      end;
      result := objTecnico;
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

class function TTecnicoCServidor.MontaFiltro(item: Integer;
  sValorPesquisa: string): string;
var sfiltro: string;
begin
sfiltro := '';
  if Length(sValorPesquisa)>0 then
  begin
    case item of
     0: sfiltro := 'where Id = '+sValorPesquisa;
     1: sfiltro := 'where CPF like ''%'+sValorPesquisa+'%''';
     2: sfiltro := 'where Nome like ''%'+sValorPesquisa+'%''';
     3: sfiltro := 'where Num_registro like ''%'+sValorPesquisa+'%''';
    end;
  end;
  Result := sfiltro;
end;

class function TTecnicoCServidor.SQL_ConsultaObjId: string;
begin
  Result := 'select id, cpf, nome,num_registro '+
            'from tecnico                      '+
            'where id = :iId                   ';
end;

class function TTecnicoCServidor.SQL_ConsultaGridPesquisa(iItem:integer;
sValorPesquisa: string): string;
begin
  Result := 'select id,cpf, nome, num_registro       '+
            'from tecnico                             '+
            MontaFiltro(iItem,sValorPesquisa)         +
            ' order by nome                            ';
end;

end.
