unit UViewPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,Tipos, UDatamoduleGeral,Vcl.StdCtrls,Vcl.Mask,
  Vcl.DBCtrls,System.Math,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,Datasnap.DBClient;

  type
  TStatusTela = (stNavegandoGrid, stInserindo, stEditando, stNavegandoEdits);

type
  TFPadrao = class(TForm)
    PanelToolBar: TPanel;
    BotaoSair: TSpeedButton;
    BotaoSeparador1: TSpeedButton;
    BotaoSeparador3: TSpeedButton;
    BotaoInserir: TSpeedButton;
    BotaoAlterar: TSpeedButton;
    BotaoExcluir: TSpeedButton;
    BotaoCancelar: TSpeedButton;
    BotaoSalvar: TSpeedButton;
    PanelNavegacao: TPanel;
    BotaoPrimeiroRegistro: TSpeedButton;
    BotaoRegistroAnterior: TSpeedButton;
    BotaoProximoRegistro: TSpeedButton;
    BotaoUltimoRegistro: TSpeedButton;
    PageControl1: TPageControl;
    TsGrid: TTabSheet;
    TsEdits: TTabSheet;
    PanelGrid: TPanel;
    Grid: TDBGrid;
    PanelEdits: TPanel;
    DsGrid: TDataSource;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure BotaoInserirClick(Sender: TObject);
    procedure BotaoAlterarClick(Sender: TObject);
    procedure BotaoExcluirClick(Sender: TObject);
    procedure BotaoCancelarClick(Sender: TObject);
    procedure BotaoSalvarClick(Sender: TObject);
    procedure BotaoSairClick(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure BotaoUltimoRegistroClick(Sender: TObject);
    procedure BotaoPrimeiroRegistroClick(Sender: TObject);
    procedure BotaoRegistroAnteriorClick(Sender: TObject);
    procedure BotaoProximoRegistroClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);

  private
    { Private declarations }

    FStatusTela: TStatusTela;
    procedure SetStatusTela(const Value: TStatusTela);

  public
    { Public declarations }
    QueryPesquisa:TFDQuery;
    PanelVisivel: Tipos.TPanelExibir;
    property StatusTela: TStatusTela read FStatusTela write SetStatusTela;
    procedure IconeBotao(pBotao: TBitBtn; pTipo: TImagem; pStatus: TStatusImagem; pTamanho: TTamanhoImagem); overload;
    procedure IconeBotao(pBotao: TSpeedButton; pTipo: TImagem; pStatus: TStatusImagem; pTamanho: TTamanhoImagem); overload;
    procedure ExibePanel(pPanelExibir: TPanelExibir);

    function Inserir:boolean;virtual;
    function Editar:boolean;virtual;
    function Excluir:boolean;virtual;
    function Cancelar:boolean;virtual;
    function Salvar:boolean;virtual;

    procedure ListarRegistros;virtual;
    procedure GridParaEdits;virtual;
    procedure LimparCampos; virtual;
    procedure LimparGridDetalhe;virtual;
    procedure VinculaCamposBD;virtual;

    function  IdRegistroSelecionado(Id:Integer = 0): Integer;
    procedure AbreFormularioDadosGridPadrao(Crud:String;TFormulario:TComponentClass;Formulario:
    TForm;Dataset:TClientDataSet;AbreEmModoDeNavegacao:boolean;IdTemporario:Integer = 0);virtual;
    procedure AjustaLayoutGrid;virtual;

    procedure DesenhaCheckBoxGridPadrao(Ds:TDataSet;Field,CheckTrue:String;Grid:TDBGrid;Column: TColumn;const Rect: TRect);

    function PesquisaPadrao(TFormulario:TComponentClass;Formulario:TForm):boolean;

    procedure PopulaGridDetalhe(Cds:TClientDataSet;DataSet:TDataSet);virtual;

  end;


implementation

{$R *.dfm}

{ TFPadrao }

function TFPadrao.PesquisaPadrao(TFormulario:TComponentClass;Formulario:TForm):boolean;
begin
  //Result:=false;
  Application.CreateForm(TFormulario,Formulario);
  //QueryPesquisa.CloneCursor(ds as TFDQuery,false);
  Formulario.ShowModal;
  Formulario.Destroy;
  //if QueryPesquisa.RecordCount > 0 then
  //Result:=true;
