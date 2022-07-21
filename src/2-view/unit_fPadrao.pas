unit unit_fPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList,Biblioteca;

type
  TfPadrao = class(TForm)
    pnl_cabecalho: TPanel;
    img: TImage;
    lb_titulo: TLabel;
    ds_pesquisaPadrao: TDataSource;
    fdmt_pesquisaPadrao: TFDMemTable;
    pgc_principal: TPageControl;
    ts_lista: TTabSheet;
    DBG_pesquisaPadrao: TDBGrid;
    pnl_pesquisa: TPanel;
    Label2: TLabel;
    pnl_rodape_pesq: TPanel;
    btn_inserir: TBitBtn;
    btn_editar: TBitBtn;
    btn_excluir: TBitBtn;
    btn_fechar: TBitBtn;
    ts_informacoes: TTabSheet;
    pnl_rodape_info: TPanel;
    btn_gravar: TBitBtn;
    btn_cancelar: TBitBtn;
    pnl_corpo_info: TPanel;
    eTexto: TButtonedEdit;
    ImageList: TImageList;
    cb_filtro: TComboBox;
    Label1: TLabel;
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_fecharClick(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);
    procedure btn_editarClick(Sender: TObject);
    procedure btn_inserirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure eTextoKeyPress(Sender: TObject; var Key: Char);
    procedure eTextoRightButtonClick(Sender: TObject);
    procedure btn_gravarClick(Sender: TObject);
    procedure eTextoLeftButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure Sair;

  public
    { Public declarations }
    // Controles Crud
    function editar():Boolean; virtual;
    function excluir():Boolean; virtual;
    function gravar():Boolean; virtual;
    function inserir:Boolean;virtual;

    // controles de tela
    procedure habilitaPageControl(bSituacao:Boolean);
    procedure gridCarrega; virtual;
    procedure gridComboboxFiltro; virtual;
  end;

var
  fPadrao: TfPadrao;
  sAcao:String;

implementation

{$R *.dfm}

{ TfPadrao }

procedure TfPadrao.btn_cancelarClick(Sender: TObject);
begin
  habilitaPageControl(false);
end;

procedure TfPadrao.btn_editarClick(Sender: TObject);
begin
  sAcao := 'Editar';
  if Editar then
    habilitaPageControl(true);
end;

procedure TfPadrao.btn_excluirClick(Sender: TObject);
begin
  if not(Confirma('Deseja exluir este item?')) then exit;
  Excluir;
end;

procedure TfPadrao.btn_fecharClick(Sender: TObject);
begin
  Sair;
end;

procedure TfPadrao.btn_gravarClick(Sender: TObject);
begin
  if gravar then
  begin
    habilitaPageControl(false);
    gridCarrega;
  end;
end;

procedure TfPadrao.btn_inserirClick(Sender: TObject);
begin
  sAcao := 'Inserir';
  habilitaPageControl(true);
  Inserir;
end;

function TfPadrao.editar:Boolean;
begin
  
end;

procedure TfPadrao.eTextoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    etextoRightButtonClick(Sender);
end;

procedure TfPadrao.eTextoLeftButtonClick(Sender: TObject);
begin
  eTexto.Clear;
end;

procedure TfPadrao.eTextoRightButtonClick(Sender: TObject);
begin
  gridCarrega;
end;

function TfPadrao.excluir():Boolean;
begin

end;

procedure TfPadrao.FormCreate(Sender: TObject);
begin
  habilitaPageControl(false);
  gridComboboxFiltro;
end;

function TfPadrao.gravar:Boolean;
begin

end;

procedure TfPadrao.gridCarrega;
begin

end;

procedure TfPadrao.gridComboboxFiltro;
begin

end;

procedure TfPadrao.habilitaPageControl(bSituacao: Boolean);
begin
  pgc_principal.ActivePageIndex := 0;
  pgc_principal.Pages[0].TabVisible := not (bSituacao);
  pgc_principal.Pages[1].TabVisible := bSituacao;

end;

function TfPadrao.inserir:Boolean;
begin

end;

procedure TfPadrao.Sair;
begin
  close;
end;

end.
