object frmPesquisa: TfrmPesquisa
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Pesquisando'
  ClientHeight = 365
  ClientWidth = 610
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 72
    Height = 13
    Caption = 'Pesquisando...'
  end
  object btnOK: TSpeedButton
    Left = 500
    Top = 327
    Width = 100
    Height = 30
    Caption = 'OK'
    OnClick = btnOKClick
  end
  object edtPesquisa: TEdit
    Left = 8
    Top = 24
    Width = 584
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 0
    Text = 'EDTPESQUISA'
    OnKeyDown = edtPesquisaKeyDown
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 56
    Width = 592
    Height = 265
    DataSource = dsPesquisa
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
  end
  object qryPesquisa: TFDQuery
    Connection = dmDados.Conexao
    Left = 488
    Top = 80
  end
  object dsPesquisa: TDataSource
    DataSet = qryPesquisa
    Left = 488
    Top = 128
  end
end
