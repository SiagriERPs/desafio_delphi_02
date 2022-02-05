object frmBasico: TfrmBasico
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frmBasico'
  ClientHeight = 441
  ClientWidth = 694
  Color = clBtnFace
  Constraints.MaxHeight = 470
  Constraints.MaxWidth = 700
  Constraints.MinHeight = 470
  Constraints.MinWidth = 700
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
  DesignSize = (
    694
    441)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 10
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  object Label4: TLabel
    Left = 10
    Top = 50
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object btnSalvar: TButton
    Left = 509
    Top = 399
    Width = 90
    Height = 30
    Anchors = [akLeft, akRight]
    Caption = '&Salvar'
    TabOrder = 2
    OnClick = btnSalvarClick
  end
  object btnCancelar: TButton
    Left = 600
    Top = 399
    Width = 90
    Height = 30
    Anchors = [akLeft, akRight]
    Caption = '&Cancelar'
    TabOrder = 3
    OnClick = btnCancelarClick
  end
  object edtCodigo: TDBEdit
    Left = 10
    Top = 26
    Width = 100
    Height = 21
    TabStop = False
    DataSource = dsTabela
    ReadOnly = True
    TabOrder = 0
  end
  object edtNome: TDBEdit
    Left = 10
    Top = 66
    Width = 385
    Height = 21
    CharCase = ecUpperCase
    DataSource = dsTabela
    TabOrder = 1
  end
  object DBGrid2: TDBGrid
    Left = 10
    Top = 95
    Width = 676
    Height = 298
    DataSource = dsTabela
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnNovo: TButton
    Left = 418
    Top = 399
    Width = 90
    Height = 30
    Anchors = [akLeft, akRight]
    Caption = '&Novo'
    TabOrder = 5
    OnClick = btnNovoClick
  end
  object dsTabela: TDataSource
    DataSet = qryTabela
    OnDataChange = dsTabelaDataChange
    Left = 288
    Top = 216
  end
  object qryTabela: TFDQuery
    OnNewRecord = qryTabelaNewRecord
    CachedUpdates = True
    Connection = dmDados.Conexao
    Left = 288
    Top = 168
  end
end
