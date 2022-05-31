unit Controller.VendaCabecalho;
interface
uses Model.DAOVendaCabecalho,Datasnap.DBClient,Data.DB,Biblioteca,Vcl.Dialogs;

type
  TControllerVendaCabecalho = Class
    public
      function AssinarReceita(IdVenda,IdTecnicoAgricola:Integer):boolean;
      function CalcularValorTotalItem(Cds:TClientDataSet):boolean;
      function ValidarRegitroVendaDetalhe(Cds:TClientDataSet):boolean;
      function CalcularTotalVenda(Cds:TClientDataSet):Currency;
      function VerificaPermissaoAlteracaoVenda(StatusVenda:String):boolean;
      procedure AtualizarStatus(IdVenda: Integer);
      constructor Create;
      destructor Destroy;override;
      class function New : TControllerVendaCabecalho;
  End;

implementation

{ TControllerVendaCabecalho }

function TControllerVendaCabecalho.AssinarReceita(IdVenda,IdTecnicoAgricola: Integer): boolean;
var DaoVendaCabecalho:TDAOVendaCabecalho;
begin
  try
    DaoVendaCabecalho:=TDAOVendaCabecalho.Create;
    DaoVendaCabecalho.AssinarReceita(IdVenda,IdTecnicoAgricola);
  finally
    //DaoVendaCabecalho.Free;
  end;

end;


procedure TControllerVendaCabecalho.AtualizarStatus(IdVenda: Integer);
var DaoVendaCabecalho:TDAOVendaCabecalho;
begin
  try
    DaoVendaCabecalho:=TDAOVendaCabecalho.Create;
    DaoVendaCabecalho.AtualizarStatus(IdVenda);
  finally

  end;
end;

function TControllerVendaCabecalho.CalcularTotalVenda(Cds: TClientDataSet):Currency;
var
  ValorTotal:Currency;
  ItemSelecionadoAntesDoLop:Integer;
begin

  ValorTotal:=0;
  Cds.DisableControls;
  Cds.First;
  while not Cds.Eof do
  begin
    ValorTotal := ValorTotal + Cds.FieldByName('VALOR_TOTAL').AsExtended;
    Cds.Next;
  end;
  Cds.EnableControls;
  Result:=ValorTotal;
end;

function TControllerVendaCabecalho.CalcularValorTotalItem(Cds: TClientDataSet): boolean;
var Quantidade,ValorUnitario:Extended;
SubTotal,Desconto,Acrescimos,ValorTotal:Currency;
begin
  if (Cds.State = dsInsert) or (Cds.State = dsEdit) then
  begin
    Quantidade:=ArredondaTruncaValor('A',Cds.FieldByName('QUANTIDADE').AsFloat,4);
    ValorUnitario:=ArredondaTruncaValor('A',Cds.FieldByName('VALOR_UNITARIO').AsFloat,10);
    ValorTotal:=ArredondaTruncaValor('A',Quantidade*ValorUnitario,2);
    Cds.FieldByName('VALOR_TOTAL').AsFloat:= ValorTotal;
  end;

end;

constructor TControllerVendaCabecalho.Create;
begin

end;

destructor TControllerVendaCabecalho.Destroy;
begin

  inherited;
end;

class function TControllerVendaCabecalho.New: TControllerVendaCabecalho;
begin
  Result:=Self.Create;
end;

function TControllerVendaCabecalho.ValidarRegitroVendaDetalhe(
  Cds: TClientDataSet): boolean;
begin
  Result:=true;
  if not (Cds.FieldByName('ID_PRODUTO').AsInteger > 0) then
  begin
    Showmessage('Preenchimento de Produto é obrigatório');
    Exit(False);
  end;

  if not (Cds.FieldByName('VALOR_TOTAL').AsFloat > 0) then
  begin
    Showmessage('Valor total tem que ser maior que zero!');
    Exit(False);
  end;
end;

function TControllerVendaCabecalho.VerificaPermissaoAlteracaoVenda(
  StatusVenda: String): boolean;
begin
  Result:=True;
  if StatusVenda = 'C' then
  begin
    Showmessage('Venda não pode ser alterada! Venda concluida.');
    Result:=false
  end;
end;

end.
