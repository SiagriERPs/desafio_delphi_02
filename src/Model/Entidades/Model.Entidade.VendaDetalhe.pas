unit Model.Entidade.VendaDetalhe;

interface
uses Model.DAO.Interfaces;

type
  TVendaDetalhe = class
    private
      [weak]
      FParent:iDAOEntidade<TVendaDetalhe>;
      FId:Integer;
      FIdVendaCabecalho:Integer;
      FIdProduto:Integer;
      FQuantidade:Real;
      FValorUnitario:Real;
      FValorTotal:Real;
      FControleEspecial:String;
      FIdTecnicoAgricola:Integer;


    public
      constructor Create(Parent:iDAOEntidade<TVendaDetalhe>);
      destructor Destroy;override;
      function Id(Value : Integer):TVendaDetalhe;overload;
      function Id:Integer;overload;

      function IdVendaCabecalho(Value : Integer):TVendaDetalhe;overload;
      function IdVendaCabecalho:Integer;overload;

      function IdProduto(Value : Integer):TVendaDetalhe;overload;
      function IdProduto:Integer;overload;

      function Quantidade(Value:Real): TVendaDetalhe;overload;
      function Quantidade:Real; overload;

      function ValorUnitario(Value:Real): TVendaDetalhe;overload;
      function ValorUnitario:real; overload;

      function ValorTotal(Value:Real): TVendaDetalhe;overload;
      function ValorTotal:Real; overload;

      function IdTecnicoAgricola(Value : Integer):TVendaDetalhe;overload;
      function IdTecnicoAgricola:Integer;overload;

      function ControleEspecial(Value : String):TVendaDetalhe;overload;
      function ControleEspecial:String;overload;

      function &End: iDAOEntidade<TVendaDetalhe>;
  end;




implementation

{ TVendaDetalhe }

function TVendaDetalhe.Id(Value: Integer): TVendaDetalhe;
begin
  Result := Self;
  FId := Value;
end;

function TVendaDetalhe.Id: Integer;
begin
  Result := FId;
end;

function TVendaDetalhe.IdVendaCabecalho(Value: Integer): TVendaDetalhe;
begin
  Result := Self;
  FIdVendaCabecalho := Value;
end;

function TVendaDetalhe.IdVendaCabecalho: Integer;
begin
  Result := FIdVendaCabecalho;
end;

function TVendaDetalhe.IdProduto(Value: Integer): TVendaDetalhe;
begin
  Result := Self;
  FIdProduto := Value;
end;

function TVendaDetalhe.IdProduto: Integer;
begin
  Result := FIdProduto;
end;



function TVendaDetalhe.Quantidade(Value: Real): TVendaDetalhe;
begin
  Result:=Self;
  FQuantidade:=Value;
end;

function TVendaDetalhe.Quantidade: Real;
begin
  Result:=FQuantidade;
end;

function TVendaDetalhe.ValorUnitario: Real;
begin
  Result:=FValorUnitario;
end;

function TVendaDetalhe.ValorUnitario(Value: Real): TVendaDetalhe;
begin
  Result:=Self;
  FValorUnitario:=Value;
end;

function TVendaDetalhe.ValorTotal: Real;
begin
  Result:=FValorTotal;
end;

function TVendaDetalhe.ValorTotal(Value: Real): TVendaDetalhe;
begin
  Result:=self;
  FValorTotal:=Value;
end;



function TVendaDetalhe.ControleEspecial(Value: String): TVendaDetalhe;
begin
  Result:=Self;
  FControleEspecial:=Value;
end;

function TVendaDetalhe.ControleEspecial: String;
begin
  Result:=FControleEspecial;
end;

function TVendaDetalhe.IdTecnicoAgricola(Value: Integer): TVendaDetalhe;
begin
  Result:=Self;
  FIdTecnicoAgricola:=Value;
end;

function TVendaDetalhe.IdTecnicoAgricola: Integer;
begin
  Result:=FIdTecnicoAgricola;
end;

constructor TVendaDetalhe.Create(Parent: iDAOEntidade<TVendaDetalhe>);
begin
  FParent := Parent;
end;

destructor TVendaDetalhe.Destroy;
begin
  inherited;
end;

function TVendaDetalhe.&End: iDAOEntidade<TVendaDetalhe>;
begin
  Result := FParent;
end;



end.
