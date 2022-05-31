inherited FormConferenciaReceita: TFormConferenciaReceita
  Caption = 'Solicita'#231#245'es de Receita'
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelToolBar: TPanel
    inherited BotaoInserir: TSpeedButton
      Visible = False
    end
    inherited BotaoAlterar: TSpeedButton
      Width = 178
      Caption = 'Iniciar Processo de Assinatura'
      ImageIndex = 16
      ExplicitLeft = 215
      ExplicitTop = 0
      ExplicitWidth = 178
    end
    inherited BotaoExcluir: TSpeedButton
      Left = 393
      Visible = False
      ExplicitLeft = 393
    end
    inherited BotaoCancelar: TSpeedButton
      Left = 493
      ExplicitLeft = 493
    end
    inherited BotaoSalvar: TSpeedButton
      Left = 593
      Caption = 'Assinar Receita'
      ImageIndex = 1
      ExplicitLeft = 593
    end
  end
  inherited PageControl1: TPageControl
    ActivePage = TsEdits
    inherited TsEdits: TTabSheet
      inherited PanelEdits: TPanel
        object GroupBoxCabecalho: TGroupBox
          Left = 1
          Top = 1
          Width = 744
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
            Left = 71
            Top = 9
            Width = 33
            Height = 13
            Caption = 'Cliente'
          end
          object LabelCFP: TLabel
            Left = 503
            Top = 9
            Width = 24
            Height = 13
            Caption = 'Valor'
          end
          object Label1: TLabel
            Left = 591
            Top = 9
            Width = 31
            Height = 13
            Caption = 'Status'
          end
          object Label2: TLabel
            Left = 410
            Top = 9
            Width = 23
            Height = 13
            Caption = 'Data'
          end
          object EditId: TEdit
            Left = 11
            Top = 28
            Width = 54
            Height = 21
            Enabled = False
            ReadOnly = True
            TabOrder = 0
          end
          object DateTimePickerDataVenda: TDateTimePicker
            Left = 410
            Top = 28
            Width = 87
            Height = 21
            Date = 44709.000000000000000000
            Time = 0.776269270834745800
            Enabled = False
            TabOrder = 1
          end
          object EditValor: TEdit
            Left = 503
            Top = 28
            Width = 82
            Height = 21
            ReadOnly = True
            TabOrder = 2
          end
          object EditStatusVenda: TEdit
            Left = 591
            Top = 28
            Width = 145
            Height = 21
            ReadOnly = True
            TabOrder = 3
          end
          object EditIdCliente: TEdit
            Left = 71
            Top = 28
            Width = 53
            Height = 21
            ReadOnly = True
            TabOrder = 4
          end
          object EditClienteNome: TSearchBox
            Left = 125
            Top = 28
            Width = 279
            Height = 21
            ReadOnly = True
            TabOrder = 5
          end
        end
        object GroupBoxVendaDetalhe: TGroupBox
          Left = 1
          Top = 73
          Width = 744
          Height = 269
          Align = alClient
          Caption = 
            'Itens com controle especial (Necessitam de assinatura de um tenc' +
            'ico agr'#237'cola)'
          TabOrder = 1
          object DBGridVendaDetalhe: TDBGrid
            Left = 2
            Top = 15
            Width = 740
            Height = 252
            Align = alClient
            DataSource = DsGridDetalhe
            ReadOnly = True
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
          end
        end
      end
    end
  end
  inherited DsGrid: TDataSource
    Left = 452
    Top = 287
  end
  object DsGridDetalhe: TDataSource
    Left = 109
    Top = 240
  end
end
