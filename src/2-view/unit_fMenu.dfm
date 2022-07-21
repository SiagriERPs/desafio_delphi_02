object fMenu: TfMenu
  Left = 0
  Top = 0
  Caption = 'Desafio Delphi 02'
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
    Left = 8
    Top = 80
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      object CadastrodeClientes1: TMenuItem
        Caption = 'Cadastro de Clientes'
        OnClick = CadastrodeClientes1Click
      end
      object CadastrodeProdutos1: TMenuItem
        Caption = 'Cadastro de Produtos'
        OnClick = CadastrodeProdutos1Click
      end
    end
    object Venda1: TMenuItem
      Caption = 'Venda'
      object Pedido1: TMenuItem
        Caption = 'Pedido'
        OnClick = Pedido1Click
      end
      object Receita1: TMenuItem
        Caption = 'Receita'
        OnClick = Receita1Click
      end
    end
  end
end
