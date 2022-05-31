inherited FormCliente: TFormCliente
  Caption = 'Cadastro de Clientes'
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl1: TPageControl
    ActivePage = TsEdits
    inherited TsEdits: TTabSheet
      inherited PanelEdits: TPanel
        object LabelId: TLabel
          Left = 2
          Top = 13
          Width = 33
          Height = 13
          Caption = 'C'#243'digo'
        end
        object LabelNome: TLabel
          Left = 87
          Top = 13
          Width = 27
          Height = 13
          Caption = 'Nome'
        end
        object LabelCFP: TLabel
          Left = 467
          Top = 13
          Width = 19
          Height = 13
          Caption = 'CPF'
        end
        object EditId: TEdit
          Left = 2
          Top = 32
          Width = 79
          Height = 21
          Enabled = False
          TabOrder = 0
        end
        object EditNome: TEdit
          Left = 87
          Top = 32
          Width = 374
          Height = 21
          MaxLength = 100
          TabOrder = 1
        end
        object MaskEditCPF: TMaskEdit
          Left = 467
          Top = 32
          Width = 149
          Height = 21
          EditMask = '999.999.999-99;0; '
          MaxLength = 14
          TabOrder = 2
          Text = ''
        end
      end
    end
  end
end
