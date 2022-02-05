inherited frmSolicitacaoReceita: TfrmSolicitacaoReceita
  Caption = 'Solicita'#231#227'o de Receita'
  ClientHeight = 572
  ClientWidth = 807
  Constraints.MaxHeight = 0
  Constraints.MaxWidth = 0
  ExplicitTop = -55
  ExplicitWidth = 813
  ExplicitHeight = 601
  PixelsPerInch = 96
  TextHeight = 13
  inherited Label1: TLabel
    Width = 51
    Caption = 'Nr'#186' Pedido'
    ExplicitWidth = 51
  end
  inherited Label4: TLabel
    Left = 112
    ExplicitLeft = 112
  end
  object Label2: TLabel [2]
    Left = 699
    Top = 10
    Width = 62
    Height = 13
    Caption = 'Dt. Cadastro'
    FocusControl = DBEdit1
  end
  object Label3: TLabel [3]
    Left = 596
    Top = 50
    Width = 19
    Height = 13
    Caption = 'CPF'
    FocusControl = DBEdit2
  end
  object Label5: TLabel [4]
    Left = 10
    Top = 50
    Width = 59
    Height = 13
    Caption = 'C'#243'd. Cliente'
    FocusControl = DBEdit3
  end
  object Label6: TLabel [5]
    Left = 10
    Top = 546
    Width = 78
    Height = 13
    Caption = 'Total do Pedido:'
    FocusControl = DBEdit4
  end
  object Label7: TLabel [6]
    Left = 10
    Top = 92
    Width = 65
    Height = 13
    Caption = 'T'#233'cnico ( F5 )'
    FocusControl = edtCodTecnico
  end
  object Label8: TLabel [7]
    Left = 112
    Top = 92
    Width = 27
    Height = 13
    Caption = 'Nome'
    FocusControl = DBEdit6
  end
  object Label9: TLabel [8]
    Left = 596
    Top = 92
    Width = 19
    Height = 13
    Caption = 'CPF'
    FocusControl = DBEdit7
  end
  object Label10: TLabel [9]
    Left = 699
    Top = 92
    Width = 59
    Height = 13
    Caption = 'Nr'#186' Registro'
    FocusControl = DBEdit8
  end
  object Label11: TLabel [10]
    Left = 10
    Top = 140
    Width = 37
    Height = 13
    Caption = 'Pedidos'
    FocusControl = edtCodTecnico
  end
  object Label12: TLabel [11]
    Left = 10
    Top = 318
    Width = 72
    Height = 13
    Caption = 'Itens/Produtos'
    FocusControl = edtCodTecnico
  end
  inherited btnSalvar: TButton
    Left = 619
    Top = 537
    TabOrder = 11
    ExplicitLeft = 619
    ExplicitTop = 537
  end
  inherited btnCancelar: TButton
    Left = 712
    Top = 537
    TabOrder = 12
    ExplicitLeft = 712
    ExplicitTop = 537
  end
  inherited edtCodigo: TDBEdit
    DataField = 'PEDI_ID'
  end
  inherited edtNome: TDBEdit
    Left = 112
    Width = 480
    TabStop = False
    DataField = 'PEDI_CLIE_NOME'
    ReadOnly = True
    TabOrder = 5
    ExplicitLeft = 112
    ExplicitWidth = 480
  end
  inherited DBGrid2: TDBGrid
    Top = 156
    Width = 790
    Height = 154
    TabStop = False
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 9
  end
  inherited btnNovo: TButton
    Left = 520
    Top = 537
    Enabled = False
    TabOrder = 13
    Visible = False
    ExplicitLeft = 520
    ExplicitTop = 537
  end
  object DBEdit1: TDBEdit [18]
    Left = 699
    Top = 26
    Width = 100
    Height = 21
    TabStop = False
    DataField = 'PEDI_DT_CADASTRO'
    DataSource = dsTabela
    ReadOnly = True
    TabOrder = 1
  end
  object DBEdit2: TDBEdit [19]
    Left = 596
    Top = 66
    Width = 100
    Height = 21
    TabStop = False
    DataField = 'PEDI_CLIE_CPF'
    DataSource = dsTabela
    ReadOnly = True
    TabOrder = 2
  end
  object DBEdit3: TDBEdit [20]
    Left = 10
    Top = 66
    Width = 100
    Height = 21
    TabStop = False
    DataField = 'PEDI_CLIE_ID'
    DataSource = dsTabela
    ReadOnly = True
    TabOrder = 4
  end
  object DBEdit4: TDBEdit [21]
    Left = 91
    Top = 542
    Width = 100
    Height = 21
    DataField = 'PEDI_TOTAL'
    DataSource = dsTabela
    TabOrder = 14
  end
  object edtCodTecnico: TDBEdit [22]
    Tag = 3
    Left = 10
    Top = 108
    Width = 100
    Height = 21
    DataField = 'PEDI_TECN_ID'
    DataSource = dsTabela
    TabOrder = 3
    OnExit = edtCodTecnicoExit
  end
  object DBEdit6: TDBEdit [23]
    Left = 112
    Top = 108
    Width = 480
    Height = 21
    TabStop = False
    DataField = 'PEDI_TECN_NOME'
    DataSource = dsTabela
    ReadOnly = True
    TabOrder = 6
  end
  object DBEdit7: TDBEdit [24]
    Left = 596
    Top = 108
    Width = 100
    Height = 21
    TabStop = False
    DataField = 'PEDI_TECN_CPF'
    DataSource = dsTabela
    ReadOnly = True
    TabOrder = 7
  end
  object DBEdit8: TDBEdit [25]
    Left = 699
    Top = 108
    Width = 100
    Height = 21
    TabStop = False
    DataField = 'PEDI_TECN_NR_REGISTRO'
    DataSource = dsTabela
    ReadOnly = True
    TabOrder = 8
  end
  object DBGrid1: TDBGrid [26]
    Left = 9
    Top = 334
    Width = 790
    Height = 197
    TabStop = False
    DataSource = dsItens
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 10
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  inherited qryTabela: TFDQuery
    AfterScroll = qryTabelaAfterScroll
    object qryTabelaPEDI_ID: TIntegerField
      DisplayLabel = 'Pedido Nr'#186
      FieldName = 'PEDI_ID'
      Origin = 'PEDI_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryTabelaPEDI_CLIE_ID: TIntegerField
      DisplayLabel = 'C'#243'd. Cliente'
      FieldName = 'PEDI_CLIE_ID'
      Origin = 'PEDI_CLIE_ID'
      ProviderFlags = []
    end
    object qryTabelaPEDI_CLIE_NOME: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 65
      FieldName = 'PEDI_CLIE_NOME'
      Origin = 'PEDI_CLIE_NOME'
      ProviderFlags = []
      Size = 80
    end
    object qryTabelaPEDI_STATUS: TStringField
      DisplayLabel = 'Status'
      FieldName = 'PEDI_STATUS'
      Origin = 'PEDI_STATUS'
      FixedChar = True
      Size = 1
    end
    object qryTabelaPEDI_TOTAL: TBCDField
      DisplayLabel = 'Total Pedido'
      FieldName = 'PEDI_TOTAL'
      Origin = 'PEDI_TOTAL'
      ProviderFlags = []
      currency = True
      Precision = 18
    end
    object qryTabelaPEDI_DT_CADASTRO: TDateField
      DisplayLabel = 'Dt. Cadastro'
      FieldName = 'PEDI_DT_CADASTRO'
      Origin = 'PEDI_DT_CADASTRO'
      ProviderFlags = []
    end
    object qryTabelaPEDI_CLIE_CPF: TStringField
      DisplayLabel = 'CPF'
      FieldName = 'PEDI_CLIE_CPF'
      Origin = 'PEDI_CLIE_CPF'
      ProviderFlags = []
      Visible = False
      Size = 14
    end
    object qryTabelaPEDI_ASSINADO: TStringField
      DisplayLabel = 'Assinado'
      FieldName = 'PEDI_ASSINADO'
      Origin = 'PEDI_ASSINADO'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryTabelaPEDI_TECN_ID: TIntegerField
      DisplayLabel = 'C'#243'd. T'#233'cnico'
      FieldName = 'PEDI_TECN_ID'
      Origin = 'PEDI_TECN_ID'
      Visible = False
    end
    object qryTabelaPEDI_TECN_NOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'PEDI_TECN_NOME'
      Origin = 'PEDI_TECN_NOME'
      ProviderFlags = []
      Visible = False
      Size = 80
    end
    object qryTabelaPEDI_TECN_CPF: TStringField
      DisplayLabel = 'CPF'
      FieldName = 'PEDI_TECN_CPF'
      Origin = 'PEDI_TECN_CPF'
      ProviderFlags = []
      Visible = False
      Size = 14
    end
    object qryTabelaPEDI_TECN_NR_REGISTRO: TStringField
      DisplayLabel = 'Nr'#186' Registro'
      FieldName = 'PEDI_TECN_NR_REGISTRO'
      Origin = 'PEDI_TECN_NR_REGISTRO'
      ProviderFlags = []
      Visible = False
      Size = 25
    end
  end
  object qryItens: TFDQuery
    CachedUpdates = True
    MasterSource = dsTabela
    Connection = dmDados.Conexao
    FetchOptions.AssignedValues = [evLiveWindowParanoic, evDetailCascade]
    FetchOptions.LiveWindowParanoic = False
    SQL.Strings = (
      'SELECT * FROM ITENSPEDIDO WHERE ITEM_PEDI_ID = :PEDI_ID')
    Left = 384
    Top = 352
    ParamData = <
      item
        Name = 'PEDI_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryItensITEM_ID: TIntegerField
      DisplayLabel = 'Nr'#186
      FieldName = 'ITEM_ID'
      Origin = 'ITEM_ID'
      ProviderFlags = []
      Visible = False
    end
    object qryItensITEM_PEDI_ID: TIntegerField
      DisplayLabel = 'Pedido'
      FieldName = 'ITEM_PEDI_ID'
      Origin = 'ITEM_PEDI_ID'
      ProviderFlags = []
      Visible = False
    end
    object qryItensITEM_PROD_ID: TIntegerField
      DisplayLabel = 'C'#243'd. Prod'
      FieldName = 'ITEM_PROD_ID'
      Origin = 'ITEM_PROD_ID'
      ProviderFlags = []
    end
    object qryItensITEM_PROD_NOME: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 65
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
      ProviderFlags = []
      Precision = 18
      Size = 2
    end
    object qryItensITEM_VLRUNIT: TFMTBCDField
      DisplayLabel = 'Vlr. Unit.'
      DisplayWidth = 13
      FieldName = 'ITEM_VLRUNIT'
      Origin = 'ITEM_VLRUNIT'
      ProviderFlags = []
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
      currency = True
      Precision = 18
    end
    object qryItensTOTAL_ITEM: TCurrencyField
      DisplayLabel = 'Total Item'
      FieldKind = fkCalculated
      FieldName = 'TOTAL_ITEM'
      ProviderFlags = []
      Visible = False
      Calculated = True
    end
  end
  object dsItens: TDataSource
    DataSet = qryItens
    OnDataChange = dsTabelaDataChange
    Left = 384
    Top = 400
  end
end
