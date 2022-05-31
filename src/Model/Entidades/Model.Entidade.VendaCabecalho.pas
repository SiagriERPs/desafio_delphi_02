unit Model.Entidade.VendaCabecalho;

interface
uses Model.DAO.Interfaces,System.SysUtils,Model.Entidade.VendaDetalhe;

type
  TVendaCabecalho = class
    private
      [weak]
      FParent:iDAOEntidade<TVendaCabecalho>;
      FId:Integer;
      FIdCliente:Integer;
      FDataVenda:TDateTime;
      FValor:real;
      FStatusVenda:String;
      FQuantidadeItensVenda:Integer;
      //FVendaDetalhe:TObjectList<TVendaDetalhe>;
    public
      constructor Create(Parent:iDAOEntidade<TVendaCabecalho>);
      destructor Destroy;override;
      function Id(Value : Integer):TVendaCabecalho;overload;
      function Id:Integer;overload;
      function IdCliente(Value : Integer):TVendaCabecalho;overload;
      function IdCliente:Integer;overload;
      function DataVenda(Value:TDateTime): TVendaCabecalho;overload;
      function DataVenda:TDateTime; overload;
      function Valor(Value:real): TVendaCabecalho;overload;
      function Valor:real; overload;
      function StatusVenda(Value:String): TVendaCabecalho;overload;
      function StatusVenda:String; overload;
      function QuantidadeItensVenda(Value:Integer):TVendaCabecalho;overload;
      function QuantidadeItensVenda:Integer;overload;




      function &End: iDAOEntidade<TVendaCabecalho>;
  end;




implementation

{ TVendaCabecalho }

function TVendaCabecalho.Id(Value: Integer): TVendaCabecalho;
begin
  Result := Self;
  FId := Value;
end;

function TVendaCabecalho.Id: Integer;
begin
  Result := FId;
end;

function TVendaCabecalho.IdCliente(Value: Integer): TVendaCabecalho;
begin
  Result := Self;
  FIdCliente := Value;
end;

function TVendaCabecalho.IdCliente: Integer;
begin
  if not (FIdCliente > 0 ) then
  raise Exception.Create('Campo cliente é de preenchimento obrigatório!');
  Result := FIdCliente;
end;

function TVendaCabecalho.QuantidadeItensVenda: Integer;
begin
  if not(FQuantidadeItensVenda > 0) then
  raise Exception.Create('Venda deve ter pelo menos um item cadastrado')
  else
  Result:= FQuantidadeItensVenda;
end;

function TVendaCabecalho.QuantidadeItensVenda(Value: Integer): TVendaCabecalho;
begin
  Result:=Self;
  FQuantidadeItensVenda:=Value;
  if not(FQuantidadeItensVenda > 0) then
  raise Exception.Create('Venda deve ter pelo menos um item cadastrado')
end;

function TVendaCabecalho.DataVenda(Value: TDateTime): TVendaCabecalho;
begin
  Result:=Self;
  FDataVenda:=Value;
end;

function TVendaCabecalho.DataVenda: TDateTime;
begin
  Result:=FDataVenda;
end;

function TVendaCabecalho.Valor: real;
begin
  if not (FVALOR > 0 ) then
  raise Exception.Create('Campo valor deve ser maior que zero!');
  Result:=FValor;
end;

function TVendaCabecalho.Valor(Value: real): TVendaCabecalho;
begin
  Result:=Self;
  FValor:=Value;
end;

function TVendaCabecalho.StatusVenda: String;
begin
  if (FStatusVenda = '') or (length(FStatusVenda)>1) then
  raise Exception.Create('Campo status da venda inválido!');
  Result:=FStatusVenda;
end;

function TVendaCabecalho.StatusVenda(Value: String): TVendaCabecalho;
begin
  Result:=self;
  FStatusVenda:=Value;
end;

constructor TVendaCabecalho.Create(Parent: iDAOEntidade<TVendaCabecalho>);
begin
  FParent := Parent;
end;

destructor TVendaCabecalho.Destroy;
begin
  inherited;
end;

function TVendaCabecalho.&End: iDAOEntidade<TVendaCabecalho>;
begin
  Result := FParent;
end;



end.
