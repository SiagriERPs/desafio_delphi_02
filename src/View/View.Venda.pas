unit View.Venda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UViewPadrao, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls,Controller.Controller,Controller.Interfaces,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, Vcl.Mask, Vcl.StdCtrls, Vcl.DBCtrls,System.Math,Biblioteca,
  Vcl.PlatformDefaultStyleActnCtrls, System.Actions, Vcl.ActnList, Vcl.ActnMan,
  Vcl.ToolWin, Vcl.ActnCtrls, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, Datasnap.DBClient,
  Model.Conexao.Interfaces, Vcl.WinXCtrls, UDatamoduleGeral, FireDAC.Comp.UI,
  View.Cliente.Pesquisa, Datasnap.Provider,Controller.VendaCabecalho;

type
  TFormVenda = class(TFPadrao)
    GroupBoxCabecalho: TGroupBox;
    EditId: TEdit;
    LabelId: TLabel;
    LabelNome: TLabel;
    DateTimePickerDataVenda: TDateTimePicker;
    EditValor: TEdit;
    LabelCFP: TLabel;
    Label1: TLabel;
    EditStatusVenda: TEdit;
    GroupBoxVendaDetalhe: TGroupBox;
    DBGridVendaDetalhe: TDBGrid;
    DsGridDetalhe: TDataSource;
    Label2: TLabel;
    ActionToolBar1: TActionToolBar;
    ActionManager1: TActionManager;
    EditIdCliente: TEdit;
    EditClienteNome: TSearchBox;
    Action1: TAction;
    Action2: TAction;
    CdsVendaDetalhe: TClientDataSet;
    CdsVendaDetalheID: TIntegerField;
    CdsVendaDetalheID_PRODUTO: TIntegerField;
    CdsVendaDetalheQUANTIDADE: TFloatField;
    CdsVendaDetalheVALOR_UNITARIO: TFloatField;
    CdsVendaDetalheVALOR_TOTAL: TFloatField;
    CdsVendaDetalheID_VENDA_CABECALHO: TIntegerField;
    CdsVendaDetalheCONTROLE_ESPECIAL: TStringField;
    CdsVendaDetalheID_TECNICO_AGRICOLA: TIntegerField;
    CdsVendaDetalhePRODUTONOME: TStringField;
    CdsVendaDetalheTECNICO_AGRICOLANOME: TStringField;
    DSVendaDetalhe: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure EditValorChange(Sender: TObject);
    procedure DBGridVendaDetalheDblClick(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure EditClienteNomeInvokeSearch(Sender: TObject);
    procedure DBGridVendaDetalheDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure BotaoAlterarClick(Sender: TObject);
  private
    { Private declarations }
    FController : iController;
    FControllerVenda:TControllerVendaCabecalho;
    function SetControleEspecial:String;
    procedure GetControleEspecial(Value:String);
    procedure PreencheDadosCliente;
    procedure ListarRegistrosDetalhe;
    function GetStatusVenda(StatusVenda:String):String;
    procedure AjustaLayoutGridDetalhe;
    procedure SalvarItens(IdVendaCabecalho:Integer);
  public
    { Public declarations }
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
    procedure LimparGridDetalhe;override;
    procedure PopulaGridDetalhe(Cds:TClientDataSet;DataSet:TDataSet);override;

  end;


var
  FormVenda: TFormVenda;

implementation

uses
View.VendaDetalhe;


{$R *.dfm}

procedure TFormVenda.Action1Execute(Sender: TObject);
begin
  AbreFormularioDadosGridPadrao('C',TFormVendaDetalhe,FormVendaDetalhe,CdsVendaDetalhe,true);
  EditValor.Text:=FloattoStr(FControllerVenda.CalcularTotalVenda(CdsVendaDetalhe));
end;


procedure TFormVenda.AjustaLayoutGrid;
begin
  inherited;
  DsGrid.DataSet.FieldByName('DATA_VENDA').DisplayLabel:='Data';
  DsGrid.DataSet.FieldByName('ID_CLIENTE').Visible:=false;
  DsGrid.DataSet.FieldByName('NOME').DisplayWidth:=60;
  DsGrid.DataSet.FieldByName('NOME').DisplayLabel:='Cliente';
  //DsGrid.DataSet.FieldByName('VALOR'):='0.00';
  DsGrid.DataSet.FieldByName('VALOR').DisplayLabel:='Valor';
  DsGrid.DataSet.FieldByName('STATUS_VENDA').DisplayLabel:='Concluido';
end;


procedure TFormVenda.AjustaLayoutGridDetalhe;
begin
  inherited;
  CdsVendaDetalhe.FieldByName('ID_PRODUTO').DisplayLabel:='Cód. Produto';
  CdsVendaDetalhe.FieldByName('PRODUTONOME').DisplayLabel:='Produto/Mercadoria';
  CdsVendaDetalhe.FieldByName('QUANTIDADE').DisplayLabel:='Quantidade';
  CdsVendaDetalhe.FieldByName('VALOR_UNITARIO').DisplayLabel:='Valor Unit.';
  CdsVendaDetalhe.FieldByName('VALOR_TOTAL').DisplayLabel:='Total';
  CdsVendaDetalhe.FieldByName('CONTROLE_ESPECIAL').DisplayLabel:='Exige Receita';
  CdsVendaDetalhe.FieldByName('TECNICO_AGRICOLANOME').DisplayLabel:='Tecnico Agric. Responsavel';
  CdsVendaDetalhe.FieldByName('ID_TECNICO_AGRICOLA').DisplayLabel:='Cód. Tec. Agric.';
  CdsVendaDetalhe.FieldByName('ID_VENDA_CABECALHO').DisplayLabel:='Cód. Venda';


  CdsVendaDetalhe.FieldByName('ID_TECNICO_AGRICOLA').visible:=false;
  CdsVendaDetalhe.FieldByName('ID_VENDA_CABECALHO').visible:=false;

  CdsVendaDetalhe.FieldByName('ID_PRODUTO').DisplayWidth:=10;
  CdsVendaDetalhe.FieldByName('PRODUTONOME').DisplayWidth:=40;
  CdsVendaDetalhe.FieldByName('QUANTIDADE').DisplayWidth:=10;
  CdsVendaDetalhe.FieldByName('VALOR_UNITARIO').DisplayWidth:=10;
  CdsVendaDetalhe.FieldByName('VALOR_TOTAL').DisplayWidth:=10;
  CdsVendaDetalhe.FieldByName('CONTROLE_ESPECIAL').DisplayWidth:=10;
  CdsVendaDetalhe.FieldByName('TECNICO_AGRICOLANOME').DisplayWidth:=40;
  CdsVendaDetalhe.FieldByName('ID_TECNICO_AGRICOLA').DisplayWidth:=10;
  CdsVendaDetalhe.FieldByName('ID_VENDA_CABECALHO').DisplayWidth:=10;

end;

procedure TFormVenda.BotaoAlterarClick(Sender: TObject);
begin
  if FControllerVenda.VerificaPermissaoAlteracaoVenda(DsGrid.DataSet.FieldByName('STATUS_VENDA').AsString) then
  inherited;

end;

function TFormVenda.Cancelar: boolean;
begin
  inherited;
end;


procedure TFormVenda.DBGridVendaDetalheDblClick(Sender: TObject);
begin
  inherited;
  AbreFormularioDadosGridPadrao('U',TFormVendaDetalhe,FormVendaDetalhe,CdsVendaDetalhe,true);
  EditValor.Text:=FloattoStr(FControllerVenda.CalcularTotalVenda(CdsVendaDetalhe));
end;


procedure TFormVenda.DBGridVendaDetalheDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if CdsVendaDetalhe.RecordCount >  0 then
  DesenhaCheckBoxGridPadrao(CdsVendaDetalhe,'CONTROLE_ESPECIAL','S',DBGridVendaDetalhe,Column,Rect);
end;

function TFormVenda.Editar: boolean;
begin
  Result := inherited Editar;
  if Result then
  begin
    EditIdCliente.SetFocus;
  end;
end;


procedure TFormVenda.EditClienteNomeInvokeSearch(Sender: TObject);
begin
  PesquisaPadrao(TFormClientePesquisa,FormClientePesquisa);
end;

procedure TFormVenda.EditValorChange(Sender: TObject);
begin
  if EditValor.Focused then
  Biblioteca.Formatar(EditValor,Valor2);
end;


function TFormVenda.Excluir: boolean;
begin
  if inherited Excluir then
  try
  FController
   .Entidades
   .VendaCabecalho
   .This
   .Id(DsGrid.DataSet.FieldByName('ID').AsInteger)
   .&End
   .Excluir;
  finally
    ListarRegistros;
  end;
end;

procedure TFormVenda.FormCreate(Sender: TObject);
begin
  FController:=TController.New;
  FControllerVenda:= TControllerVendaCabecalho.New;
  inherited;
end;

procedure TFormVenda.GetControleEspecial(Value:String);
begin
  {if Value = 'S' then
  CheckBoxControleEspecial.Checked :=true
  else
  CheckBoxControleEspecial.Checked:=false;}
end;

function TFormVenda.GetStatusVenda(StatusVenda: String): String;
begin
  if StatusVenda = 'C' then
  Result:='Concluido'
  else
  Result:='Pendente de Receita';
end;

procedure TFormVenda.GridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  DesenhaCheckBoxGridPadrao(DsGrid.DataSet,'STATUS_VENDA','C',Grid,Column,Rect);
end;

procedure TFormVenda.GridParaEdits;
begin
  inherited;
  EditId.Text:=DsGrid.DataSet.FieldByName('ID').AsString;
  EditIdCliente.Text:=DsGrid.DataSet.FieldByName('ID_CLIENTE').AsString;
  EditClienteNome.Text:=DsGrid.DataSet.FieldByName('NOME').AsString;
  EditValor.Text:=DsGrid.DataSet.FieldByName('VALOR').AsString;
  DateTimePickerDataVenda.Date:= DsGrid.DataSet.FieldByName('DATA_VENDA').AsDateTime;
  EditStatusVenda.Text:=GetStatusVenda(DsGrid.DataSet.FieldByName('STATUS_VENDA').AsString);
  //GetControleEspecial(DsGrid.DataSet.FieldByName('CONTROLE_ESPECIAL').AsString);
  ListarRegistrosDetalhe;
end;

function TFormVenda.Inserir: boolean;
begin
  Result := inherited Inserir;
  if Result then
  begin
    EditIdCliente.SetFocus;
    EditValor.Text:='0,00';
    EditIdCliente.Text:='0';
  end;
end;

procedure TFormVenda.LimparGridDetalhe;
begin
  inherited;
  //if CdsVendaDetalhe.RecordCount > 0 then
  CdsVendaDetalhe.EmptyDataSet;
end;

procedure TFormVenda.ListarRegistros;
begin
  inherited;
     FController
     .Entidades
     .VendaCabecalho
     .ConsultarLista
     .DataSet(DsGrid);
end;

procedure TFormVenda.ListarRegistrosDetalhe;
begin
  FController
    .Entidades
    .VendaDetalhe
    .ConsultarLista(DsGrid.DataSet.FieldByName('ID').AsInteger)
    .DataSet(DsGridDetalhe);

  PopulaGridDetalhe(CdsVendaDetalhe,DsGridDetalhe.DataSet);

end;

procedure TFormVenda.PopulaGridDetalhe(Cds:TClientDataSet;DataSet:TDataSet);
var I:Integer;
begin
  inherited;
   DataSet.First;
   for I := 0 to DataSet.RecordCount -1 do
   begin
      Cds.Append;
      Cds.FieldByName('ID').AsInteger:= DataSet.FieldByName('ID').AsInteger;
      Cds.FieldByName('ID_PRODUTO').AsInteger:= DataSet.FieldByName('ID_PRODUTO').AsInteger;
      Cds.FieldByName('PRODUTONOME').AsString:= DataSet.FieldByName('PRODUTONOME').AsString;
      Cds.FieldByName('QUANTIDADE').AsFloat:= DataSet.FieldByName('QUANTIDADE').AsFloat;
      Cds.FieldByName('VALOR_UNITARIO').AsFloat:= DataSet.FieldByName('VALOR_UNITARIO').AsFloat;
      Cds.FieldByName('VALOR_TOTAL').AsFloat:= DataSet.FieldByName('VALOR_TOTAL').AsFloat;
      Cds.FieldByName('CONTROLE_ESPECIAL').AsString:= DataSet.FieldByName('CONTROLE_ESPECIAL').AsString;
      Cds.FieldByName('TECNICO_AGRICOLANOME').AsString:= DataSet.FieldByName('TECNICO_AGRICOLANOME').AsString;
      Cds.FieldByName('ID_TECNICO_AGRICOLA').AsInteger:= DataSet.FieldByName('ID_TECNICO_AGRICOLA').AsInteger;
      Cds.FieldByName('ID_VENDA_CABECALHO').AsInteger:= DataSet.FieldByName('ID_VENDA_CABECALHO').AsInteger;
      Cds.Post;
      DataSet.Next;
    end;
end;

procedure TFormVenda.PreencheDadosCliente;
var FConexao : iConexao;
begin
//  Controller:=TController.New;

 // FConexao:=TConexao.

  //FController.Entidades.Cliente.ConsultarLista.DataSet(DsCliente);
  //FController.Entidades.Cliente.DataSet1(DBLookupComboBoxIdCliente.ListSource.DataSet);
  //FController.Entidades.Cliente.DataSet1(DBGridVendaDetalhe.DataSource.DataSet);



 // FController.Entidades.Cliente.ConsultarLista.DataSet();
end;

function TFormVenda.Salvar: boolean;
var IdRegistro:Integer;
begin
  Result := inherited Salvar;
  if Result then
  begin
    try
      if StatusTela = stInserindo then
      begin
      FController
        .Entidades
        .VendaCabecalho
        .This
        .IdCliente(strtoint(EditIdCliente.Text))
        .Valor(strtofloat(EditValor.Text))
        .DataVenda(DateTimePickerDataVenda.DateTime)
        .Valor(StrTofloat(EditValor.Text))
        .QuantidadeItensVenda(CdsVendaDetalhe.RecordCount)
        .StatusVenda('P')
        .&End
        .Inserir;
        SalvarItens(DsGrid.DataSet.FieldByName('ID').AsInteger)
      end
      else if StatusTela = stEditando then
      begin
        IdREgistro:=IdRegistroSelecionado;
      FController
        .Entidades
        .VendaCabecalho
        .This
        .IdCliente(strtoint(EditIdCliente.Text))
        .Valor(strtofloat(EditValor.Text))
        .DataVenda(DateTimePickerDataVenda.DateTime)
        .Valor(StrTofloat(EditValor.Text))
        .QuantidadeItensVenda(CdsVendaDetalhe.RecordCount)
        .StatusVenda('P')
        .Id(strtoint(EditId.text))
        .&End
        .Atualizar;
        ListarRegistros;
        DsGrid.DataSet.Locate('ID',IdRegistro,[]);
        SalvarItens(DsGrid.DataSet.FieldByName('ID').AsInteger);
      end;

      FControllerVenda.AtualizarStatus(DsGrid.DataSet.FieldByName('ID').AsInteger);
      DsGrid.DataSet.Refresh;
    except
      Result:=False;
    end;
  end;
end;

procedure TFormVenda.SalvarItens(IdVendaCabecalho: Integer);
var teste:integer;
  I: Integer;
begin
  CdsVendaDetalhe.First;
  for I := 0 to CdsVendaDetalhe.RecordCount -1 do begin

    if CdsVendaDetalhe.FieldByName('ID').AsInteger > 0 then
    FController
      .Entidades
      .VendaDetalhe
      .This
      .Id(CdsVendaDetalhe.FieldByName('ID').AsInteger)
      .IdVendaCabecalho(IdVendaCabecalho)
      .IdProduto(CdsVendaDetalhe.FieldByName('ID_PRODUTO').AsInteger)
      .Quantidade(CdsVendaDetalhe.FieldByName('QUANTIDADE').AsFloat)
      .ValorUnitario(CdsVendaDetalhe.FieldByName('VALOR_UNITARIO').AsFloat)
      .ValorTotal(CdsVendaDetalhe.FieldByName('VALOR_TOTAL').AsFloat)
      //.IdTecnicoAgricola(CdsVendaDetalhe.FieldByName('ID_TECNICO_AGRICOLA').AsInteger)
      .ControleEspecial(CdsVendaDetalhe.FieldByName('CONTROLE_ESPECIAL').AsString)
      .&End
      .Atualizar

     else
      FController
      .Entidades
      .VendaDetalhe
      .This
      .IdVendaCabecalho(IdVendaCabecalho)
      .IdProduto(CdsVendaDetalhe.FieldByName('ID_PRODUTO').AsInteger)
      .Quantidade(CdsVendaDetalhe.FieldByName('QUANTIDADE').AsFloat)
      .ValorUnitario(CdsVendaDetalhe.FieldByName('VALOR_UNITARIO').AsFloat)
      .ValorTotal(CdsVendaDetalhe.FieldByName('VALOR_TOTAL').AsFloat)
      .IdTecnicoAgricola(CdsVendaDetalhe.FieldByName('ID_TECNICO_AGRICOLA').AsInteger)
      .ControleEspecial(CdsVendaDetalhe.FieldByName('CONTROLE_ESPECIAL').AsString)
      .&End
      .Inserir;

      CdsVendaDetalhe.Next;
  end;


end;

function TFormVenda.SetControleEspecial: String;
begin
  {if CheckBoxControleEspecial.Checked then
  Result:='S'
  else
  Result:='N';}
end;

procedure TFormVenda.VinculaCamposBD;
begin
  inherited;
  {DBEditId.DataField:='ID';
  DBEditNome.DataField:='NOME';
  DBEditValor.DataField:='VALOR';
  DBCheckBoxControleEspecial.DataField:='CONTROLE_ESPECIAL';}
end;

end.