end;




procedure TFPadrao.PopulaGridDetalhe(Cds: TClientDataSet; DataSet: TDataSet);
begin

end;

procedure TFPadrao.DesenhaCheckBoxGridPadrao(Ds:TDataSet;Field,CheckTrue:String;Grid:TDBGrid;Column: TColumn;const Rect: TRect);
var
  iCheck: Integer;
  rRect: TRect;
begin
  //Desenha um checkbox no dbgrid
  if Column.FieldName = Field then
  begin
    Grid.Canvas.FillRect(Rect);
    iCheck := 0;
    if DS.FieldByName(Field).AsString = CheckTrue then
      iCheck := DFCS_CHECKED
    else
      iCheck := 0;
    rRect := Rect;
    InflateRect(rRect,-2,-2);
    DrawFrameControl(Grid.Canvas.Handle,rRect,DFC_BUTTON, DFCS_BUTTONCHECK or iCheck);
  end;
end;



procedure TFPadrao.AbreFormularioDadosGridPadrao(Crud:String;TFormulario:TComponentClass;Formulario:TForm;
DataSet:TClientDataSet;AbreEmModoDeNavegacao:boolean;IdTemporario:Integer = 0);
begin
  if (StatusTela = stInserindo) or (StatusTela=stEditando)  then
  begin
    if Crud = 'C' then
    begin
      if IdTemporario > 0 then
      begin
        DataSet.Append;
        DataSet.FieldByName('ID').AsInteger:= IdTemporario;
      end
      else
      DataSet.Append;
    end
    else
    DataSet.Edit;
    Application.CreateForm(TFormulario,Formulario);
    Formulario.ShowModal;
    Formulario.Destroy;
  end;

  if StatusTela = stNavegandoEdits then
  begin
    if Crud = 'C' then
    Application.MessageBox('Incluões de Registros só poderão ser feitos em modo de inserção ou alteração', 'Atenção!',MB_IconInformation)
    else
    begin
      if AbreEmModoDeNavegacao = true then
      begin
        Application.CreateForm(TFormulario,Formulario);
        Formulario.ShowModal;
        Formulario.Destroy;
      end;
    end;
  end;
end;


procedure TFPadrao.FormCreate(Sender: TObject);
begin
  ExibePanel(peGrid);
  BotaoCancelar.Visible:=False;
  BotaoSalvar.Visible:=false;
  //IconeBotao(BotaoInserir, iIncluir, siHabilitada, ti16);
  //IconeBotao(BotaoAlterar, iAlterar, siHabilitada, ti16);
  //IconeBotao(BotaoExcluir, iExcluir, siHabilitada, ti16);
  //IconeBotao(BotaoSalvar, iSalvar, siHabilitada, ti16);
  //IconeBotao(BotaoCancelar, iCancelar, siHabilitada, ti16);
  //IconeBotao(BotaoSalvar, iSalvar, siHabilitada, ti16);
  VinculaCamposBD;
  ListarRegistros;
  AjustaLayoutGrid;
  QueryPesquisa:=TFDQuery.Create(nil)

end;

procedure TFPadrao.GridDblClick(Sender: TObject);
begin
  if not DsGrid.DataSet.IsEmpty then
  begin
    ExibePanel(peEdits);
    GridParaEdits;
    StatusTela := stNavegandoEdits;
    BotaoCancelar.Caption := 'Voltar [F11]';
    IconeBotao(BotaoCancelar, iSair, siHabilitada, ti16);
    // todo:verificar porque nao esta dando certo a troca de imagem do botao cancelar
  end;
end;

procedure TFPadrao.GridParaEdits;
begin
  LimparGridDetalhe;
  LimparCampos;
end;

procedure TFPadrao.IconeBotao(pBotao: TBitBtn; pTipo: TImagem; pStatus: TStatusImagem; pTamanho: TTamanhoImagem);
var
  Retorno: TBitmap;
begin
  Retorno := TBitmap.Create;
  if Assigned(pBotao.Glyph) then
  pBotao.Glyph.FreeImage;
  pBotao.Glyph := DataModuleGeral.Imagem(pTipo, pStatus, pTamanho, Retorno);
  FreeAndNil(Retorno);
