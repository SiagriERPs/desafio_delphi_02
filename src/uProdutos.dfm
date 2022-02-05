inherited frmProdutos: TfrmProdutos
  Caption = 'Cadastro de Produtos'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel [1]
    Left = 16
    Top = 64
    Width = 27
    Height = 13
    Caption = 'Nome'
    FocusControl = edtNome
  end
  object Label3: TLabel [2]
    Left = 398
    Top = 50
    Width = 24
    Height = 13
    Caption = 'Valor'
    FocusControl = edtValor
  end
  inherited btnSalvar: TButton
    TabOrder = 4
  end
  inherited btnCancelar: TButton
    TabOrder = 5
  end
  inherited edtCodigo: TDBEdit
    DataField = 'PROD_ID'
  end
  object edtValor: TDBEdit [7]
    Left = 398
    Top = 66
    Width = 103
    Height = 21
    DataField = 'PROD_VALOR'
    DataSource = dsTabela
    TabOrder = 3
  end
  object DBCheckBox1: TDBCheckBox [8]
    Left = 120
    Top = 30
    Width = 97
    Height = 17
    Caption = 'Controle'
    DataField = 'PROD_CONTROLE'
    DataSource = dsTabela
    TabOrder = 1
    ValueChecked = 'S'
    ValueUnchecked = 'N'
  end
  inherited edtNome: TDBEdit
    DataField = 'PROD_NOME'
    TabOrder = 2
  end
  inherited DBGrid2: TDBGrid
    TabOrder = 6
  end
  inherited btnNovo: TButton
    TabOrder = 7
  end
  inherited qryTabela: TFDQuery
    object qryTabelaPROD_ID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'PROD_ID'
      Origin = 'PROD_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryTabelaPROD_NOME: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 60
      FieldName = 'PROD_NOME'
      Origin = 'PROD_NOME'
      Size = 80
    end
    object qryTabelaPROD_VALOR: TFMTBCDField
      DisplayLabel = 'Valor'
      DisplayWidth = 12
      FieldName = 'PROD_VALOR'
      Origin = 'PROD_VALOR'
      currency = True
      Precision = 18
      Size = 2
    end
    object qryTabelaPROD_CONTROLE: TStringField
      DisplayLabel = 'Controle'
      FieldName = 'PROD_CONTROLE'
      Origin = 'PROD_CONTROLE'
      FixedChar = True
      Size = 1
    end
  end
end
