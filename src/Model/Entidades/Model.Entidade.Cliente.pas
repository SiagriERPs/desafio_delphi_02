unit Model.Entidade.Cliente;

interface
uses Model.DAO.Interfaces,System.SysUtils,Biblioteca,Data.DB;

type
  TCliente = class
    private
      [weak]
      FParent:iDAOEntidade<TCliente>;
      FId:Integer;
      FNome:String;
      FCpf:String;

      function ConsultaCpfJaCadastrado():boolean;
    public
      constructor Create(Parent:iDAOEntidade<TCliente>);
      destructor Destroy;override;
      function Id(Value : Integer):TCliente;overload;
      function Id:Integer;overload;
      function Nome(Value:String): TCliente;overload;
      function Nome:String; overload;
      function Cpf(Value:String): TCliente;overload;
      function Cpf:String; overload;
      function &End: iDAOEntidade<TCliente>;
  end;

implementation
uses Controller.Interfaces,Model.DAOCliente;

{ TCliente }

function TCliente.ConsultaCpfJaCadastrado(): boolean;
var Ds:TDataSource;
DaoCliente:TDAOCliente;
begin
  Result:=false;
  try
    //Controller:=TController.New;
    Ds:=TDataSource.Create(nil);
    //FDaoCliente:TDaoCLiente.
    if not (FID > 0) then
    begin
      //FParent.ConsultarLista.DataSet(Ds);
      DaoCliente:=TDAOCliente.Create;
      DaoCliente.ConsultaLista('CPF = '+QuotedStr(FCpf)).DataSet(Ds);
      //FParent.
      if Ds.DataSet.RecordCount > 0 then
      Result:=true;
    end;
  finally
    Ds.Free;
  end;
end;

function TCliente.Cpf: String;
begin
  if FCpf<>'' then
  begin
    if Biblioteca.ValidaCpf(FCpf) = false then
    raise Exception.Create('Erro ao validar CPF');
    if ConsultaCpfJaCadastrado = true then
    raise Exception.Create('Este Cpf já está cadastrado no sistema');
    Result:=FCpf
  end;
end;

function TCliente.Cpf(Value: String): TCliente;
begin
  Result:=Self;
  FCpf:=trim(Value);
end;

constructor TCliente.Create(Parent: iDAOEntidade<TCliente>);
begin
  FParent := Parent;
end;

function TCliente.Nome(Value: String): TCliente;
begin
  Result:=Self;
  FNome:=trim(Value);
end;

function TCliente.Nome: String;
begin
  if FNome = '' then
  raise Exception.Create('Campo nome é de preenchimento obrigatório')
  else if Length(FNome) < 5 then
  raise Exception.Create('Nome der ter no minimo 5 caracteres')
  else
  Result:=FNome;
end;

destructor TCliente.Destroy;
begin
  inherited;
end;

function TCliente.&End: iDAOEntidade<TCliente>;
begin
  Result := FParent;
end;

function TCliente.Id(Value: Integer): TCliente;
begin
  Result := Self;
  FId := Value;
end;

function TCliente.Id: Integer;
begin
  Result := FId;
end;

end.
