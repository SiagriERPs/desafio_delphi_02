unit udmDados;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.SqlExpr, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  System.IniFiles;

type
  TdmDados = class(TDataModule)
    Conexao: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    procedure PesquisaCliente(qryTabela: TFDQuery; pCodigo: String);
    procedure PesquisaTecnico(qryTabela: TFDQuery; pCodigo: String);
    procedure PesquisaProduto(out qryProduto: TFDQuery; pCodigo : String);
    function CPFJaExiste(pTable, pField, pValor : String; pID : Integer): String;
    function Generation(pTable : String) : Integer;
  end;

var
  dmDados: TdmDados;

implementation

uses
  Vcl.Forms, Vcl.Dialogs;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


procedure TdmDados.DataModuleCreate(Sender: TObject);
begin
  Conexao.Connected := true;
end;

procedure TdmDados.DataModuleDestroy(Sender: TObject);
begin
  Conexao.Connected := false;
end;

//Método: Verifica se o CPF já consta na base. Poderá ser usando
//        tanto para o Cad. Cliente / Cad. Tecnicos
function TdmDados.CPFJaExiste(pTable, pField, pValor : String; pID : Integer) : String;
var
  qryCons : TFDQuery;
begin
  Result := '';
  try
    qryCons := TFDQuery.Create(nil);
    qryCons.Connection := Conexao;
    qryCons.ConnectionName := 'DataBase';
    qryCons.Close;
    qryCons.sql.Clear;
    qryCons.sql.Add('SELECT '+pField+'_ID  ||'' - ''||'+
                              pField+'_NOME||'' - ''||'+
                              pField+'_CPF ');
    qryCons.sql.Add('  FROM '+pTable);
    qryCons.sql.Add(' WHERE '+pField+'_CPF  = :CPF');
    qryCons.sql.Add('   AND '+pField+'_ID  <> :ID');
    qryCons.ParamByName('CPF').AsString := pValor;
    qryCons.ParamByName('ID').AsInteger := pID;
    qryCons.Active := true;
    Result := qryCons.Fields[0].AsString;
  finally
    FreeAndNil(qryCons);
  end;
end;

//Geração do ID
function TdmDados.Generation(pTable: String): Integer;
var
  qryCons : TFDQuery;
begin
  try
    qryCons := TFDQuery.Create(nil);
    qryCons.Connection := Conexao;
    qryCons.ConnectionName := 'DataBase';
    qryCons.Close;
    qryCons.sql.Clear;
    qryCons.sql.Add('SELECT GEN_ID('+pTable+', 1) FROM RDB$DATABASE');
    qryCons.Active := true;
    Result := qryCons.Fields[0].AsInteger;
  finally
    FreeAndNil(qryCons);
  end;
end;

procedure TdmDados.PesquisaCliente(qryTabela : TFDQuery; pCodigo : String);
var
  qryCons : TFDQuery;
begin
  try
    qryCons := TFDQuery.Create(nil);
    qryCons.Connection := dmDados.Conexao;
    qryCons.Close;
    qryCons.SQL.Clear;
    qryCons.sql.Add('SELECT CLIE_NOME,CLIE_CPF FROM CLIENTES WHERE CLIE_ID = ' + pCodigo);
    qryCons.Open();
    if qryCons.IsEmpty then
    begin
      ShowMessage('Cliente não encontrado!');
      Exit;
    end;
    if Assigned(qryTabela.FieldByName('PEDI_CLIE_NOME')) then
      qryTabela.FieldByName('PEDI_CLIE_NOME').AsString := qryCons.Fields[0].AsString;
    if Assigned(qryTabela.FieldByName('PEDI_CLIE_CPF')) then
      qryTabela.FieldByName('PEDI_CLIE_CPF').AsString  := qryCons.Fields[1].AsString;
  finally
    FreeAndNil(qryCons);
  end;
end;

procedure TdmDados.PesquisaProduto(out qryProduto : TFDQuery; pCodigo : String);
var
  qryCons : TFDQuery;
begin
  try
    qryCons := TFDQuery.Create(nil);
    qryCons.Connection := dmDados.Conexao;
    qryCons.Close;
    qryCons.SQL.Clear;
    qryCons.sql.Add('SELECT PROD_NOME,PROD_VALOR,PROD_CONTROLE FROM PRODUTOS WHERE PROD_ID = ' + pCodigo);
    qryCons.Open();
    if qryCons.IsEmpty then
    begin
      ShowMessage('Produtos não encontrado!');
      Exit;
    end;
    if Assigned(qryProduto.FieldByName('ITEM_PROD_NOME')) then
      qryProduto.FieldByName('ITEM_PROD_NOME').AsString     := qryCons.Fields[0].AsString;
    if Assigned(qryProduto.FieldByName('ITEM_QTDADE')) then
      qryProduto.FieldByName('ITEM_QTDADE').AsFloat         := 1;
    if Assigned(qryProduto.FieldByName('ITEM_VLRUNIT')) then
      qryProduto.FieldByName('ITEM_VLRUNIT').AsFloat        := qryCons.Fields[1].AsFloat;
    if Assigned(qryProduto.FieldByName('ITEM_PROD_CONTROLE')) then
      qryProduto.FieldByName('ITEM_PROD_CONTROLE').AsString := qryCons.Fields[2].AsString;
  finally
    FreeAndNil(qryCons);
  end;
end;

procedure TdmDados.PesquisaTecnico(qryTabela: TFDQuery; pCodigo: String);
var
  qryCons : TFDQuery;
begin
  try
    qryCons := TFDQuery.Create(nil);
    qryCons.Connection := dmDados.Conexao;
    qryCons.Close;
    qryCons.SQL.Clear;
    qryCons.sql.Add('SELECT TECN_NOME, TECN_CPF, TECN_NR_REGISTRO FROM TECNICOS WHERE TECN_ID = ' + pCodigo);
    qryCons.Open();
    if qryCons.IsEmpty then
    begin
      ShowMessage('Técnido não encontrado!');
      Exit;
    end;
    if Assigned(qryTabela.FieldByName('PEDI_TECN_NOME')) then
      qryTabela.FieldByName('PEDI_TECN_NOME').AsString := qryCons.Fields[0].AsString;
    if Assigned(qryTabela.FieldByName('PEDI_TECN_CPF')) then
      qryTabela.FieldByName('PEDI_TECN_CPF').AsString  := qryCons.Fields[1].AsString;
    if Assigned(qryTabela.FieldByName('PEDI_TECN_NR_REGISTRO')) then
      qryTabela.FieldByName('PEDI_TECN_NR_REGISTRO').AsString  := qryCons.Fields[2].AsString;
  finally
    FreeAndNil(qryCons);
  end;
end;

initialization
  dmDados := TdmDados.Create(nil);
finalization
  FreeAndNil(dmDados);

end.
