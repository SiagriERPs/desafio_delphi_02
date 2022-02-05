inherited frmClientes: TfrmClientes
  Caption = 'Cadastro de Clientes'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel [1]
    Left = 398
    Top = 52
    Width = 19
    Height = 13
    Caption = 'CPF'
  end
  inherited Label4: TLabel
    Left = 9
    Top = 52
    ExplicitLeft = 9
    ExplicitTop = 52
  end
  inherited btnSalvar: TButton
    Left = 505
    Top = 400
    TabOrder = 3
    ExplicitLeft = 505
    ExplicitTop = 400
  end
  inherited btnCancelar: TButton
    Left = 596
    Top = 400
    TabOrder = 4
    ExplicitLeft = 596
    ExplicitTop = 400
  end
  inherited edtCodigo: TDBEdit
    DataField = 'CLIE_ID'
  end
  object edtCPF: TDBEdit [6]
    Left = 398
    Top = 67
    Width = 169
    Height = 21
    DataField = 'CLIE_CPF'
    DataSource = dsTabela
    TabOrder = 2
  end
  inherited edtNome: TDBEdit
    Left = 9
    Top = 67
    DataField = 'CLIE_NOME'
    ExplicitLeft = 9
    ExplicitTop = 67
  end
  inherited DBGrid2: TDBGrid
    TabOrder = 5
  end
  inherited btnNovo: TButton
    Left = 415
    Top = 400
    TabOrder = 6
    ExplicitLeft = 415
    ExplicitTop = 400
  end
  inherited qryTabela: TFDQuery
    object qryTabelaCLIE_ID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CLIE_ID'
      Origin = 'CLIE_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryTabelaCLIE_NOME: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 65
      FieldName = 'CLIE_NOME'
      Origin = 'CLIE_NOME'
      Size = 80
    end
    object qryTabelaCLIE_CPF: TStringField
      DisplayLabel = 'CPF'
      FieldName = 'CLIE_CPF'
      Origin = 'CLIE_CPF'
      EditMask = '###.###.###-##;1;_'
      Size = 14
    end
  end
end
