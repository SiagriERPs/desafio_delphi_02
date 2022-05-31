unit Model.Entidade.Produto;

interface
uses Model.DAO.Interfaces,System.SysUtils;

type
  TProduto = class
    private
      [weak]
      FParent:iDAOEntidade<TProduto>;
      FId:Integer;
      FNome:String;
      FValor:real;
      FControleEspecial:String;
    public
      constructor Create(Parent:iDAOEntidade<TProduto>);
      destructor Destroy;override;
      function Id(Value : Integer):TProduto;overload;
      function Id:Integer;overload;
      function Nome(Value:String): TProduto;overload;
      function Nome:String; overload;
      function Valor(Value:real): TProduto;overload;
      function Valor:real; overload;
      function ControleEspecial(Value:String): TProduto;overload;
      function ControleEspecial:String; overload;
      function &End: iDAOEntidade<TProduto>;
  end;




implementation

{ TProduto }

function TProduto.Valor: real;
begin
  if not (FValor > 0) then
  raise Exception.Create('Campo valor deve ser maior que zero!');
  Result:=FValor;
end;

function TProduto.Valor(Value: real): TProduto;
begin
  Result:=Self;
  FValor:=Value;
end;

function TProduto.ControleEspecial: String;
begin
  Result:=FControleEspecial;
end;

function TProduto.ControleEspecial(Value: String): TProduto;
begin
  Result:=self;
  FControleEspecial:=Value;
end;

constructor TProduto.Create(Parent: iDAOEntidade<TProduto>);
begin
  FParent := Parent;
end;

function TProduto.Nome(Value: String): TProduto;
begin
  Result:=Self;
  FNome:=trim(Value);
end;

function TProduto.Nome: String;
begin
  if FNome = '' then
  raise Exception.Create('Campo nome é de preenchimento obrigatório');
  if Length(FNome)< 5 then
  raise Exception.Create('Campo nome deve conter pelo menos 5 caracteres');
  Result:=FNome;
end;

destructor TProduto.Destroy;
begin
  inherited;
end;

function TProduto.&End: iDAOEntidade<TProduto>;
begin
  Result := FParent;
end;

function TProduto.Id(Value: Integer): TProduto;
begin
  Result := Self;
  FId := Value;
end;

function TProduto.Id: Integer;
begin
  Result := FId;
end;

end.
