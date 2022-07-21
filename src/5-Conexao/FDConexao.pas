unit FDConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef,System.IniFiles,
  Vcl.Forms,biblioteca;

type
  TDataModule1 = class(TDataModule)
    FB: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
var sArquivo: TIniFile ;
    sCaminho,sCaminho2: string;
begin
   sArquivo           := TIniFile.Create((Extractfilepath(Application.ExeName) + '\conexao.ini'));
   sCaminho           := sArquivo.readstring('Conexao','Senha','');
   fb.Params.Database := sCaminho;
end;

end.
