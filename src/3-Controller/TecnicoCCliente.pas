unit TecnicoCCliente;

interface

uses PedidoVO,System.Classes,FireDAC.Comp.Client,
  System.SysUtils, PedidoCServidor, TecnicoCServidor, TecnicoVO;


type
  TTecnicoCCliente = class

  private

  public
    //funcões de consultas
    class function ConsultaGridPesquisa(iItem:Integer;sValorPesquisa: String;
      fdmt_Pesquisa: TFDMemTable): TFDMemTable;

    class function CarregaComboBoxPadrao(Lista : TStringList):TStringList;

    class function ConsultaObjId(iId : Integer; objTecnico: TTecnicoVO):TTecnicoVO;

  end;

implementation

{ TControllerCliente }

{ TTecnicoCCliente }

class function TTecnicoCCliente.CarregaComboBoxPadrao(
  Lista: TStringList): TStringList;
begin
  try
    Result := TTecnicoCServidor.CarregaComboBoxPadrao(Lista);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

class function TTecnicoCCliente.ConsultaGridPesquisa(iItem: Integer;
  sValorPesquisa: String; fdmt_Pesquisa: TFDMemTable): TFDMemTable;
begin
  try
    Result := TTecnicoCServidor.ConsultaGridPesquisa(iItem,sValorPesquisa,fdmt_Pesquisa);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

class function TTecnicoCCliente.ConsultaObjId(iId: Integer;
  objTecnico: TTecnicoVO): TTecnicoVO;
begin
  try
    Result := TTecnicoCServidor.ConsultaObjId(iId,objTecnico);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.
