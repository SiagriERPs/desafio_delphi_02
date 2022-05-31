unit UDatamoduleGeral;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList,
  Tipos, Vcl.Controls,Vcl.Graphics;

type
  TDataModuleGeral = class(TDataModule)
    ImagensCadastros: TImageList;
    ImagensCadastrosD: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
    function Imagem(pTipo: TImagem; pStatus: TStatusImagem; pTamanho: TTamanhoImagem; var pBitmap: TBitmap): TBitmap;
  end;

var
  DataModuleGeral: TDataModuleGeral;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModuleGeral }

function TDataModuleGeral.Imagem(pTipo: TImagem; pStatus: TStatusImagem;
  pTamanho: TTamanhoImagem; var pBitmap: TBitmap): TBitmap;
var
  ImageList: TImageList;
begin
  Result := pBitmap;
  // Captura Instância do ImageList a ser utilizado
  if pStatus = siDesabilitada then
  ImageList := ImagensCadastrosD
  else
  ImageList := ImagensCadastros;

  case pTamanho of
    ti16:
    case pTipo of
      iIncluir:ImageList.GetBitmap(0, Result);
      iAlterar:ImageList.GetBitmap(1, Result);
      iExcluir:ImageList.GetBitmap(2, Result);
      iConsultar:ImageList.GetBitmap(3, Result);
      iImprimir:ImageList.GetBitmap(4, Result);
      iSalvar:ImageList.GetBitmap(9, Result);
      iCancelar:ImageList.GetBitmap(10, Result);
      iLocalizar:ImageList.GetBitmap(11, Result);
      iSair:ImageList.GetBitmap(12, Result);
      iExportar:ImageList.GetBitmap(13, Result);
      iExcel:ImageList.GetBitmap(14, Result);
      iHTML:ImageList.GetBitmap(15, Result);
      iCSV:ImageList.GetBitmap(16, Result);
      iWord:ImageList.GetBitmap(17, Result);
      iXML:ImageList.GetBitmap(18, Result);
      iAnterior:ImageList.GetBitmap(19, Result);
      iPrimeiro:ImageList.GetBitmap(20, Result);
      iUltimo:ImageList.GetBitmap(21, Result);
      iProximo:ImageList.GetBitmap(22, Result);
      iProximaPagina:ImageList.GetBitmap(23, Result);
      iPaginaAnterior:ImageList.GetBitmap(24, Result);
      iAbrir:ImageList.GetBitmap(25, Result);
      iDigitalizar:ImageList.GetBitmap(26, Result);
      iVisualizar:ImageList.GetBitmap(27, Result);
      iFiltroPersonalizado:ImageList.GetBitmap(11, Result);
    end;
  end;
end;

end.
