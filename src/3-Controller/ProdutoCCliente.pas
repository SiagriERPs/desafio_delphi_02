unit ProdutoCCliente;

interface

uses ProdutoVO,ClienteCServidor,System.Classes,FireDAC.Comp.Client,
  System.SysUtils, ProdutoCServidor;


type
  TProdutoCCliente = class

  private

  public
    //funções de crud
    class function Editar(objProduto: TProdutoVO): boolean;
    class function Excluir(iId: Integer): boolean;
    class function Inserir(objProduto: TProdutoVO): boolean;

    //funcões de consultas
    class function ConsultaObjId(iId : Integer; objProduto: TProdutoVO):TProdutoVO;
    class function ConsultaGridPesquisa(iItem:Integer;sValorPesquisa: String;
      fdmt_Pesquisa: TFDMemTable): TFDMemTable;

    class function CarregaComboBoxPadrao(Lista : TStringList):TStringList;

  end;

implementation

{ TControllerCliente }


class function TProdutoCCliente.CarregaComboBoxPadrao(
  Lista: TStringList): TStringList;
begin
  try
    Result := TProdutoCServidor.CarregaComboBoxPadrao(Lista);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

class function TProdutoCCliente.ConsultaGridPesquisa(iItem:Integer;sValorPesquisa: String;
 fdmt_Pesquisa: TFDMemTable): TFDMemTable;
begin
  try
    Result := TProdutoCServidor.ConsultaGridPesquisa(iItem,sValorPesquisa,fdmt_Pesquisa);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

class function TProdutoCCliente.ConsultaObjId(iId : Integer;
objProduto: TProdutoVO):TProdutoVO;
begin
  try
    Result := TProdutoCServidor.ConsultaObjId(iId,objProduto);
  except
    on E: Exception do
      raise Exception.Create(e.Message);
  end;
end;

class function TProdutoCCliente.Editar(objProduto: TProdutoVO): boolean;
begin
  try
    Result := TProdutoCServidor.Editar(objProduto);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end
end;

class function TProdutoCCliente.Excluir(iId: Integer): boolean;
begin
  try
    Result := TProdutoCServidor.Excluir(iId);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end
end;

class function TProdutoCCliente.Inserir(objProduto: TProdutoVO): boolean;
begin
  try
    Result := TProdutoCServidor.Inserir(objProduto);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.
