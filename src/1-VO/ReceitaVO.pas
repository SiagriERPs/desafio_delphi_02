unit ReceitaVO;

interface

uses
  System.Classes,ReceitaItemVO, System.Generics.Collections;



type
  TReceitaVO = class(TObject)
  private
    FID: Integer;
    FID_PEDIDO: Integer;
    FID_TECNICO: Integer;
    FDATA_ASSINATURA: TDate;
    FASSINADO: Integer;
    FItemVO:  TObjectList<TReceitaItemVO>;
  public
    property ID:              Integer    read FID               write FID;
    property ID_PEDIDO:       Integer    read FID_PEDIDO        write FID_PEDIDO;
    property ID_TECNICO:      Integer    read FID_TECNICO       write FID_TECNICO;
    property DATA_ASSINATURA: TDate      read FDATA_ASSINATURA  write FDATA_ASSINATURA;
    property ASSINADO:        Integer    read FASSINADO         write FASSINADO;
    property ItemVO:          TObjectList<TReceitaItemVO>  read FItemVO     write FItemVO;


    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TPedidoVO }

constructor TReceitaVO.Create;
begin
  inherited Create;

  Self.ItemVO   := TObjectList<TReceitaItemVO>.Create;

end;

destructor TReceitaVO.Destroy;
begin
  Self.ItemVO.Destroy;
  inherited Destroy;
end;

end.
