unit ClienteCCliente;

interface

uses ClienteVO,ClienteCServidor,System.Classes,FireDAC.Comp.Client,
  System.SysUtils;


type
  TClienteCCliente = class

  private

  public
    //funções de crud
    class function Editar(objCliente: TClienteVO): boolean;
    class function Excluir(iId: Integer): boolean;
    class function Inserir(objCliente: TClienteVO): boolean;

    //funcões de consultas
    class function ConsultaObjId(iId : Integer; objCliente: TClienteVO):TClienteVO;
    class function ConsultaGridPesquisa(iItem:Integer;sValorPesquisa: String;
      fdmt_Pesquisa: TFDMemTable): TFDMemTable;

    class function CarregaComboBoxPadrao(Lista : TStringList):TStringList;

  end;

implementation

{ TControllerCliente }


class function TClienteCCliente.CarregaComboBoxPadrao(
  Lista: TStringList): TStringList;
begin
  try
    Result := TClienteCServidor.CarregaComboBoxPadrao(Lista);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;


class function TClienteCCliente.ConsultaGridPesquisa(iItem:Integer;sValorPesquisa: String;
 fdmt_Pesquisa: TFDMemTable): TFDMemTable;
begin
  try
    Result := TClienteCServidor.ConsultaGridPesquisa(iItem,sValorPesquisa,fdmt_Pesquisa);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

class function TClienteCCliente.ConsultaObjId(iId: Integer;
  objCliente: TClienteVO): TClienteVO;
begin
  try
    Result := TClienteCServidor.ConsultaObjId(iId,objCliente);
  except
    on E: Exception do
      raise Exception.Create(e.Message);
  end;
end;

class function TClienteCCliente.Editar(objCliente: TClienteVO): boolean;
begin
  try
    Result := TClienteCServidor.Editar(objCliente);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end
end;

class function TClienteCCliente.Excluir(iId: Integer): boolean;
begin
  try
    Result := TClienteCServidor.Excluir(iId);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end
end;

class function TClienteCCliente.Inserir(objCliente: TClienteVO): boolean;
begin
  try
    Result := TClienteCServidor.Inserir(objCliente);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.
