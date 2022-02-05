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

initialization
  dmDados := TdmDados.Create(nil);
finalization
  FreeAndNil(dmDados);

end.
