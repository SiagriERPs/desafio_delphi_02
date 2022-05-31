object FMenu: TFMenu
  Left = 0
  Top = 0
  Caption = 'Sistema Aliare'
  ClientHeight = 201
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 192
    Top = 112
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Clientes1: TMenuItem
        Caption = 'Clientes'
        OnClick = Clientes1Click
      end
      object Produtos1: TMenuItem
        Caption = 'Produtos'
        OnClick = Produtos1Click
      end
    end
    object Vendas1: TMenuItem
      Caption = 'Comercial'
      object Vendas2: TMenuItem
        Caption = 'Vendas'
        OnClick = Vendas2Click
      end
    end
    object Conferncia1: TMenuItem
      Caption = 'Confer'#234'ncia'
      object VendascomsolicitaodeReceita1: TMenuItem
        Caption = 'Vendas com solicita'#231#227'o de Receita'
        OnClick = VendascomsolicitaodeReceita1Click
      end
    end
  end
end
