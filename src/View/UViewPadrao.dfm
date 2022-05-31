object FPadrao: TFPadrao
  Left = 0
  Top = 0
  Caption = 'Formulario Padrao'
  ClientHeight = 402
  ClientWidth = 754
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PanelToolBar: TPanel
    Left = 0
    Top = 0
    Width = 754
    Height = 31
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    StyleElements = []
    object BotaoSair: TSpeedButton
      Left = 650
      Top = 0
      Width = 100
      Height = 27
      Hint = 'Sair [F8]'
      Align = alRight
      Caption = 'Sair'
      ImageIndex = 12
      Images = DataModuleGeral.ImagensCadastros
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = BotaoSairClick
      ExplicitLeft = 943
    end
    object BotaoSeparador1: TSpeedButton
      Left = 640
      Top = 0
      Width = 10
      Height = 27
      Align = alRight
      Caption = '|'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 578
    end
    object BotaoSeparador3: TSpeedButton
      Left = 105
      Top = 0
      Width = 10
      Height = 27
      Align = alLeft
      Caption = '|'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 106
      ExplicitTop = -4
    end
    object BotaoInserir: TSpeedButton
      Left = 115
      Top = 0
      Width = 100
      Height = 27
      Hint = 'Inserir [F2]'
      Align = alLeft
      Caption = 'Inserir'
      ImageIndex = 31
      Images = DataModuleGeral.ImagensCadastros
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = BotaoInserirClick
      ExplicitLeft = 163
    end
    object BotaoAlterar: TSpeedButton
      Left = 215
      Top = 0
      Width = 100
      Height = 27
      Hint = 'Alterar [F3]'
      Align = alLeft
      Caption = 'Alterar'
      ImageIndex = 35
      Images = DataModuleGeral.ImagensCadastros
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = BotaoAlterarClick
      ExplicitLeft = 257
      ExplicitTop = -4
    end
    object BotaoExcluir: TSpeedButton
      Left = 315
      Top = 0
      Width = 100
      Height = 27
      Hint = 'Excluir [F4]'
      Align = alLeft
      Caption = 'Excluir'
      ImageIndex = 34
      Images = DataModuleGeral.ImagensCadastros
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = BotaoExcluirClick
      ExplicitLeft = 363
    end
    object BotaoCancelar: TSpeedButton
      Left = 415
      Top = 0
      Width = 100
      Height = 27
      Hint = 'Cancelar [F11]'
      Align = alLeft
      Caption = 'Cancelar'
      ImageIndex = 10
      Images = DataModuleGeral.ImagensCadastros
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = BotaoCancelarClick
      ExplicitLeft = 535
      ExplicitTop = -4
    end
    object BotaoSalvar: TSpeedButton
      Left = 515
      Top = 0
      Width = 100
      Height = 27
      Hint = 'Salvar [F12]'
      Align = alLeft
      Caption = 'Salvar'
      ImageIndex = 32
      Images = DataModuleGeral.ImagensCadastros
      Flat = True
      ParentShowHint = False
      ShowHint = True
      OnClick = BotaoSalvarClick
      ExplicitLeft = 563
    end
    object PanelNavegacao: TPanel
      Left = 0
      Top = 0
      Width = 105
      Height = 27
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      Visible = False
      object BotaoPrimeiroRegistro: TSpeedButton
        Left = 0
        Top = 0
        Width = 25
        Height = 27
        Align = alLeft
        ImageIndex = 20
        Images = DataModuleGeral.ImagensCadastros
        Flat = True
        ParentShowHint = False
        ShowHint = True
        OnClick = BotaoPrimeiroRegistroClick
        ExplicitLeft = 25
      end
      object BotaoRegistroAnterior: TSpeedButton
        Left = 25
        Top = 0
        Width = 25
        Height = 27
        Align = alLeft
        ImageIndex = 19
        Images = DataModuleGeral.ImagensCadastros
        Flat = True
        ParentShowHint = False
        ShowHint = True
        OnClick = BotaoRegistroAnteriorClick
        ExplicitLeft = 50
      end
      object BotaoProximoRegistro: TSpeedButton
        Left = 50
        Top = 0
        Width = 25
        Height = 27
        Align = alLeft
        ImageIndex = 22
        Images = DataModuleGeral.ImagensCadastros
        Flat = True
        ParentShowHint = False
        ShowHint = True
        OnClick = BotaoProximoRegistroClick
        ExplicitLeft = 75
      end
      object BotaoUltimoRegistro: TSpeedButton
        Left = 75
        Top = 0
        Width = 25
        Height = 27
        Align = alLeft
        ImageIndex = 21
        Images = DataModuleGeral.ImagensCadastros
        Flat = True
        ParentShowHint = False
        ShowHint = True
        OnClick = BotaoUltimoRegistroClick
        ExplicitLeft = 100
      end
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 31
    Width = 754
    Height = 371
    ActivePage = TsGrid
    Align = alClient
    TabOrder = 1
    object TsGrid: TTabSheet
      Caption = 'PaginaGrid'
      object PanelGrid: TPanel
        Left = 0
        Top = 0
        Width = 746
        Height = 343
        Align = alClient
        Caption = ' '
        TabOrder = 0
        object Grid: TDBGrid
          Left = 1
          Top = 1
          Width = 744
          Height = 287
          Align = alClient
          DataSource = DsGrid
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDblClick = GridDblClick
        end
        object Panel1: TPanel
          Left = 1
          Top = 288
          Width = 744
          Height = 54
          Align = alBottom
          Caption = ' '
          TabOrder = 1
          DesignSize = (
            744
            54)
          object SpeedButton1: TSpeedButton
            Left = 8
            Top = 10
            Width = 721
            Height = 33
            Anchors = [akLeft, akTop, akRight]
            Caption = 'Listar Registros'
            OnClick = SpeedButton1Click
          end
        end
      end
    end
    object TsEdits: TTabSheet
      Caption = 'Pagina Edits'
      ImageIndex = 1
      object PanelEdits: TPanel
        Left = 0
        Top = 0
        Width = 746
        Height = 343
        Align = alClient
        Caption = ' '
        TabOrder = 0
      end
    end
  end
  object DsGrid: TDataSource
    Left = 284
    Top = 151
  end
end
