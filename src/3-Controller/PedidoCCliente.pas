unit PedidoCCliente;

interface

uses PedidoVO,System.Classes,FireDAC.Comp.Client,
  System.SysUtils, PedidoCServidor;


type
  TPedidoCCliente = class

  private

  public
    //funções de crud
    class function Editar(objPedido: TPedidoVO): boolean;
    class function Excluir(iId: Integer): boolean;
    class function Inserir(objPedido: TPedidoVO): boolean;

    //funcões de consultas
    class function ConsultaObjId(iId : Integer; objPedido: TPedidoVO):TPedidoVO;
    class function ConsultaGridPesquisa(sValorPesquisa: String;
      fdmt_Pesquisa: TFDMemTable): TFDMemTable;

    class function AlteraStatusPedido(iId,iStatus:integer):boolean;

  end;

implementation

{ TControllerCliente }


class function TPedidoCCliente.AlteraStatusPedido(iId,
  iStatus: integer): boolean;
begin
  try
    Result := TPedidoCServidor.AlteraStatusPedido(iId,iStatus);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;
class function TPedidoCCliente.ConsultaGridPesquisa(sValorPesquisa: String;
 fdmt_Pesquisa: TFDMemTable): TFDMemTable;
begin
  try
    Result := TPedidoCServidor.ConsultaGridPesquisa(sValorPesquisa,fdmt_Pesquisa);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

class function TPedidoCCliente.ConsultaObjId(iId : Integer;
objPedido: TPedidoVO):TPedidoVO;
begin
  try
    Result := TPedidoCServidor.ConsultaObjId(iId,objPedido);
  except
    on E: Exception do
      raise Exception.Create(e.Message);
  end;
end;

class function TPedidoCCliente.Editar(objPedido: TPedidoVO): boolean;
begin
  try
    Result := TPedidoCServidor.Editar(objPedido);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end
end;

class function TPedidoCCliente.Excluir(iId: Integer): boolean;
begin
  try
    Result := TPedidoCServidor.Excluir(iId);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end
end;

class function TPedidoCCliente.Inserir(objPedido: TPedidoVO): boolean;
begin
  try
    Result := TPedidoCServidor.Inserir(objPedido);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.
