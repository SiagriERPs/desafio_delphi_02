unit PesquisaCCliente;

interface

uses ClienteVO,ClienteCServidor,System.Classes,FireDAC.Comp.Client,
  System.SysUtils, ProdutoCServidor, TecnicoCServidor;

type
  TPesquisaCCliente = class

  private

  public
    //funcões de consultas
    class function ConsultaGridPesquisa(sTabela:string;iItem:Integer;sValorPesquisa: String;
      fdmt_Pesquisa: TFDMemTable): TFDMemTable;
    class function CarregaComboBoxPadrao(sTabela:string;Lista : TStringList):TStringList;

  end;

implementation

{ TControllerCliente }


class function TPesquisaCCliente.CarregaComboBoxPadrao(sTabela:string;
  Lista: TStringList): TStringList;
begin
begin
  try
    if sTabela = 'Cliente' then
      Result := TClienteCServidor.CarregaComboBoxPadrao(Lista);
    if sTabela = 'Produto' then
      Result := TProdutoCServidor.CarregaComboBoxPadrao(Lista);
    if sTabela = 'Tecnico' then
      Result := TTecnicoCServidor.CarregaComboBoxPadrao(Lista);


  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;
end;

class function TPesquisaCCliente.ConsultaGridPesquisa(sTabela:string;iItem:Integer;sValorPesquisa: String;
 fdmt_Pesquisa: TFDMemTable): TFDMemTable;
begin
  try
    if sTabela = 'Cliente' then
      Result := TClienteCServidor.ConsultaGridPesquisa(iItem,sValorPesquisa,fdmt_Pesquisa);
    if sTabela = 'Produto' then
      Result := TProdutoCServidor.ConsultaGridPesquisa(iItem,sValorPesquisa,fdmt_Pesquisa);
    if sTabela = 'Tecnico' then
      Result := TTecnicoCServidor.ConsultaGridPesquisa(iItem,sValorPesquisa,fdmt_Pesquisa);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.
