inherited FormVendaDetalhe: TFormVendaDetalhe
  Caption = 'Itens da Venda'
  ClientHeight = 229
  ClientWidth = 499
  OnCreate = FormCreate
  ExplicitWidth = 515
  ExplicitHeight = 268
  PixelsPerInch = 96
  TextHeight = 13
  inherited GroupBoxDados: TGroupBox
    Width = 499
    Height = 185
    ExplicitWidth = 499
    ExplicitHeight = 185
    object Label1: TLabel
      Left = 11
      Top = 21
      Width = 38
      Height = 13
      Caption = 'Produto'
    end
    object Label2: TLabel
      Left = 167
      Top = 77
      Width = 64
      Height = 13
      Caption = 'Valor Unit'#225'rio'
    end
    object Label3: TLabel
      Left = 11
      Top = 77
      Width = 56
      Height = 13
      Caption = 'Quantidade'
    end
    object Label4: TLabel
      Left = 323
      Top = 77
      Width = 51
      Height = 13
      Caption = 'Valor Total'
    end
    object DBEditIdProduto: TDBEdit
      Left = 11
      Top = 40
      Width = 56
      Height = 21
      DataField = 'ID_PRODUTO'
      DataSource = FormVenda.DSVendaDetalhe
      ReadOnly = True
      TabOrder = 0
    end
    object DBEditValorUnitario: TDBEdit
      Left = 167
      Top = 96
      Width = 150
      Height = 21
      DataField = 'VALOR_UNITARIO'
      DataSource = FormVenda.DSVendaDetalhe
      ReadOnly = True
      TabOrder = 4
      OnChange = DBEditValorUnitarioChange
    end
    object DBEditQuantidade: TDBEdit
      Left = 11
      Top = 96
      Width = 150
      Height = 21
      DataField = 'QUANTIDADE'
      DataSource = FormVenda.DSVendaDetalhe
      TabOrder = 3
      OnChange = DBEditQuantidadeChange
      OnExit = DBEditQuantidadeExit
    end
    object DBEditValorTotal: TDBEdit
      Left = 323
      Top = 96
      Width = 150
      Height = 21
      DataField = 'VALOR_TOTAL'
      DataSource = FormVenda.DSVendaDetalhe
      ReadOnly = True
      TabOrder = 5
    end
    object PesquisaProduto: TSearchBox
      Left = 432
      Top = 40
      Width = 41
      Height = 21
      ReadOnly = True
      TabOrder = 2
      Text = 'PesquisaProduto'
      OnInvokeSearch = PesquisaProdutoInvokeSearch
    end
    object DBEditProdutoNome: TDBEdit
      Left = 68
      Top = 40
      Width = 380
      Height = 21
      DataField = 'PRODUTONOME'
      DataSource = FormVenda.DSVendaDetalhe
      TabOrder = 1
    end
    object DBCheckBoxControleEspecial: TDBCheckBox
      Left = 11
      Top = 144
      Width = 150
      Height = 17
      Caption = 'Exige Receita'
      DataField = 'CONTROLE_ESPECIAL'
      DataSource = FormVenda.DSVendaDetalhe
      ReadOnly = True
      TabOrder = 6
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  inherited BotaoConcluir: TBitBtn
    Left = 40
    Top = 192
    OnClick = BotaoConcluirClick
    ExplicitLeft = 40
    ExplicitTop = 192
  end
  inherited BotaoVoltar: TBitBtn
    Left = 247
    Top = 192
    OnClick = BotaoVoltarClick
    ExplicitLeft = 247
    ExplicitTop = 192
  end
end
