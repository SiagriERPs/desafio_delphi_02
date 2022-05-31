unit UViewPadraoDetalhe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,Data.DB,
  Datasnap.DBClient;

type
  TFPadraoDetalhe = class(TForm)
    GroupBoxDados: TGroupBox;
    BotaoConcluir: TBitBtn;
    BotaoVoltar: TBitBtn;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure RegrasCriacaoFormulario(DataSet: TClientDataSet);
    procedure AcoesPadraoBotaoSalvar(DataSet: TDataSet);
    procedure AcoesPadraoBotaoVoltar(DataSet: TDataSet);
  end;

var
  FPadraoDetalhe: TFPadraoDetalhe;

implementation

{$R *.dfm}

procedure TFPadraoDetalhe.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
  BotaoVoltar.Click;
  If (Shift = [ssCtrl]) and (key = 83) then//(key = 53) then
  begin
    if GroupBoxDados.Enabled = true then
    BotaoConcluir.Click;
  end;
end;

procedure TFPadraoDetalhe.RegrasCriacaoFormulario(DataSet: TClientDataSet);
begin
  if (DataSet.State <> dsinsert) and (DataSet.State <> dsedit) then
  begin
    GroupBoxDados.Enabled:=False;
    BotaoConcluir.Enabled:=False;
    BotaoVoltar.Caption:='Sair (Esc)';
    BotaoConcluir.Caption:='Salvar (Ctrl + S)';
  end
  else
  begin
    BotaoVoltar.Caption:='Cancelar Alteração (Esc)';
    BotaoConcluir.Caption:='Salvar (Ctrl + S)';
  end;
end;


procedure TFPadraoDetalhe.AcoesPadraoBotaoSalvar(DataSet: TDataSet);
begin
  if (DataSet.State = dsinsert) or (DataSet.State = dsedit) then
  DataSet.Post;
  Close;
end;

procedure TFPadraoDetalhe.AcoesPadraoBotaoVoltar(DataSet: TDataSet);
begin
  if (DataSet.State = dsinsert) or (DataSet.State = dsedit) then
  DataSet.Cancel;
  Close;
end;

end.
