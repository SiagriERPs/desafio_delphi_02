object FormPadraoPesquisa: TFormPadraoPesquisa
  Left = 0
  Top = 0
  Caption = 'FormPadraoPesquisa'
  ClientHeight = 335
  ClientWidth = 519
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 272
    Width = 519
    Height = 63
    Align = alBottom
    TabOrder = 0
  end
  object Grid: TDBGrid
    Left = 0
    Top = 57
    Width = 519
    Height = 215
    Align = alClient
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object GroupBoxPesquisa: TGroupBox
    Left = 0
    Top = 0
    Width = 519
    Height = 57
    Align = alTop
    Caption = 'Pesquisa'
    TabOrder = 2
    ExplicitLeft = -477
    ExplicitWidth = 996
    object LabelPesquisa: TLabel
      Left = 2
      Top = 42
      Width = 515
      Height = 13
      Align = alBottom
      Caption = 
        'Pesquisa pelo "Nome". Para mudar o campo de pesquisa selecione o' +
        ' campo desejado na grid'
      ExplicitWidth = 441
    end
    object EditPesquisa: TEdit
      Left = 2
      Top = 21
      Width = 515
      Height = 21
      Align = alBottom
      TabOrder = 0
      OnKeyPress = EditPesquisaKeyPress
    end
  end
  object DsGrid: TDataSource
    Left = 48
    Top = 192
  end
end
