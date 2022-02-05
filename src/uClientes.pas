unit uClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBasico, Vcl.StdCtrls, Vcl.Mask,
  Data.DB, Datasnap.DBClient, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrmClientes = class(TfrmBasico)
    Label3: TLabel;
    edtCPF: TDBEdit;
    qryTabelaCLIE_ID: TIntegerField;
    qryTabelaCLIE_NOME: TStringField;
    qryTabelaCLIE_CPF: TStringField;
    procedure btnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function ValidaDados: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmClientes: TfrmClientes;

implementation

{$R *.dfm}

uses udmDados;

procedure TfrmClientes.btnSalvarClick(Sender: TObject);
begin
  if not ValidaDados() then Exit;
  inherited;
end;

procedure TfrmClientes.FormCreate(Sender: TObject);
begin
  inherited;
  GeneID := 'CLIE_ID';
  Table  := 'CLIENTES';
end;

procedure TfrmClientes.FormShow(Sender: TObject);
begin
  SQL := 'SELECT * FROM CLIENTES ORDER BY CLIE_ID DESC';
  inherited;
end;

function TfrmClientes.ValidaDados() : Boolean;
var
  strMSG : String;

function CPFValido(): Boolean;
var
  n1,n2,n3,n4,n5,n6,n7,n8,n9: Integer;
  d1,d2: Integer;
  digitado, calculado: String;
  CPF_Text: String;
begin
  CPF_Text := edtCPF.Text;
  n1       := StrToInt(CPF_Text[1]);
  n2       := StrToInt(CPF_Text[2]);
  n3       := StrToInt(CPF_Text[3]);
  n4       := StrToInt(CPF_Text[5]);
  n5       := StrToInt(CPF_Text[6]);
  n6       := StrToInt(CPF_Text[7]);
  n7       := StrToInt(CPF_Text[9]);
  n8       := StrToInt(CPF_Text[10]);
  n9       := StrToInt(CPF_Text[11]);
  d1       := n9*2+n8*3+n7*4+n6*5+n5*6+n4*7+n3*8+n2*9+n1*10;
  d1       := 11-(d1 mod 11);
  if (d1>= 10) then d1:=0;
    d2 := d1*2+n9*3+n8*4+n7*5+n6*6+n5*7+n4*8+n3*9+n2*10+n1*11;
	d2 := 11-(d2 mod 11);
	if d2 >= 10 then
   	d2 := 0;
	calculado := IntToStr(d1)+IntToStr(d2);
  digitado  := CPF_Text[13]+CPF_Text[14];
  if calculado = digitado then
  	Result := true
  else
  	Result := false;
end;

begin
  Result := false;
  if Trim(edtNome.Text) = '' then begin
    ShowMessage('Necessário informar um nome antes de continuar!');
    if edtNome.CanFocus then
      edtNome.SetFocus;
    Exit;
  end;
  if ((Length(Trim(edtCPF.Text))<>14) or (not CPFValido())) then begin
    ShowMessage('Necessário informar um CPF válido antes de continuar!');
    if edtCPF.CanFocus then
      edtCPF.SetFocus;
    Exit;
  end;
  strMSG := dmDados.CPFJaExiste('CLIENTES',
                                'CLIE',
                                qryTabela.FieldByName('CLIE_CPF').AsString,
                                qryTabela.FieldByName('CLIE_ID').AsInteger);
  if Trim(strMSG)<>'' then
  begin
    ShowMessage('Já consta um cliente para o CPF informado!'+#13#13+strMSG);
    if edtCPF.CanFocus then
      edtCPF.SetFocus;
    Exit;
  end;
  Result := true;
end;

initialization
  frmClientes := TfrmClientes.Create(nil);
finalization
  FreeAndNil(frmClientes);

end.
