unit Model.Entidade.TecnicoAgricola;

interface
uses Model.DAO.Interfaces,System.SysUtils;

type
  TTecnicoAgricola = class
    private
      [weak]
      FParent:iDAOEntidade<TTecnicoAgricola>;
      FId:Integer;
      FNome:String;
      FNumeroRegistro:String;
    public
      constructor Create(Parent:iDAOEntidade<TTecnicoAgricola>);
      destructor Destroy;override;
      function Id(Value : Integer):TTecnicoAgricola;overload;
      function Id:Integer;overload;
      function Nome(Value:String): TTecnicoAgricola;overload;
      function Nome:String; overload;
      function NumeroRegistro(Value:String): TTecnicoAgricola;overload;
      function NumeroRegistro:String; overload;
      function &End: iDAOEntidade<TTecnicoAgricola>;
  end;




implementation

{ TTecnicoAgricola }



function TTecnicoAgricola.NumeroRegistro: String;
begin
  Result:=FNumeroRegistro;
end;

function TTecnicoAgricola.NumeroRegistro(Value: String): TTecnicoAgricola;
begin
  Result:=self;
  FNumeroRegistro:=Value;
end;

constructor TTecnicoAgricola.Create(Parent: iDAOEntidade<TTecnicoAgricola>);
begin
  FParent := Parent;
end;

function TTecnicoAgricola.Nome(Value: String): TTecnicoAgricola;
begin
  Result:=Self;
  FNome:=trim(Value);
end;

function TTecnicoAgricola.Nome: String;
begin
  if FNome = '' then
  raise Exception.Create('Campo nome é de preenchimento obrigatório');
  if Length(FNome)< 5 then
  raise Exception.Create('Campo nome deve conter pelo menos 5 caracteres');
  Result:=FNome;
end;

destructor TTecnicoAgricola.Destroy;
begin
  inherited;
end;

function TTecnicoAgricola.&End: iDAOEntidade<TTecnicoAgricola>;
begin
  Result := FParent;
end;

function TTecnicoAgricola.Id(Value: Integer): TTecnicoAgricola;
begin
  Result := Self;
  FId := Value;
end;

function TTecnicoAgricola.Id: Integer;
begin
  Result := FId;
end;

end.
