unit Controller.Entidades;

interface

uses
  Controller.Interfaces,
  Model.DAO.Interfaces,
  Model.Entidade.Cliente,
  Model.Entidade.Produto,
  Model.Entidade.VendaCabecalho,
  Model.Entidade.VendaDetalhe,
  Model.Entidade.TecnicoAgricola,
  Model.DAOCliente,
  Model.DAOProduto,
  Model.DAOVendaCabecalho,
  Model.DAOVendaDetalhe,
  Model.DAOTecnicoAgricola;

  type
    TControllerEntidades = class(TInterfacedObject,iControllerEntidades)
      private
        FCLiente: iDAOEntidade<TCliente>;
        FProduto: iDAOEntidade<TProduto>;
        FVendaCabecalho:iDAOEntidade<TVendaCabecalho>;
        FVendaDetalhe:iDAOEntidade<TVendaDetalhe>;
        FTecnicoAgricola:iDAOEntidade<TTecnicoAgricola>;
      public
        constructor Create;
        destructor Destroy;override;
        class function New:iControllerEntidades;
        function Cliente:iDAOEntidade<TCliente>;
        function Produto:iDAOEntidade<TProduto>;
        function VendaCabecalho:iDAOEntidade<TVendaCabecalho>;
        function VendaDetalhe:iDAOEntidade<TVendaDetalhe>;
        function TecnicoAgricola:iDAOEntidade<TTecnicoAgricola>;

    end;

implementation

{ TControllerEntidades }

constructor TControllerEntidades.Create;
begin

end;

destructor TControllerEntidades.Destroy;
begin
  inherited;
end;

class function TControllerEntidades.New: iControllerEntidades;
begin
  Result:=Self.Create;
end;

function TControllerEntidades.Produto: iDAOEntidade<TProduto>;
begin
  if not Assigned(FProduto) then
    FProduto:=TDAOProduto.New;
  Result:=FProduto;
end;

function TControllerEntidades.VendaCabecalho: iDAOEntidade<TVendaCabecalho>;
begin
  if not Assigned(FVendaCabecalho) then
    FVendaCabecalho:= TDAOVendaCabecalho.New;
  Result:=FVendaCabecalho;
end;

function TControllerEntidades.Cliente: iDAOEntidade<TCliente>;
begin
  if not Assigned(FCliente) then
    FCliente:= TDAOCliente.New;
  Result:=FCliente;
end;

function TControllerEntidades.VendaDetalhe: iDAOEntidade<TVendaDetalhe>;
begin
  if not Assigned(FVendaDetalhe) then
    FVendaDetalhe:= TDAOVendaDetalhe.New;
  Result:=FVendaDetalhe;
end;



function TControllerEntidades.TecnicoAgricola: iDAOEntidade<TTecnicoAgricola>;
begin
  if not Assigned(FVendaDetalhe) then
    FTecnicoAgricola:= TDAOTecnicoAgricola.New;
  Result:=FTecnicoAgricola;
end;




end.