end;

procedure TFPadrao.IconeBotao(pBotao: TSpeedButton; pTipo: TImagem; pStatus: TStatusImagem; pTamanho: TTamanhoImagem);
var Retorno: TBitmap;
begin
  Retorno := TBitmap.Create;
  if Assigned(pBotao.Glyph) then
  pBotao.Glyph.FreeImage;
  pBotao.Glyph := DataModuleGeral.Imagem(pTipo, pStatus, pTamanho, Retorno);
  FreeAndNil(Retorno);
end;

function TFPadrao.IdRegistroSelecionado(Id: Integer): Integer;
begin
  if Id = 0 then
  begin
  if DSGrid.DataSet.IsEmpty then
    Result := 0
  else
    Result := DSGrid.DataSet.FieldByName('ID').AsInteger;
  end
  else
  Result:=Id;
end;

function TFPadrao.Inserir: boolean;
begin
  try
    LimparCampos;
    LimparGridDetalhe;
    ExibePanel(peEdits);
    StatusTela := stInserindo;
    Result := True;
  except
    Result:=False;
  end;
end;

procedure TFPadrao.LimparCampos;
var I:Integer;
begin
  for I := 0 to ComponentCount - 1 do
  begin
    if (Components[I] is TEdit) then
    (Components[I] as TEdit).Text := '';
    if (Components[I] is TDBEdit) then
    (Components[I] as TDBEdit).Field.Clear;
    if (Components[I] is TMemo) then
    (Components[I] as TMemo).Lines.Clear;
    if (Components[I] is TMaskEdit) then
    (Components[I] as TMaskEdit).Text := '';
  end;
end;

procedure TFPadrao.LimparGridDetalhe;
begin

end;

procedure TFPadrao.ListarRegistros;
begin

end;



function TFPadrao.Salvar: boolean;
begin
  try
    Result:=True;
    PanelEdits.Visible := True;
  except
    Result:=False;
  end;
end;

procedure TFPadrao.SetStatusTela(const Value: TStatusTela);
begin
  FStatusTela := Value;
  BotaoInserir.Visible := False;
  BotaoAlterar.Visible := False;
  BotaoExcluir.Visible := False;
  BotaoSalvar.Visible := False;
  BotaoCancelar.Visible := False;
  BotaoSeparador1.Visible := False;
  BotaoPrimeiroRegistro.Visible:=false;
  BotaoRegistroAnterior.Visible:=false;
  BotaoProximoRegistro.Visible:=false;
  BotaoUltimoRegistro.Visible:=false;
  PanelEdits.Enabled := True;
  case Value of
    stNavegandoGrid:
      begin
        BotaoExcluir.Visible := True;
        BotaoAlterar.Visible := True;
        BotaoInserir.Visible := True;
        BotaoSeparador1.Visible := True;
        BotaoPrimeiroRegistro.Visible:=true;
        BotaoRegistroAnterior.Visible:=true;
        BotaoProximoRegistro.Visible:=true;
        BotaoUltimoRegistro.Visible:=true;
        AjustaLayoutGrid;
      end;
    stInserindo, stEditando:
      begin
        BotaoCancelar.Visible := True;
        BotaoSalvar.Visible := True;
        BotaoPrimeiroRegistro.Visible:=false;
        BotaoRegistroAnterior.Visible:=false;
        BotaoProximoRegistro.Visible:=false;
        BotaoUltimoRegistro.Visible:=false;

      end;
    stNavegandoEdits:
      begin
        BotaoCancelar.Visible := True;
        BotaoExcluir.Visible := True;
        BotaoAlterar.Visible := True;
        BotaoInserir.Visible := True;
        PanelEdits.Enabled := False;
        BotaoPrimeiroRegistro.Visible:=true;
        BotaoRegistroAnterior.Visible:=true;
        BotaoProximoRegistro.Visible:=true;
        BotaoUltimoRegistro.Visible:=true;

      end;
  end;
end;

procedure TFPadrao.SpeedButton1Click(Sender: TObject);
begin
  ListarRegistros;
  AjustaLayoutGrid;
end;

procedure TFPadrao.VinculaCamposBD;
begin

end;

procedure TFPadrao.AjustaLayoutGrid;
begin

end;

