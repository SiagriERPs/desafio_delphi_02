object FPadraoDetalhe: TFPadraoDetalhe
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Formulario Padrao Dados Grid'
  ClientHeight = 289
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBoxDados: TGroupBox
    Left = 0
    Top = 0
    Width = 554
    Height = 241
    Align = alTop
    Caption = ' '
    TabOrder = 0
  end
  object BotaoConcluir: TBitBtn
    Left = 64
    Top = 247
    Width = 201
    Height = 25
    Caption = 'Salvar (Ctrl + S)'
    TabOrder = 1
  end
  object BotaoVoltar: TBitBtn
    Left = 271
    Top = 247
    Width = 201
    Height = 25
    Caption = 'Voltar'
    TabOrder = 2
  end
end
