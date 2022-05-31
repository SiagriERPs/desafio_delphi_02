inherited FormVenda: TFormVenda
  Caption = 'Cadastro de Vendas'
  ClientWidth = 960
  Position = poMainFormCenter
  ExplicitWidth = 976
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelToolBar: TPanel
    Width = 960
    ExplicitWidth = 960
    inherited BotaoSair: TSpeedButton
      Left = 856
      ExplicitLeft = 763
    end
    inherited BotaoSeparador1: TSpeedButton
      Left = 846
      ExplicitLeft = 753
    end
  end
  inherited PageControl1: TPageControl
    Width = 960
    ActivePage = TsEdits
    ExplicitWidth = 960
    inherited TsGrid: TTabSheet
      ExplicitWidth = 952
      inherited PanelGrid: TPanel
        Width = 952
        ExplicitWidth = 952
        inherited Grid: TDBGrid
          Width = 950
          OnDrawColumnCell = GridDrawColumnCell
        end
        inherited Panel1: TPanel
          Width = 950
          ExplicitWidth = 950
          inherited SpeedButton1: TSpeedButton
            Width = 927
            ExplicitWidth = 834
          end
        end
      end
    end
    inherited TsEdits: TTabSheet
      ExplicitWidth = 952
      inherited PanelEdits: TPanel
        Width = 952
        ExplicitWidth = 952
        object GroupBoxCabecalho: TGroupBox
          Left = 1
          Top = 1
          Width = 950
          Height = 72
          Align = alTop
          TabOrder = 0
          object LabelId: TLabel
            Left = 11
            Top = 9
            Width = 33
            Height = 13
            Caption = 'C'#243'digo'
          end
          object LabelNome: TLabel
            Left = 97
            Top = 9
            Width = 33
            Height = 13
            Caption = 'Cliente'
          end
          object LabelCFP: TLabel
            Left = 571
            Top = 9
            Width = 24
            Height = 13
            Caption = 'Valor'
          end
          object Label1: TLabel
            Left = 698
            Top = 9
            Width = 31
            Height = 13
            Caption = 'Status'
          end
          object Label2: TLabel
            Left = 436
            Top = 9
            Width = 23
            Height = 13
            Caption = 'Data'
          end
          object EditId: TEdit
            Left = 11
            Top = 28
            Width = 80
            Height = 21
            ReadOnly = True
            TabOrder = 0
          end
          object DateTimePickerDataVenda: TDateTimePicker
            Left = 436
            Top = 28
            Width = 129
            Height = 21
            Date = 44709.000000000000000000
            Time = 0.776269270834745800
            Enabled = False
            TabOrder = 1
          end
          object EditValor: TEdit
            Left = 571
            Top = 28
            Width = 121
            Height = 21
            ReadOnly = True
            TabOrder = 2
            OnChange = EditValorChange
          end
          object EditStatusVenda: TEdit
            Left = 698
            Top = 28
            Width = 145
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
          end
          object EditIdCliente: TEdit
            Left = 97
            Top = 28
            Width = 53
            Height = 21
            ReadOnly = True
            TabOrder = 4
          end
          object EditClienteNome: TSearchBox
            Left = 151
            Top = 28
            Width = 279
            Height = 21
            ReadOnly = True
            TabOrder = 5
            OnInvokeSearch = EditClienteNomeInvokeSearch
          end
        end
        object GroupBoxVendaDetalhe: TGroupBox
          Left = 1
          Top = 73
          Width = 950
          Height = 269
          Align = alClient
          Caption = 'Itens'
          TabOrder = 1
          object DBGridVendaDetalhe: TDBGrid
            Left = 2
            Top = 41
            Width = 946
            Height = 226
            Align = alClient
            DataSource = DSVendaDetalhe
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            OnDrawColumnCell = DBGridVendaDetalheDrawColumnCell
            OnDblClick = DBGridVendaDetalheDblClick
          end
          object ActionToolBar1: TActionToolBar
            Left = 2
            Top = 15
            Width = 946
            Height = 26
            ActionManager = ActionManager1
            Caption = 'ActionToolBar1'
            Color = clMenuBar
            ColorMap.DisabledFontColor = 7171437
            ColorMap.HighlightColor = clWhite
            ColorMap.BtnSelectedFont = clBlack
            ColorMap.UnusedColor = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Spacing = 0
          end
        end
      end
    end
  end
  inherited DsGrid: TDataSource
    Left = 892
    Top = 79
  end
  object DsGridDetalhe: TDataSource
    Left = 836
    Top = 231
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = Action1
            Caption = '&Incluir Produto'
            ImageIndex = 31
          end
          item
            Action = Action2
            Caption = '&Excluir Produto'
            ImageIndex = 34
          end>
        ActionBar = ActionToolBar1
      end>
    Images = DataModuleGeral.ImagensCadastros
    Left = 549
    Top = 192
    StyleName = 'Platform Default'
    object Action1: TAction
      Caption = 'Incluir Produto'
      ImageIndex = 31
      OnExecute = Action1Execute
    end
    object Action2: TAction
      Caption = 'Excluir Produto'
      ImageIndex = 34
    end
  end
  object CdsVendaDetalhe: TClientDataSet
    PersistDataPacket.Data = {
      1C0100009619E0BD01000000180000000A0000000000030000001C0102494404
      000100000000000A49445F50524F4455544F04000100000000000A5155414E54
      494441444508000400000000000E56414C4F525F554E49544152494F08000400
      000000000B56414C4F525F544F54414C08000400000000001249445F56454E44
      415F4341424543414C484F040001000000000011434F4E54524F4C455F455350
      454349414C01004900000001000557494454480200020001001349445F544543
      4E49434F5F41475249434F4C4104000100000000000B50524F4455544F4E4F4D
      450100490000000100055749445448020002006400145445434E49434F5F4147
      5249434F4C414E4F4D4501004900000001000557494454480200020064000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 61
    Top = 232
    object CdsVendaDetalheID: TIntegerField
      DisplayWidth = 6
      FieldName = 'ID'
    end
    object CdsVendaDetalheID_PRODUTO: TIntegerField
      DisplayLabel = 'C'#243'd.Prod.'
      DisplayWidth = 11
      FieldName = 'ID_PRODUTO'
      Visible = False
    end
    object CdsVendaDetalhePRODUTONOME: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 41
      FieldName = 'PRODUTONOME'
      Size = 100
    end
    object CdsVendaDetalheQUANTIDADE: TFloatField
      DisplayLabel = 'Quantidade'
      DisplayWidth = 11
      FieldName = 'QUANTIDADE'
      DisplayFormat = '0.0000'
    end
    object CdsVendaDetalheVALOR_UNITARIO: TFloatField
      DisplayLabel = 'Valor Unit.'
      DisplayWidth = 16
      FieldName = 'VALOR_UNITARIO'
      DisplayFormat = '0.00'
    end
    object CdsVendaDetalheVALOR_TOTAL: TFloatField
      DisplayLabel = 'Total'
      DisplayWidth = 17
      FieldName = 'VALOR_TOTAL'
      DisplayFormat = '0.00'
    end
    object CdsVendaDetalheCONTROLE_ESPECIAL: TStringField
      DisplayLabel = 'Controle Especial'
      DisplayWidth = 14
      FieldName = 'CONTROLE_ESPECIAL'
      Size = 1
    end
    object CdsVendaDetalheTECNICO_AGRICOLANOME: TStringField
      DisplayLabel = 'Tec. Agric. Responsavel'
      DisplayWidth = 39
      FieldName = 'TECNICO_AGRICOLANOME'
      Size = 100
    end
    object CdsVendaDetalheID_TECNICO_AGRICOLA: TIntegerField
      DisplayWidth = 20
      FieldName = 'ID_TECNICO_AGRICOLA'
      Visible = False
    end
    object CdsVendaDetalheID_VENDA_CABECALHO: TIntegerField
      DisplayWidth = 19
      FieldName = 'ID_VENDA_CABECALHO'
      Visible = False
    end
  end
  object DSVendaDetalhe: TDataSource
    DataSet = CdsVendaDetalhe
    Left = 53
    Top = 312
  end
end
