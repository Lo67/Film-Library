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
    Width = 674
    Height = 465
    Align = alLeft
    Columns = <
      item
        Caption = #8470'    '
        MaxWidth = 50
        MinWidth = 46
        Width = 46
      end
      item
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        MaxWidth = 500
        MinWidth = 100
        Width = 120
      end
      item
        Caption = #1043#1086#1076
        MaxWidth = 70
        MinWidth = 70
        Width = 70
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
        MinWidth = 75
        Width = 75
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
    GridLines = True
    RowSelect = True
    SortType = stText
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = lvFilmTabOnClick
    OnColumnClick = lvFilmTabColumnClick
    OnCompare = lvFilmTabCompare
    OnDblClick = ShowFilmInfo
    OnItemChecked = lvFilmTabItemChecked
  end
  object btnSelect: TButton
    Left = 699
    Top = 25
    Width = 126
    Height = 41
    Caption = #1042#1099#1073#1088#1072#1090#1100' '#1092#1080#1083#1100#1084#1099
    TabOrder = 1
    OnClick = btnSelectClick
  end
  object btnAdd: TButton
    Left = 699
    Top = 81
    Width = 126
    Height = 41
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 2
    OnClick = btnAddClick
  end
  object btnEdit: TButton
    Left = 699
    Top = 137
    Width = 126
    Height = 41
    Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
    TabOrder = 3
    OnClick = btnEditClick
  end
  object btnDelete: TButton
    Left = 699
    Top = 193
    Width = 126
    Height = 41
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 4
    OnClick = btnDeleteClick
  end
  object btnReport: TButton
    Left = 699
    Top = 249
    Width = 126
    Height = 41
    Caption = #1054#1090#1095#1105#1090
    TabOrder = 5
    OnClick = btnReportClick
  end
  object btnSearch: TButton
    Left = 699
    Top = 305
    Width = 126
    Height = 41
    Caption = #1055#1086#1080#1089#1082
    TabOrder = 6
    OnClick = btnSearchClick
  end
  object btnMenu: TButton
    Left = 699
    Top = 401
    Width = 126
    Height = 41
    Caption = #1052#1077#1085#1102
    TabOrder = 7
    OnClick = btnMenuClick
  end
  object pnlSearch: TPanel
    Left = 664
    Top = 0
    Width = 180
    Height = 465
    Align = alRight
    TabOrder = 8
    Visible = False
    object lblHint1: TLabel
      Left = 16
      Top = 24
      Width = 87
      Height = 13
      Caption = #1050#1088#1080#1090#1077#1088#1080#1081' '#1087#1086#1080#1089#1082#1072
    end
    object lblHint2: TLabel
      Left = 16
      Top = 93
      Width = 30
      Height = 13
      Caption = #1055#1086#1080#1089#1082
    end
    object cmbbxSearchCriteria: TComboBox
      Left = 16
      Top = 53
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      Items.Strings = (
        #1087#1086' '#1085#1072#1079#1074#1072#1085#1080#1102' '
        #1087#1086' '#1075#1086#1076#1091
        #1087#1086' '#1089#1090#1088#1072#1085#1077
        #1087#1086' '#1088#1077#1078#1080#1089#1089#1077#1088#1091
        #1087#1086' '#1082#1083#1102#1095#1077#1074#1099#1084' '#1089#1083#1086#1074#1072#1084
        #1087#1086' '#1076#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1080)
    end
    object edtSearch: TEdit
      Left = 16
      Top = 127
      Width = 145
      Height = 21
      TabOrder = 1
    end
    object btnSearchFilm: TButton
      Left = 48
      Top = 183
      Width = 81
      Height = 26
      Caption = #1053#1072#1081#1090#1080
      TabOrder = 2
      OnClick = btnSearchFilmClick
    end
    object btnBack: TButton
      Left = 48
      Top = 392
      Width = 81
      Height = 25
      Caption = #1053#1072#1079#1072#1076
      TabOrder = 3
      OnClick = btnBackClick
    end
  end
  object SaveReport: TSaveTextFileDialog
    Filter = 'Text file (*.txt)|*.txt'
    Left = 424
    Top = 248
  end
end
