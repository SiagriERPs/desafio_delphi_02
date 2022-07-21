unit biblioteca;

interface

uses
  System.SysUtils, Vcl.Forms, Winapi.Windows;
type
  TVersaoDLL = function: Integer; stdcall;

procedure SoNumeroVirgula(var Key: char);
function MaskReal(sTexto: String): String;
function Mensagem(Mens, Titulo: String; Tipo: Byte): Byte;
function MsgCrud(sAcao: String): Boolean;
function Confirma(Mens: String): Boolean;
procedure Aviso(Mens: String);
procedure Erro(Mens: String);
function validaCpf(cpf: string): Boolean;

implementation

function MaskReal(sTexto: String): String;
begin
  Result := FormatCurr('###,###,###,##0.0000', StrToCurr(sTexto));
end;

procedure SoNumeroVirgula(var Key: char);
begin
  if not((Key in ['0' .. '9', #8]) or (Key = ',')) then
    Key := #0;
end;

function MsgCrud(sAcao: String): Boolean;
begin
  if (sAcao = 'Inserir') then
  begin
    with Application do
    begin
      NormalizeTopMosts;
      MessageBox('Registro Inserido com Sucesso!', 'Atenção',
                  MB_OK + MB_ICONINFORMATION);
      RestoreTopMosts;
    end;
    Result := True;
  end
  else
  if (sAcao = 'Editar')  then
  begin
    with Application do
    begin
      NormalizeTopMosts;
      MessageBox('Registro Editado com Sucesso!', 'Atenção',
                  MB_OK + MB_ICONINFORMATION);
      RestoreTopMosts;
    end;
    Result := True;
  end
  else
  if (sAcao = 'Excluir') then
  begin
    with Application do
    begin
      NormalizeTopMosts;
      if (MessageBox('Deseja Excluir o registro ?', 'Atenção',
          MB_ICONERROR + MB_YESNO + MB_DEFBUTTON2) = IDYES) then
        Result := True
      else
        Result := false;
      RestoreTopMosts;
    end;
  end;
end;

function Mensagem(Mens, Titulo: String; Tipo: Byte): Byte;
begin
  case Tipo of
    1:
      Result := Application.MessageBox(Pchar(Mens), Pchar(Titulo),
        MB_YESNO + MB_ICONQUESTION);
    2:
      Result := Application.MessageBox(Pchar(Mens), Pchar(Titulo),
        MB_OK + MB_ICONWARNING);
    3:
      Result := Application.MessageBox(Pchar(Mens), Pchar(Titulo),
        MB_OK + MB_ICONERROR);
    4:
      Result := Application.MessageBox(Pchar(Mens), Pchar(Titulo),
        MB_OK + MB_ICONINFORMATION);
  else
    Result := 0;
  end;
end;

function Confirma(Mens: String): Boolean;
begin
  Result := (Mensagem(Mens, 'ATENÇÃO!', 1) = idYes);
end;

procedure Aviso(Mens: String);
begin
  Mensagem(Mens, 'AVISO!', 2);
end;

procedure Erro(Mens: String);
begin
  Mensagem(Mens, 'ERRO!', 3);
end;

function validaCpf(cpf: string): Boolean;
var  dig10, dig11: string;
    s, i, r, peso: integer;
begin
  if ((CPF = '00000000000') or (CPF = '11111111111') or
      (CPF = '22222222222') or (CPF = '33333333333') or
      (CPF = '44444444444') or (CPF = '55555555555') or
      (CPF = '66666666666') or (CPF = '77777777777') or
      (CPF = '88888888888') or (CPF = '99999999999') or
      (length(CPF) <> 11))
  then
  begin
   result := false;
   Erro('CPF incorreto');
   exit;
  end;

  try
    s := 0;
    peso := 10;
    for i := 1 to 9 do
    begin
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig10 := '0'
    else str(r:1, dig10);

    s := 0;
    peso := 11;
    for i := 1 to 10 do
    begin
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig11 := '0'
    else str(r:1, dig11);

    if ((dig10 = CPF[10]) and (dig11 = CPF[11]))
       then result := true
    else
    begin
      Erro('CPF incorreto');
      result := false;
    end;
  except
    result := false
  end;
end;


end.
