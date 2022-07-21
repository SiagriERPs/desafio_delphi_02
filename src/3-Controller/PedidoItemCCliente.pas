unit PedidoItemCCliente;

interface

uses PedidoItemVO,PedidoItemCServidor,System.Classes,FireDAC.Comp.Client,
  System.SysUtils;


type
  TPedidoItemCCliente = class

  private

  public
    //funções de crud
    class function Excluir(iId: Integer): boolean;
    class function Inserir(objPedidoItem: TPedidoItemVO): boolean;
    class function ConsultaGridPesquisa(iId:Integer;
      fdmt_Pesquisa: TFDMemTable): TFDMemTable;


  end;

implementation

{ TControllerCliente }

class function TPedidoItemCCliente.ConsultaGridPesquisa(iId:Integer;
 fdmt_Pesquisa: TFDMemTable): TFDMemTable;
begin
  try
    Result := TPedidoItemCServidor.ConsultaGridPesquisa(iId,fdmt_Pesquisa);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

class function TPedidoItemCCliente.Excluir(iId: Integer): boolean;
begin
  try
    Result := TPedidoItemCServidor.Excluir(iId);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end
end;

class function TPedidoItemCCliente.Inserir(objPedidoItem: TPedidoItemVO): boolean;
begin
  try
    Result := TPedidoItemCServidor.Inserir(objPedidoItem);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.
