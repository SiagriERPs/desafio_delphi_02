unit View.Cliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UViewPadrao, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls,Controller.Controller,Controller.Interfaces,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, Vcl.Mask, Vcl.StdCtrls;

type
  TFormCliente = class(TFPadrao)
    EditId: TEdit;
    EditNome: TEdit;
    LabelId: TLabel;
    LabelNome: TLabel;
    LabelCFP: TLabel;
    MaskEditCPF: TMaskEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FController : iController;
  public
    { Public declarations }

    procedure ListarRegistros;override;
    procedure GridParaEdits;override;

    //Crud
    function Inserir:boolean;override;
    function Editar:boolean;override;
    function Excluir:boolean;override;
    function Cancelar:boolean;override;
    function Salvar:boolean;override;

    procedure AjustaLayoutGrid;override;
  end;

var
  FormCliente: TFormCliente;

implementation

{$R *.dfm}

procedure TFormCliente.AjustaLayoutGrid;
begin
  inherited;
  DsGrid.DataSet.FieldByName('NOME').DisplayLabel:='Nome';
  DsGrid.DataSet.FieldByName('NOME').DisplayWidth:=80;
  DsGrid.DataSet.FieldByName('CPF').DisplayWidth:=20;
  DsGrid.DataSet.FieldByName('CPF').EditMask:='999.999.999-99;0; ';
end;

function TFormCliente.Cancelar: boolean;
begin
  inherited;
end;

function TFormCliente.Editar: boolean;
begin
  Result := inherited Editar;
  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

function TFormCliente.Excluir: boolean;
begin
  if inherited Excluir then
  try
  FController
   .Entidades
   .Cliente
   .This
   .Id(DsGrid.DataSet.FieldByName('ID').AsInteger)
   .&End
   .Excluir;
  finally
    ListarRegistros;
  end;
end;

procedure TFormCliente.FormCreate(Sender: TObject);
begin
  FController:=TController.New;
  inherited;
end;

procedure TFormCliente.GridParaEdits;
begin
  inherited;
  EditId.Text:=DsGrid.DataSet.FieldByName('ID').AsString;
  EditNome.Text:=DsGrid.DataSet.FieldByName('NOME').AsString;
  MaskEditCpf.Text:=DsGrid.DataSet.FieldByName('CPF').AsString;
end;

function TFormCliente.Inserir: boolean;
begin
  Result := inherited Inserir;
  if Result then
  begin
    EditNome.SetFocus;
  end;
end;

procedure TFormCliente.ListarRegistros;
begin
  inherited;

    FController
     .Entidades
     .Cliente
     .ConsultarLista
     .DataSet(DsGrid);



end;

function TFormCliente.Salvar: boolean;
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
        .Cliente
        .This
        .Nome(EditNome.Text)
        .Cpf(MaskEditCpf.Text)
        .&End
        .Inserir;
      end
      else if StatusTela = stEditando then
      begin
        IdREgistro:=IdRegistroSelecionado;
      FController
        .Entidades
        .Cliente
        .This
        .Nome(EditNome.Text)
        .Cpf(MaskEditCpf.Text)
        .Id(StrToInt(EditId.Text))
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

end.
