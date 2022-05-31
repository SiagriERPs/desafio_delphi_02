inherited FormProdutoPesquisa: TFormProdutoPesquisa
  Caption = 'Pesquisar Produto'
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  inherited Grid: TDBGrid
    DataSource = DsGrid
    OnDblClick = GridDblClick
    OnKeyPress = GridKeyPress
  end
  inherited GroupBoxPesquisa: TGroupBox
    ExplicitLeft = 0
    ExplicitWidth = 519
    inherited LabelPesquisa: TLabel
      Width = 515
    end
  end
end
