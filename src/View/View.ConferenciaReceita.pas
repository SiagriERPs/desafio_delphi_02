unit View.ConferenciaReceita;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UViewPadrao, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Controller.Interfaces,Controller.Controller, Vcl.WinXCtrls, Vcl.StdCtrls,
  Controller.VendaCabecalho,View.TecnicoAgricola.Pesquisa;

type
  TFormConferenciaReceita = class(TFPadrao)
    GroupBoxCabecalho: TGroupBox;
    LabelId: TLabel;
    LabelNome: TLabel;
    LabelCFP: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    EditId: TEdit;
    DateTimePickerDataVenda: TDateTimePicker;
    EditValor: TEdit;
    EditStatusVenda: TEdit;
    EditIdCliente: TEdit;
    EditClienteNome: TSearchBox;
    GroupBoxVendaDetalhe: TGroupBox;
    DBGridVendaDetalhe: TDBGrid;
    DsGridDetalhe: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure BotaoCancelarClick(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
  private
    { Private declarations }
    FController : iController;
    procedure ListarRegistrosDetalhe;
    procedure AjustaLayoutGridDetalhe;
    procedure AssinarReceita;
  public
    IdTecnicoAgricolaSelecionado:Integer;
    procedure ListarRegistros;override;
    procedure GridParaEdits;override;
    procedure VinculaCamposBD;override;
    //Crud
    function Inserir:boolean;override;
    function Editar:boolean;override;
    function Excluir:boolean;override;
    function Cancelar:boolean;override;
    function Salvar:boolean;override;

    procedure AjustaLayoutGrid;override;
  end;

var
  FormConferenciaReceita: TFormConferenciaReceita;

implementation

{$R *.dfm}

{ TFPadrao1 }

procedure TFormConferenciaReceita.AjustaLayoutGrid;
begin
  inherited;
  DsGrid.DataSet.FieldByName('DATA_VENDA').DisplayLabel:='Data';
  DsGrid.DataSet.FieldByName('ID_CLIENTE').Visible:=false;
  DsGrid.DataSet.FieldByName('NOME').DisplayWidth:=60;
  DsGrid.DataSet.FieldByName('NOME').DisplayLabel:='Cliente';
  //DsGrid.DataSet.FieldByName('VALOR'):='0.00';
  DsGrid.DataSet.FieldByName('VALOR').DisplayLabel:='Valor';
end;

procedure TFormConferenciaReceita.AjustaLayoutGridDetalhe;
begin
  inherited;
  DsGridDetalhe.DataSet.FieldByName('ID').Visible:=false;
  DsGridDetalhe.DataSet.FieldByName('ID_PRODUTO').Visible:=false;
  DsGridDetalhe.DataSet.FieldByName('ID_TECNICO_AGRICOLA').Visible:=false;
  DsGridDetalhe.DataSet.FieldByName('CONTROLE_ESPECIAL').Visible:=false;
  DsGridDetalhe.DataSet.FieldByName('ID_VENDA_CABECALHO').Visible:=false;
  DsGridDetalhe.DataSet.FieldByName('TECNICO_AGRICOLANOME').Visible:=false;
  DsGridDetalhe.DataSet.FieldByName('PRODUTONOME').DisplayLabel:='Produto';
  DsGridDetalhe.DataSet.FieldByName('QUANTIDADE').DisplayLabel:='Quantidade';
  DsGridDetalhe.DataSet.FieldByName('VALOR_UNITARIO').DisplayLabel:='Valor Unitário';
  DsGridDetalhe.DataSet.FieldByName('VALOR_TOTAL').DisplayLabel:='Valor Total';
  DsGridDetalhe.DataSet.FieldByName('CONTROLE_ESPECIAL').DisplayLabel:='Pendente de Assinatura';
  DsGridDetalhe.DataSet.FieldByName('PRODUTONOME').DisplayWidth:=30;
  DsGridDetalhe.DataSet.FieldByName('QUANTIDADE').DisplayWidth:=15;
  DsGridDetalhe.DataSet.FieldByName('VALOR_UNITARIO').DisplayWidth:=15;
  DsGridDetalhe.DataSet.FieldByName('VALOR_TOTAL').DisplayWidth:=15;

end;

procedure TFormConferenciaReceita.AssinarReceita;
var ControllerVendaCabecalho:TControllerVendaCabecalho;
begin

  try
    ControllerVendaCabecalho:=TControllerVendaCabecalho.Create;
    PesquisaPadrao(TFormTecnicoAgricolaPesquisa,FormTecnicoAgricolaPesquisa);
    if (EditId.Text <> '') and  (IdTecnicoAgricolaSelecionado>0)then
    begin
      ControllerVendaCabecalho.AssinarReceita(StrToint(EditId.Text),IdTecnicoAgricolaSelecionado);
      ListarRegistros;
    end
    else
    Showmessage('Parametros incorretos!');
  finally
    Freeandnil(ControllerVendaCabecalho);
  end;
end;

procedure TFormConferenciaReceita.BotaoCancelarClick(Sender: TObject);
begin
  inherited;
  BotaoInserir.Visible:=false;
  BotaoSalvar.Visible:=False;
  BotaoExcluir.Visible:=false;
end;

function TFormConferenciaReceita.Cancelar: boolean;
begin
  inherited;
end;

function TFormConferenciaReceita.Editar: boolean;
begin
  inherited;
end;

function TFormConferenciaReceita.Excluir: boolean;
begin
  inherited;
end;

procedure TFormConferenciaReceita.FormCreate(Sender: TObject);
begin
  FController:=TController.New;
  inherited;
end;

procedure TFormConferenciaReceita.GridDblClick(Sender: TObject);
begin
  inherited;
  BotaoInserir.Visible:=false;
  BotaoSalvar.Visible:=False;
  BotaoExcluir.Visible:=false;
end;

procedure TFormConferenciaReceita.GridParaEdits;
begin
  inherited;
  EditId.Text:=DsGrid.DataSet.FieldByName('ID').AsString;
  EditIdCliente.Text:=DsGrid.DataSet.FieldByName('ID_CLIENTE').AsString;
  EditClienteNome.Text:=DsGrid.DataSet.FieldByName('NOME').AsString;
  EditValor.Text:=DsGrid.DataSet.FieldByName('VALOR').AsString;
  DateTimePickerDataVenda.Date:= DsGrid.DataSet.FieldByName('DATA_VENDA').AsDateTime;
  EditStatusVenda.Text:='Pendente de Assinatura';
  ListarRegistrosDetalhe;
end;

function TFormConferenciaReceita.Inserir: boolean;
begin
  inherited;
end;

procedure TFormConferenciaReceita.ListarRegistrosDetalhe;
begin
   FController
    .Entidades
    .VendaDetalhe
    .ConsultaLista('v.ID_VENDA_CABECALHO = '+EditId.Text+' AND v.CONTROLE_ESPECIAL = '+QuotedStr('S'))
    .DataSet(DsGridDetalhe);
    AjustaLayoutGridDetalhe;
end;

procedure TFormConferenciaReceita.ListarRegistros;
begin
  inherited;
  FController
  .Entidades
  .VendaCabecalho
  .ConsultaLista('v.STATUS_VENDA = '+QuotedStr('P'))
  .DataSet(DsGrid);
end;

function TFormConferenciaReceita.Salvar: boolean;
begin
  try
    inherited;
    AssinarReceita;
  Showmessage('Receita assinada com sucesso!');
  except
    Showmessage('Erro ao assinar receita!');
   end;
end;

procedure TFormConferenciaReceita.VinculaCamposBD;
begin
  inherited;
end;

end.
