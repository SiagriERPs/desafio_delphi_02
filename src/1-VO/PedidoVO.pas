unit PedidoVO;

interface

uses
  ClienteVO, TecnicoVO;

type
  TPedidoVO = class(TObject)
  private
    FID: Integer;
    FID_CLIENTE: Integer;
    FID_TECNICO: Integer;
    FDATA_ABERTURA: TDate;
    FTOTAL: Currency;
    FSTATUS: Integer;
    FClienteVO: TClienteVO;
    FTecnicoVO: TTecnicoVO;

  public
    property ID:            Integer    read FID            write FID;
    property ID_CLIENTE:    Integer    read FID_CLIENTE    write FID_CLIENTE;
    property ID_TECNICO:    Integer    read FID_TECNICO    write FID_TECNICO;
    property DATA_ABERTURA: Tdate      read FDATA_ABERTURA write FDATA_ABERTURA;
    property TOTAL:         Currency   read FTOTAL         write FTOTAL;
    property STATUS:        Integer    read FSTATUS        write FSTATUS;
    property ClienteVO:     TClienteVO read FClienteVO     write FClienteVO;
    property TecnicoVO:     TTecnicoVO read FTecnicoVO     write FTecnicoVO;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TPedidoVO }

constructor TPedidoVO.Create;
begin
  inherited Create;
  Self.ClienteVO   := TClienteVO.Create;
  Self.TecnicoVO   := TTecnicoVO.Create;
end;

destructor TPedidoVO.Destroy;
begin
  Self.ClienteVO.Destroy;
  Self.TecnicoVO.Destroy;
  inherited Destroy;
end;

end.
