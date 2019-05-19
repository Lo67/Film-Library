object frmFilmBase: TfrmFilmBase
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lvFilmTab: TListView
    Left = 0
    Top = 0
    Width = 665
    Height = 465
    Align = alLeft
    Columns = <
      item
        Caption = #8470
        MaxWidth = 28
        MinWidth = 28
        Width = 28
      end
      item
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        MaxWidth = 500
        MinWidth = 100
        Width = 120
      end
      item
        Caption = #1043#1086#1076
        MaxWidth = 75
        MinWidth = 75
        Width = 75
      end
      item
        Caption = #1057#1090#1088#1072#1085#1072
        MaxWidth = 200
        MinWidth = 100
        Width = 100
      end
      item
        Caption = #1056#1077#1078#1080#1089#1089#1105#1088
        MaxWidth = 200
        MinWidth = 90
        Width = 90
      end
      item
        Caption = #1046#1072#1085#1088
        MaxWidth = 150
        MinWidth = 90
        Width = 90
      end
      item
        Caption = #1044#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100
        MaxWidth = 110
        MinWidth = 80
        Width = 110
      end
      item
        Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1085#1086
        MaxWidth = 40
        MinWidth = 30
        Width = 40
      end
      item
        Caption = #1056#1077#1081#1090#1080#1085#1075
        MaxWidth = 75
        MinWidth = 60
        Width = 75
      end>
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object btnSelect: TButton
    Left = 696
    Top = 24
    Width = 129
    Height = 41
    Caption = #1042#1099#1073#1088#1072#1090#1100' '#1092#1080#1083#1100#1084#1099
    TabOrder = 1
  end
  object btnAdd: TButton
    Left = 696
    Top = 80
    Width = 129
    Height = 41
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 2
    OnClick = btnAddClick
  end
  object btnEdit: TButton
    Left = 696
    Top = 136
    Width = 129
    Height = 41
    Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
    TabOrder = 3
    OnClick = btnEditClick
  end
  object btnDelete: TButton
    Left = 696
    Top = 192
    Width = 129
    Height = 41
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 4
  end
  object btnReport: TButton
    Left = 696
    Top = 248
    Width = 129
    Height = 41
    Caption = #1054#1090#1095#1105#1090
    TabOrder = 5
  end
  object btnSearch: TButton
    Left = 696
    Top = 304
    Width = 129
    Height = 41
    Caption = #1055#1086#1080#1089#1082
    TabOrder = 6
  end
  object btnMenu: TButton
    Left = 696
    Top = 400
    Width = 129
    Height = 41
    Caption = #1052#1077#1085#1102
    TabOrder = 7
  end
end
