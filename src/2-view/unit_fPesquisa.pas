unit unit_fPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, PesquisaCCliente, Vcl.Buttons;

type
  TfPesquisa = class(TForm)
    Panel1: TPanel;
    pnl_botoes: TPanel;
    pnl_corpo: TPanel;
    Label2: TLabel;
    lbl_titulo: TLabel;
    cb_filtro: TComboBox;
    Label3: TLabel;
    ds_pesquisaPadrao: TDataSource;
    fdmt_pesquisaPadrao: TFDMemTable;
    ImageList: TImageList;
    etexto: TButtonedEdit;
    DBG_pesquisaPadrao: TDBGrid;
    btn_ok: TBitBtn;
    btn_Fechar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btn_okClick(Sender: TObject);
    procedure etextoRightButtonClick(Sender: TObject);
    procedure btn_FecharClick(Sender: TObject);
  private
    { Private declarations }
   procedure GridCarrega;
   procedure gridComboboxFiltro;

  public
    { Public declarations }
  end;

var
  fPesquisa: TfPesquisa;
  sTabela: string;

implementation

{$R *.dfm}

procedure TfPesquisa.btn_FecharClick(Sender: TObject);
begin
  close;
end;

procedure TfPesquisa.btn_okClick(Sender: TObject);
begin
  if Assigned(fdmt_pesquisaPadrao) then
  begin
    if fdmt_pesquisaPadrao.RecordCount > 0 then
      ModalResult := mrOk
    else
      ModalResult := mrCancel;
  end;

end;

procedure TfPesquisa.etextoRightButtonClick(Sender: TObject);
begin
  GridCarrega;
end;

procedure TfPesquisa.FormShow(Sender: TObject);
begin
  lbl_titulo.Caption := 'Pesquisa '+sTabela;
  gridComboboxFiltro;
end;

procedure TfPesquisa.GridCarrega;
begin
  try
    fdmt_pesquisaPadrao.close;
    fdmt_pesquisaPadrao := TPesquisaCCliente.ConsultaGridPesquisa
    (sTabela,cb_filtro.ItemIndex,etexto.Text,fdmt_pesquisaPadrao);

  finally

  end;
end;

procedure TfPesquisa.gridComboboxFiltro;
var sLista : TStringList;
begin
  inherited;
  sLista := TStringList.Create;
  sLista.Clear;
  TPesquisaCCliente.CarregaComboBoxPadrao(sTabela,sLista);
  cb_filtro.Items := slista;
  cb_filtro.ItemIndex := 0;
end;


end.
