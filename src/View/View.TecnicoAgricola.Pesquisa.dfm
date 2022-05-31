inherited FormTecnicoAgricolaPesquisa: TFormTecnicoAgricolaPesquisa
  Caption = 'Pesquisa T'#233'cnico Agricola'
  ClientWidth = 763
  Position = poMainFormCenter
  ExplicitWidth = 779
  PixelsPerInch = 96
  TextHeight = 13
  inherited GroupBox1: TGroupBox
    Width = 763
    ExplicitWidth = 763
  end
  inherited Grid: TDBGrid
    Width = 763
    DataSource = DsGrid
    OnDblClick = GridDblClick
    OnKeyPress = GridKeyPress
  end
  inherited GroupBoxPesquisa: TGroupBox
    Width = 763
    ExplicitLeft = 0
    ExplicitWidth = 763
    inherited LabelPesquisa: TLabel
      Width = 759
    end
    inherited EditPesquisa: TEdit
      Width = 759
      ExplicitWidth = 759
    end
  end
end
