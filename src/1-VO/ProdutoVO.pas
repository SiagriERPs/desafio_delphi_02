unit ProdutoVO;

interface

uses
  ClienteVO;

type
  TProdutoVO = class(TObject)
  private
    FID: Integer;
    FNOME: string;
    FVALOR: Currency;
    FCONTROLE_ESP: Integer;

  public
    property ID:           Integer    read FID           write FID;
    property NOME:         string     read FNOME         write FNOME;
    property VALOR:        Currency   read FVALOR        write FVALOR;
    property CONTROLE_ESP: Integer    read FCONTROLE_ESP write FCONTROLE_ESP;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TProdutoVO }

constructor TProdutoVO.Create;
begin
  inherited Create;
end;

destructor TProdutoVO.Destroy;
begin
  inherited Destroy;
end;

end.
