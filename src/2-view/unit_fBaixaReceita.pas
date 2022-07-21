unit unit_fBaixaReceita;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, System.ImageList, Vcl.ImgList, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, ReceitaCCliente,
  ReceitaItemCCliente,biblioteca, Vcl.Imaging.pngimage;

type
  TFReceitaBaixa = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    img: TImage;
    lb_titulo: TLabel;
    DBG_pesquisaPadrao: TDBGrid;
    dbg_grid_item: TDBGrid;
    ImageList: TImageList;
    btn_fechar: TBitBtn;
    btn_gravar: TBitBtn;
    ds_pesquisaPadrao: TDataSource;
    fdmt_pesquisaPadrao: TFDMemTable;
    dbg_grid: TDBGrid;
    ds_pesquisaItem: TDataSource;
    fdmt_pesquisaItem: TFDMemTable;
    procedure FormShow(Sender: TObject);
    procedure btn_gravarClick(Sender: TObject);
    procedure ds_pesquisaPadraoDataChange(Sender: TObject; Field: TField);
    procedure btn_fecharClick(Sender: TObject);
  private
    { Private declarations }
    procedure fechar();
    function baixarReceita():boolean;

    procedure gridCarrega;
    procedure gridCarregaItem;
  public
    { Public declarations }
  end;

var
  FReceitaBaixa: TFReceitaBaixa;

implementation

{$R *.dfm}

{ TFReceitaBaixa }

procedure TFReceitaBaixa.btn_fecharClick(Sender: TObject);
begin
  close;
end;

procedure TFReceitaBaixa.btn_gravarClick(Sender: TObject);
begin
  baixarReceita;
end;

procedure TFReceitaBaixa.ds_pesquisaPadraoDataChange(Sender: TObject;
  Field: TField);
begin
  gridCarregaItem;
end;

function TFReceitaBaixa.baixarReceita: boolean;
begin
  try
    if  fdmt_pesquisaPadrao.Active = true then
    begin
      if fdmt_pesquisaPadrao.RecordCount > 0 then
      begin
        if(fdmt_pesquisaPadrao.FieldByName('assinado').AsString = 'Não') then
        begin
          if(TReceitaCCliente.baixaReceita(
          fdmt_pesquisaPadrao.FieldByName('Id').AsInteger,
          fdmt_pesquisaPadrao.FieldByName('Pedido').AsInteger)) then
            MsgCrud('Editar');
          gridCarrega;
        end;
      end;
    end;
  finally

  end;
end;

procedure TFReceitaBaixa.fechar;
begin
  close;
end;

procedure TFReceitaBaixa.FormShow(Sender: TObject);
begin
  gridCarrega;
end;

procedure TFReceitaBaixa.gridCarrega;
begin
  fdmt_pesquisaPadrao.close;
  fdmt_pesquisaPadrao := TReceitaCCliente.ConsultaGridPesquisa(fdmt_pesquisaPadrao);
end;

procedure TFReceitaBaixa.gridCarregaItem;
begin
  fdmt_pesquisaItem.close;
  fdmt_pesquisaItem := TReceitaItemCCliente.ConsultaGridPesquisa
    (fdmt_pesquisaPadrao.FieldByName('id').AsInteger, fdmt_pesquisaItem);
end;



end.
