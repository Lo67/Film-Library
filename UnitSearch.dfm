object frmSearch: TfrmSearch
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #1055#1086#1080#1089#1082
  ClientHeight = 353
  ClientWidth = 482
  Color = clBtnFace
  Constraints.MaxHeight = 400
  Constraints.MaxWidth = 500
  Constraints.MinHeight = 400
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object lblHint1: TLabel
    Left = 128
    Top = 48
    Width = 226
    Height = 19
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1082#1088#1080#1090#1077#1088#1080#1081' '#1087#1086#1080#1089#1082#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblHint2: TLabel
    Left = 152
    Top = 176
    Width = 34
    Height = 16
    Caption = #1055#1086#1080#1089#1082
  end
  object cmbbxSearchCriteria: TComboBox
    Left = 144
    Top = 96
    Width = 177
    Height = 24
    TabOrder = 0
    OnChange = cmbbxSearchCriteriaChange
    Items.Strings = (
      #1087#1086' '#1085#1072#1079#1074#1072#1085#1080#1102' '
      #1087#1086' '#1075#1086#1076#1091
      #1087#1086' '#1089#1090#1088#1072#1085#1077
      #1087#1086' '#1088#1077#1078#1080#1089#1089#1077#1088#1091
      #1087#1086' '#1082#1083#1102#1095#1077#1074#1099#1084' '#1089#1083#1086#1074#1072#1084
      #1087#1086' '#1076#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1080)
  end
  object edtSearch: TEdit
    Left = 144
    Top = 208
    Width = 177
    Height = 24
    MaxLength = 30
    TabOrder = 1
  end
  object btnOk: TButton
    Left = 96
    Top = 296
    Width = 75
    Height = 25
    Caption = #1054#1050
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 304
    Top = 296
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
  end
end
