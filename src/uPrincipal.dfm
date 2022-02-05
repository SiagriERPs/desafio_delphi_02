object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Receitu'#225'rio'
  ClientHeight = 495
  ClientWidth = 812
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  DesignSize = (
    812
    495)
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 86
    Top = 198
    Width = 200
    Height = 100
    Anchors = []
    Caption = 'Clientes'
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 306
    Top = 198
    Width = 200
    Height = 100
    Anchors = []
    Caption = 'Produtos'
    OnClick = SpeedButton2Click
  end
  object SpeedButton3: TSpeedButton
    Left = 526
    Top = 198
    Width = 200
    Height = 100
    Anchors = []
    Caption = 'Vendas'
    OnClick = SpeedButton3Click
  end
end
