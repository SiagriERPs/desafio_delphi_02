inherited frmVendas: TfrmVendas
  Caption = 'Vendas'
  ClientHeight = 470
  ClientWidth = 700
  Constraints.MaxHeight = 0
  Constraints.MaxWidth = 0
  Constraints.MinHeight = 0
  Constraints.MinWidth = 0
  OnCreate = FormCreate
  ExplicitWidth = 706
  ExplicitHeight = 499
  PixelsPerInch = 96
  TextHeight = 13
  inherited Label4: TLabel
    Left = 114
    Width = 61
    Caption = 'Nome/Raz'#227'o'
    ExplicitLeft = 114
    ExplicitWidth = 61
  end
  object Label2: TLabel [2]
    Left = 10
    Top = 50
    Width = 33
    Height = 13
    Caption = 'Cliente'
  end
  object Label3: TLabel [3]
    Left = 592
    Top = 10
    Width = 62
    Height = 13
    Caption = 'Dt. Cadastro'
    FocusControl = DBEdit2
  end
  object Label5: TLabel [4]
    Left = 507
    Top = 50
    Width = 48
    Height = 13
    Caption = 'CPF/CNPJ'
    FocusControl = DBEdit3
  end
  inherited btnSalvar: TButton
    Left = 511
    Top = 433
    ExplicitLeft = 511
    ExplicitTop = 433
  end
  inherited btnCancelar: TButton
    Left = 602
    Top = 433
    ExplicitLeft = 602
    ExplicitTop = 433
  end
  inherited edtCodigo: TDBEdit
    DataField = 'PEDI_ID'
  end
  inherited edtNome: TDBEdit
    Left = 114
    TabStop = False
    DataField = 'PEDI_CLIE_NOME'
    ReadOnly = True
    ExplicitLeft = 114
  end
  inherited DBGrid2: TDBGrid
    Top = 167
    Width = 682
    Height = 262
    DataSource = dsItens
    OnEnter = DBGrid2Enter
  end
  inherited btnNovo: TButton
    Left = 420
    Top = 433
    ExplicitLeft = 420
    ExplicitTop = 433
  end
  object edtCodCliente: TDBEdit [11]
    Left = 10
    Top = 66
    Width = 100
    Height = 21
    DataField = 'PEDI_CLIE_ID'
    DataSource = dsTabela
    TabOrder = 6
    OnExit = edtCodClienteExit
  end
  object DBEdit2: TDBEdit [12]
    Left = 592
    Top = 26
    Width = 100
    Height = 21
    TabStop = False
    DataField = 'PEDI_DT_CADASTRO'
    DataSource = dsTabela
    ReadOnly = True
    TabOrder = 7
  end
  object DBEdit3: TDBEdit [13]
    Left = 507
    Top = 67
    Width = 186
    Height = 21
    TabStop = False
    DataField = 'PEDI_CLIE_CPF'
    DataSource = dsTabela
    ReadOnly = True
    TabOrder = 8
  end
  object Itens: TGroupBox [14]
    Left = 10
    Top = 93
    Width = 682
    Height = 68
    Caption = 'Itens'
    TabOrder = 9
    object Label6: TLabel
      Left = 6
      Top = 16
      Width = 48
      Height = 13
      Caption = 'C'#243'd. Prod'
      FocusControl = edtCodItem
    end
    object Label7: TLabel
      Left = 108
      Top = 16
      Width = 38
      Height = 13
      Caption = 'Produto'
      FocusControl = edtNomeItem
    end
    object Label9: TLabel
      Left = 404
      Top = 16
      Width = 36
      Height = 13
      Caption = 'Qtdade'
      FocusControl = edtQtdade
    end
    object Label10: TLabel
      Left = 506
      Top = 16
      Width = 42
      Height = 13
      Caption = 'Vlr. Unit.'
      FocusControl = edtValor
    end
    object edtCodItem: TDBEdit
      Left = 6
      Top = 32
      Width = 100
      Height = 21
      DataField = 'ITEM_PROD_ID'
      DataSource = dsItens
      TabOrder = 0
      OnExit = edtCodItemExit
    end
    object edtNomeItem: TDBEdit
      Left = 108
      Top = 32
      Width = 293
      Height = 21
      TabStop = False
      DataField = 'ITEM_PROD_NOME'
      DataSource = dsItens
      ReadOnly = True
      TabOrder = 1
    end
    object edtQtdade: TDBEdit
      Left = 404
      Top = 32
      Width = 100
      Height = 21
      DataField = 'ITEM_QTDADE'
      DataSource = dsItens
      TabOrder = 2
    end
    object edtValor: TDBEdit
      Left = 506
      Top = 32
      Width = 100
      Height = 21
      DataField = 'ITEM_VLRUNIT'
      DataSource = dsItens
      TabOrder = 3
    end
    object btnRetira: TButton
      Left = 642
      Top = 32
      Width = 35
      Height = 21
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
    end
    object btnAdiciona: TButton
      Left = 607
      Top = 32
      Width = 35
      Height = 21
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = btnAdicionaClick
    end
  end
  object qryItens: TFDQuery [15]
    AfterInsert = qryItensAfterInsert
    OnCalcFields = qryItensCalcFields
    CachedUpdates = True
    Connection = dmDados.Conexao
    FetchOptions.AssignedValues = [evLiveWindowParanoic, evDetailCascade]
    FetchOptions.LiveWindowParanoic = False
    SQL.Strings = (
      'SELECT * FROM ITENSPEDIDO WHERE ITEM_PEDI_ID = :PEDI_ID')
    Left = 384
    Top = 232
    ParamData = <
      item
        Name = 'PEDI_ID'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptInput
        Value = Null
      end>
    object qryItensITEM_ID: TIntegerField
      DisplayLabel = 'Nr'#186
      FieldName = 'ITEM_ID'
      Origin = 'ITEM_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object qryItensITEM_PEDI_ID: TIntegerField
      DisplayLabel = 'Pedido'
      FieldName = 'ITEM_PEDI_ID'
      Origin = 'ITEM_PEDI_ID'
      Required = True
      Visible = False
    end
    object qryItensITEM_PROD_ID: TIntegerField
      DisplayLabel = 'C'#243'd. Prod'
      FieldName = 'ITEM_PROD_ID'
      Origin = 'ITEM_PROD_ID'
      Required = True
    end
    object qryItensITEM_PROD_NOME: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 50
      FieldName = 'ITEM_PROD_NOME'
      Origin = 'ITEM_PROD_NOME'
      ProviderFlags = []
      Size = 80
    end
    object qryItensITEM_PROD_CONTROLE: TStringField
      DisplayLabel = 'Controle'
      FieldName = 'ITEM_PROD_CONTROLE'
      Origin = 'ITEM_PROD_CONTROLE'
      ProviderFlags = []
      FixedChar = True
      Size = 1
    end
    object qryItensITEM_QTDADE: TFMTBCDField
      DisplayLabel = 'Qtdade'
      DisplayWidth = 13
      FieldName = 'ITEM_QTDADE'
      Origin = 'ITEM_QTDADE'
      Required = True
      Precision = 18
      Size = 2
    end
    object qryItensITEM_VLRUNIT: TFMTBCDField
      DisplayLabel = 'Vlr. Unit.'
      DisplayWidth = 13
      FieldName = 'ITEM_VLRUNIT'
      Origin = 'ITEM_VLRUNIT'
      Required = True
      currency = True
      Precision = 18
      Size = 2
    end
    object qryItensITEM_TOTAL: TBCDField
      DisplayLabel = 'Total Item'
      DisplayWidth = 13
      FieldName = 'ITEM_TOTAL'
      Origin = 'ITEM_TOTAL'
      ProviderFlags = []
      Visible = False
      currency = True
      Precision = 18
    end
    object qryItensTOTAL_ITEM: TCurrencyField
      DisplayLabel = 'Total Item'
      FieldKind = fkCalculated
      FieldName = 'TOTAL_ITEM'
      ProviderFlags = []
      Calculated = True
    end
  end
  object dsItens: TDataSource [16]
    DataSet = qryItens
    OnDataChange = dsTabelaDataChange
    Left = 384
    Top = 280
  end
  inherited dsTabela: TDataSource
    Left = 323
    Top = 280
  end
  inherited qryTabela: TFDQuery
    BeforeOpen = qryTabelaBeforeOpen
    AfterApplyUpdates = qryTabelaAfterApplyUpdates
    SQL.Strings = (
      'SELECT * FROM PEDIDOS')
    Left = 320
    Top = 232
    object qryTabelaPEDI_ID: TIntegerField
      FieldName = 'PEDI_ID'
      Origin = 'PEDI_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryTabelaPEDI_CLIE_ID: TIntegerField
      FieldName = 'PEDI_CLIE_ID'
      Origin = 'PEDI_CLIE_ID'
      Required = True
    end
    object qryTabelaPEDI_TOTAL: TBCDField
      FieldName = 'PEDI_TOTAL'
      Origin = 'PEDI_TOTAL'
      ProviderFlags = []
      Precision = 18
    end
    object qryTabelaPEDI_DT_CADASTRO: TDateField
      FieldName = 'PEDI_DT_CADASTRO'
      Origin = 'PEDI_DT_CADASTRO'
    end
    object qryTabelaPEDI_CLIE_NOME: TStringField
      FieldName = 'PEDI_CLIE_NOME'
      Origin = 'PEDI_CLIE_NOME'
      ProviderFlags = []
      Size = 80
    end
    object qryTabelaPEDI_CLIE_CPF: TStringField
      FieldName = 'PEDI_CLIE_CPF'
      Origin = 'PEDI_CLIE_CPF'
      ProviderFlags = []
      Size = 14
    end
    object qryTabelaPEDI_STATUS: TStringField
      FieldName = 'PEDI_STATUS'
      Origin = 'PEDI_STATUS'
      FixedChar = True
      Size = 1
    end
  end
end
