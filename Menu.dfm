object frmMenu: TfrmMenu
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize, biHelp]
  BorderStyle = bsSingle
  Caption = 'My Films Library'
  ClientHeight = 465
  ClientWidth = 844
  Color = clBtnFace
  Constraints.MaxHeight = 500
  Constraints.MaxWidth = 850
  Constraints.MinHeight = 500
  Constraints.MinWidth = 850
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object btnFilmBase: TButton
    Left = 312
    Top = 104
    Width = 233
    Height = 65
    Caption = #1060#1080#1083#1100#1084#1086#1090#1077#1082#1072
    TabOrder = 0
    OnClick = btnFilmBaseClick
  end
  object btnAboutProgram: TButton
    Left = 312
    Top = 200
    Width = 233
    Height = 65
    Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
    TabOrder = 1
  end
  object btnExit: TButton
    Left = 312
    Top = 297
    Width = 233
    Height = 65
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 2
    OnClick = btnExitClick
  end
end