procedure TFPadrao.BotaoAlterarClick(Sender: TObject);
begin
  Editar;
  BotaoCancelar.Caption := 'Cancelar [F11]';
  IconeBotao(BotaoCancelar, iCancelar, siHabilitada, ti16);
end;

procedure TFPadrao.BotaoCancelarClick(Sender: TObject);
begin
  if (StatusTela = stInserindo) or (StatusTela = stEditando) or (Statustela = stNavegandoEdits) then
  begin
    if BotaoCancelar.Caption = 'Voltar [F11]' then
    begin
      Cancelar;
      IconeBotao(BotaoCancelar, iCancelar, siHabilitada, ti16)
    end
    else
    begin
      if Application.MessageBox('Deseja realmente cancelar?','Pergunta do Sitema',MB_ICONINFORMATION+MB_YESNO)=IDNO then
      abort;
      Cancelar;
      BotaoCancelar.Caption := 'Cancelar [F11]';
      IconeBotao(BotaoCancelar, iCancelar, siHabilitada, ti16)
    end;
  end;
end;

procedure TFPadrao.BotaoExcluirClick(Sender: TObject);
begin
  if Excluir then
  begin
    AjustaLayoutGrid;
    if StatusTela = stNavegandoEdits then
    begin
      GridParaEdits;
    end;
  end;
end;

procedure TFPadrao.BotaoInserirClick(Sender: TObject);
begin
  Inserir;
  BotaoCancelar.Caption := 'Cancelar [F11]';
  IconeBotao(BotaoCancelar, iCancelar, siHabilitada, ti16);
end;

procedure TFPadrao.BotaoPrimeiroRegistroClick(Sender: TObject);
begin
 DsGrid.DataSet.first;
end;

procedure TFPadrao.BotaoProximoRegistroClick(Sender: TObject);
begin
  DsGrid.DataSet.Next;
end;

procedure TFPadrao.BotaoRegistroAnteriorClick(Sender: TObject);
begin
  DsGrid.DataSet.prior;
end;

procedure TFPadrao.BotaoSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFPadrao.BotaoSalvarClick(Sender: TObject);
var
  LinhaAtual: TBookMark;
begin
  if Salvar then
  begin
    ExibePanel(peGrid);
    LimparCampos;
    LimparGridDetalhe;
    Grid.SetFocus;
    StatusTela := stNavegandoGrid;
  end;
end;

procedure TFPadrao.BotaoUltimoRegistroClick(Sender: TObject);
begin
  DsGrid.DataSet.Last;
end;

function TFPadrao.Cancelar: boolean;
begin
  try
    ExibePanel(peGrid);
    LimparCampos;
    LimparGridDetalhe;
    Grid.SetFocus;
    StatusTela := stNavegandoGrid;
    Result := True;
  except
    Result := False;
  end;
end;

function TFPadrao.Editar: boolean;
begin
  try
    Result := True;
    PanelEdits.Visible := True;
    if DSGrid.DataSet.IsEmpty then
    Application.MessageBox('Não existe registro selecionado.', 'Erro',MB_OK + MB_ICONERROR)
    else
    begin
      ExibePanel(peEdits);
      StatusTela := stEditando;
      GridParaEdits;
      Result := True;
    end;
  except
    Result:=False;
  end;
end;

function TFPadrao.Excluir: boolean;
begin
  Result := False;
  try
  if DSGrid.DataSet.IsEmpty then
  Application.MessageBox('Não existe registro selecionado.', 'Erro', MB_OK + MB_ICONERROR)
  else
  begin
    if Application.MessageBox('Deseja realmente excluir o registro selecionado?', 'Pergunta do sistema', MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
      Result := True;
    end;
  end;
  except
    Result:=False;
  end;
end;

procedure TFPadrao.ExibePanel(pPanelExibir: TPanelExibir);
begin
  PanelVisivel := pPanelExibir;
  if pPanelExibir = peGrid then
  begin
    PanelGrid.Parent := Self;
    PanelGrid.Visible := True;
  end
  else
  begin
    PanelGrid.Visible := False;
  end;

  if pPanelExibir = peEdits then
  begin
    PanelEdits.Parent := self;
    PanelEdits.Visible := True;
  end
  else
  begin
    PanelEdits.Visible := False;
  end;

end;

end.
