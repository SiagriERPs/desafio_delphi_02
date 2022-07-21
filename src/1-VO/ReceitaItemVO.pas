unit ReceitaItemVO;

interface

uses
  System.Classes,PedidoVO, System.Generics.Collections;

type
  TReceitaItemVO = class(TObject)
  private
    FID: Integer;
    FID_PRODUTO: Integer;
    FID_RECEITA: Integer;
  public
    property ID:          Integer    read FID          write FID;
    property ID_PRODUTO:  Integer    read FID_PRODUTO  write FID_PRODUTO;
    property ID_RECEITA:  Integer    read FID_RECEITA  write FID_RECEITA;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TPedidoVO }

constructor TReceitaItemVO.Create;
begin
  inherited Create;
end;

destructor TReceitaItemVO.Destroy;
begin
  inherited Destroy;
end;

end.
