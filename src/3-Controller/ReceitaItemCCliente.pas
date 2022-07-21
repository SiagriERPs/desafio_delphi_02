unit ReceitaItemCCliente;


interface

uses ClienteVO,ClienteCServidor,System.Classes,FireDAC.Comp.Client,
  System.SysUtils, ReceitaVO, ReceitaCServidor, ReceitaItemCServidor,
  ReceitaItemVO;


type
  TReceitaItemCCliente = class

  private

  public
    //funções de crud
    class function Inserir(iId: Integer;objReceitaItem: TReceitaItemVO): boolean;

    class function ConsultaGridPesquisa(iId:Integer;fdmt_Pesquisa: TFDMemTable): TFDMemTable;


  end;

implementation

{ TControllerCliente }

class function TReceitaItemCCliente.ConsultaGridPesquisa(iId: Integer;
  fdmt_Pesquisa: TFDMemTable): TFDMemTable;
begin
  try
    Result := TReceitaItemCServidor.ConsultaGridPesquisa(iId,fdmt_Pesquisa);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

class function TReceitaItemCCliente.Inserir(iId: Integer;objReceitaItem: TReceitaItemVO): boolean;
begin
  try
    Result := TReceitaItemCServidor.Inserir(iId,objReceitaItem);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.
