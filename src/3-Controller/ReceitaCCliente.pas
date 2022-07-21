unit ReceitaCCliente;

interface

uses ClienteVO,ClienteCServidor,System.Classes,FireDAC.Comp.Client,
  System.SysUtils, ReceitaVO, ReceitaCServidor;


type
  TReceitaCCliente = class

  private

  public
    //funções de crud
    class function Inserir(objReceita: TReceitaVO): boolean;

    class function ConsultaGridPesquisa(fdmt_Pesquisa: TFDMemTable): TFDMemTable;
    class function baixaReceita(iId_Receita,iIdPedido: Integer):Boolean;

  end;

implementation

{ TControllerCliente }

class function TReceitaCCliente.baixaReceita(iId_Receita,iIdPedido: Integer): Boolean;
begin
  try
    Result := TReceitaCServidor.baixaReceita(iId_Receita,iIdPedido);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

class function TReceitaCCliente.ConsultaGridPesquisa(
  fdmt_Pesquisa: TFDMemTable): TFDMemTable;
begin
  try
    Result := TReceitaCServidor.ConsultaGridPesquisa(fdmt_Pesquisa);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

class function TReceitaCCliente.Inserir(objReceita: TReceitaVO): boolean;
begin
  try
    Result := TReceitaCServidor.Inserir(objReceita);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.
