inherited fProduto: TfProduto
  Caption = 'fProduto'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl_cabecalho: TPanel
    inherited img: TImage
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000280000
        002808060000008CFEB86D00000006624B474400FF00FF00FFA0BDA793000000
        D34944415478DA636418E48071A01D307C1C38ADCAE5FF403B061964B5ED61C4
        70607C88E340BB0B0C16AED93FEA40DA3870A01D860C301C0873E440872272E8
        8D3A70C01DB87DFF3986576F3FE255232ECCCFE0E16834300EDC0174E04B420E
        141160F070301C1807D2028C3A70D481A30E1C75E0A803471D38EA40EA3BF0E7
        1F06861567D818224C7E31B0B3E0161B30072E3FCDC670EA010B8399C21F8648
        D35F38C506CC812050B89A8BA13FF41B41B151078E3A70441633A090C2079043
        713404471D38A0AE83029C0E1C8C60D4819402005E572238F1AD66C400000000
        49454E44AE426082}
    end
    inherited lb_titulo: TLabel
      Width = 178
      Caption = 'Cadastro De Produtos'
      ExplicitWidth = 178
    end
  end
  inherited pgc_principal: TPageControl
    inherited ts_lista: TTabSheet
      inherited pnl_pesquisa: TPanel
        inherited Label2: TLabel
          Width = 123
          Caption = 'Informe nome do Produto'
          ExplicitWidth = 123
        end
      end
    end
    inherited ts_informacoes: TTabSheet
      inherited pnl_corpo_info: TPanel
        object Label3: TLabel
          Left = 438
          Top = 52
          Width = 96
          Height = 13
          Caption = 'Controle Especial'
        end
        object edt_id: TLabeledEdit
          Left = 5
          Top = 16
          Width = 121
          Height = 21
          TabStop = False
          Color = cl3DLight
          EditLabel.Width = 19
          EditLabel.Height = 13
          EditLabel.Caption = 'Id*'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
        object edt_nome: TLabeledEdit
          Left = 5
          Top = 67
          Width = 340
          Height = 21
          CharCase = ecUpperCase
          EditLabel.Width = 39
          EditLabel.Height = 13
          EditLabel.Caption = 'Nome*'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object edt_valor: TLabeledEdit
          Left = 351
          Top = 67
          Width = 81
          Height = 21
          CharCase = ecUpperCase
          EditLabel.Width = 36
          EditLabel.Height = 13
          EditLabel.Caption = 'Valor*'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnKeyPress = edt_valorKeyPress
        end
        object cb_especial: TComboBox
          Left = 438
          Top = 67
          Width = 97
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 3
          Text = 'N'#227'o'
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
      end
    end
  end
end
