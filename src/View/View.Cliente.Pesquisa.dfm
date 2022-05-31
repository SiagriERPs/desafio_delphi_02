inherited FormClientePesquisa: TFormClientePesquisa
  Caption = 'Pesquisa Cliente'
  ClientWidth = 885
  Position = poMainFormCenter
  ExplicitWidth = 901
  PixelsPerInch = 96
  TextHeight = 13
  inherited GroupBox1: TGroupBox
    Width = 885
    ExplicitWidth = 885
  end
  inherited Grid: TDBGrid
    Width = 885
    DataSource = DsGrid
    OnDblClick = GridDblClick
    OnKeyPress = GridKeyPress
  end
  inherited GroupBoxPesquisa: TGroupBox
    Width = 885
    ExplicitLeft = 0
    ExplicitWidth = 885
    inherited LabelPesquisa: TLabel
      Width = 881
    end
    inherited EditPesquisa: TEdit
      Width = 881
      ExplicitWidth = 881
    end
  end
end
