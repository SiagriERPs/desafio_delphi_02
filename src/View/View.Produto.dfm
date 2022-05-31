inherited FormProduto: TFormProduto
  Caption = 'Cadastro de Produtos'
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl1: TPageControl
    ActivePage = TsEdits
    inherited TsGrid: TTabSheet
      inherited PanelGrid: TPanel
        inherited Grid: TDBGrid
          OnDrawColumnCell = GridDrawColumnCell
        end
      end
    end
    inherited TsEdits: TTabSheet
      inherited PanelEdits: TPanel
        object LabelId: TLabel
          Left = 9
          Top = 13
          Width = 33
          Height = 13
          Caption = 'C'#243'digo'
        end
        object LabelNome: TLabel
          Left = 151
          Top = 13
          Width = 27
          Height = 13
          Caption = 'Nome'
        end
        object LabelCFP: TLabel
          Left = 9
          Top = 69
          Width = 24
          Height = 13
          Caption = 'Valor'
        end
        object EditId: TEdit
          Left = 9
          Top = 32
          Width = 121
          Height = 21
          Enabled = False
          TabOrder = 0
        end
        object EditNome: TEdit
          Left = 151
          Top = 32
          Width = 354
          Height = 21
          MaxLength = 100
          TabOrder = 1
        end
        object EditValor: TEdit
          Left = 9
          Top = 88
          Width = 121
          Height = 21
          MaxLength = 17
          TabOrder = 2
          OnChange = EditValorChange
        end
        object CheckBoxControleEspecial: TCheckBox
          Left = 152
          Top = 88
          Width = 345
          Height = 17
          Caption = 'Exige Controle Especial'
          TabOrder = 3
        end
      end
    end
  end
  inherited DsGrid: TDataSource
    Left = 356
    Top = 247
  end
end
