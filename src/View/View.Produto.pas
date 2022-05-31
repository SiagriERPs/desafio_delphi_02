unit View.Produto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UViewPadrao, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls,Controller.Controller,Controller.Interfaces,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, Vcl.Mask, Vcl.StdCtrls, Vcl.DBCtrls,System.Math,Biblioteca;

type
  TFormProduto = class(TFPadrao)
    LabelId: TLabel;
    LabelNome: TLabel;
    LabelCFP: TLabel;
    EditId: TEdit;
    EditNome: TEdit;
    EditValor: TEdit;
    CheckBoxControleEspecial: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure EditValorChange(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    FController : iController;
    function SetControleEspecial:String;
    procedure GetControleEspecial(Value:String);
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



  end;

var
  FormProduto: TFormProduto;

implementation

{$R *.dfm}

procedure TFormProduto.AjustaLayoutGrid;
begin
  inherited;
  DsGrid.DataSet.FieldByName('NOME').DisplayLabel:='Nome';
  DsGrid.DataSet.FieldByName('NOME').DisplayWidth:=60;
  DsGrid.DataSet.FieldByName('VALOR').DisplayWidth:=20;
  DsGrid.DataSet.FieldByName('VALOR').DisplayLabel:='Valor';
  //DsGrid.DataSet.FieldByName('VALOR'):='0.00';
  DsGrid.DataSet.FieldByName('CONTROLE_ESPECIAL').DisplayLabel:='Controle Especial';
end;

function TFormProduto.Cancelar: boolean;
begin
  inherited;
end;

function TFormProduto.Editar: boolean;
begin
  Result := inherited Editar;
  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

procedure TFormProduto.EditValorChange(Sender: TObject);
begin
  inherited;
  if EditValor.Focused then
  Biblioteca.Formatar(EditValor,Valor2);

end;

function TFormProduto.Excluir: boolean;
begin
  if inherited Excluir then
  try
  FController
   .Entidades
   .Produto
   .This
   .Id(DsGrid.DataSet.FieldByName('ID').AsInteger)
   .&End
   .Excluir;
  finally
    ListarRegistros;
  end;
end;

procedure TFormProduto.FormCreate(Sender: TObject);
begin
  FController:=TController.New;
  inherited;
end;

procedure TFormProduto.GetControleEspecial(Value:String);
begin
  if Value = 'S' then
  CheckBoxControleEspecial.Checked :=true
  else
  CheckBoxControleEspecial.Checked:=false;
end;

procedure TFormProduto.GridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  DesenhaCheckBoxGridPadrao(DsGrid.DataSet,'CONTROLE_ESPECIAL','S',Grid,Column,Rect);
end;

procedure TFormProduto.GridParaEdits;
begin
  inherited;
  EditId.Text:=DsGrid.DataSet.FieldByName('ID').AsString;
  EditNome.Text:=DsGrid.DataSet.FieldByName('NOME').AsString;
  EditValor.Text:=DsGrid.DataSet.FieldByName('VALOR').AsString;
  GetControleEspecial(DsGrid.DataSet.FieldByName('CONTROLE_ESPECIAL').AsString);
end;

function TFormProduto.Inserir: boolean;
begin
  Result := inherited Inserir;
  if Result then
  begin
    EditNome.SetFocus;
    EditValor.Text:='0';
  end;
end;

procedure TFormProduto.ListarRegistros;
begin
  inherited;

    FController
     .Entidades
     .Produto
     .ConsultarLista
     .DataSet(DsGrid);
end;



function TFormProduto.Salvar: boolean;
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
        .Produto
        .This
        .Nome(EditNome.Text)
        .Valor(strtofloat(EditValor.Text))
        .ControleEspecial(SetControleEspecial)
        .&End
        .Inserir;
      end
      else if StatusTela = stEditando then
      begin
        IdREgistro:=IdRegistroSelecionado;
      FController
        .Entidades
        .Produto
        .This
        .Nome(EditNome.text)
        .Valor(strtofloat(EditValor.text))
        .ControleEspecial(SetControleEspecial)
        .Id(strtoint(EditId.text))
        .&End
        .Atualizar;
        ListarRegistros;
        DsGrid.DataSet.Locate('ID',IdRegistro,[]);
      end;
    except
      Result:=False;
    end;
  end;
end;

function TFormProduto.SetControleEspecial: String;
begin
  if CheckBoxControleEspecial.Checked then
  Result:='S'
  else
  Result:='N';
end;

procedure TFormProduto.VinculaCamposBD;
begin
  inherited;
  {DBEditId.DataField:='ID';
  DBEditNome.DataField:='NOME';
  DBEditValor.DataField:='VALOR';
  DBCheckBoxControleEspecial.DataField:='CONTROLE_ESPECIAL';}
end;

end.
