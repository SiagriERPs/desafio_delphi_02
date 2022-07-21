unit PedidoItemVO;

interface

uses
  PedidoVO, ProdutoVO;

type
  TPedidoItemVO = class(TObject)
  private
    FID: Integer;
    FID_PEDIDO: Integer;
    FID_PRODUTO: Integer;
    FVALOR: Currency;
    FQUANTIDADE: Currency;
    FTOTAL: Currency;
    FCONTROLE_ESP: Integer;
    FPedidoVO: TPedidoVO;
    FProdutoVO: TProdutoVO;

  public
    property ID:            Integer    read FID           write FID;
    property ID_PEDIDO:     Integer    read FID_PEDIDO    write FID_PEDIDO;
    property ID_PRODUTO:    Integer    read FID_PRODUTO   write FID_PRODUTO;
    property VALOR:         Currency   read FVALOR        write FVALOR;
    property QUANTIDADE:    Currency   read FQUANTIDADE   write FQUANTIDADE;
    property TOTAL:         Currency   read FTOTAL        write FTOTAL;
    property CONTROLE_ESP:  Integer    read FCONTROLE_ESP write FCONTROLE_ESP;
    property PedidoVO:      TPedidoVO  read FPedidoVO     write FPedidoVO;
    property ProdutoVO:     TProdutoVO read FProdutoVO    write FProdutoVO;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TPedidoVO }

constructor TPedidoItemVO.Create;
begin
  inherited Create;
  Self.PedidoVO   := TPedidoVO.Create;
  Self.ProdutoVO  := TProdutoVO.Create;
end;

destructor TPedidoItemVO.Destroy;
begin
  Self.PedidoVO.Destroy;
  Self.ProdutoVO.Destroy;
  inherited Destroy;
end;

end.
