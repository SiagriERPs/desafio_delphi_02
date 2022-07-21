unit TecnicoVO;

interface

uses
  System.Classes,System.Generics.Collections;

type
  TTecnicoVO = class(TObject)
  private
    FID: Integer;
    FNOME: string;
    FCPF: string;
    FNUM_REGISTRO: string;

  public
    property ID:            Integer  read FID           write FID;
    property NOME:          string   read FNOME         write FNOME;
    property CPF:           string   read FCPF          write FCPF;
    property NUM_REGISTRO:  string   read FNUM_REGISTRO write FNUM_REGISTRO;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TPedidoVO }

constructor TTecnicoVO.Create;
begin
  inherited Create;
end;

destructor TTecnicoVO.Destroy;
begin
  inherited Destroy;
end;

end.
