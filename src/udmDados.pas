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
    function Generation(pTable : String) : Integer;
  end;

var
  dmDados: TdmDados;

implementation

uses
  Vcl.Forms;

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

initialization
  dmDados := TdmDados.Create(nil);
finalization
  FreeAndNil(dmDados);

end.
