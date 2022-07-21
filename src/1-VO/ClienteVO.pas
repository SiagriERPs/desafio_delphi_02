unit ClienteVO;

interface

type
  TClienteVO = class(TObject)
  private
    FID: Integer;
    FNOME: string;
    FCPF: string;

  public
    property ID:   Integer  read FID   write FID;
    property NOME: string   read FNOME write FNOME;
    property CPF:  string   read FCPF  write FCPF;
  end;

implementation

end.
