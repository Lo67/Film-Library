object frmFeatures: TfrmFeatures
  Left = 544
  Top = 116
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1061#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080' '#1092#1080#1083#1100#1084#1072
  ClientHeight = 620
  ClientWidth = 444
  Color = clBtnFace
  Constraints.MaxHeight = 655
  Constraints.MaxWidth = 450
  Constraints.MinHeight = 655
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblTitel: TLabel
    Left = 24
    Top = 24
    Width = 48
    Height = 13
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077
  end
  object lblDirectorLastName: TLabel
    Left = 24
    Top = 80
    Width = 44
    Height = 13
    Caption = #1060#1080#1084#1080#1083#1080#1103
  end
  object lblDirectorName: TLabel
    Left = 24
    Top = 107
    Width = 19
    Height = 13
    Caption = #1048#1084#1103
  end
  object lblDirectorMiddleName: TLabel
    Left = 24
    Top = 134
    Width = 49
    Height = 13
    Caption = #1054#1090#1095#1077#1089#1090#1074#1086
  end
  object lblGenre: TLabel
    Left = 24
    Top = 187
    Width = 28
    Height = 13
    Caption = #1046#1072#1085#1088
  end
  object lblCountry: TLabel
    Left = 24
    Top = 224
    Width = 37
    Height = 13
    Caption = #1057#1090#1088#1072#1085#1072
  end
  object lblYear: TLabel
    Left = 24
    Top = 259
    Width = 19
    Height = 13
    Caption = #1043#1086#1076
  end
  object lblDuration: TLabel
    Left = 24
    Top = 296
    Width = 73
    Height = 13
    Caption = #1044#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100
  end
  object lblWords: TLabel
    Left = 24
    Top = 331
    Width = 86
    Height = 13
    Caption = #1050#1083#1102#1095#1077#1074#1099#1077' '#1089#1083#1086#1074#1072
  end
  object lblAwards: TLabel
    Left = 24
    Top = 371
    Width = 45
    Height = 13
    Caption = #1053#1072#1075#1088#1072#1076#1099
  end
  object lblBudget: TLabel
    Left = 24
    Top = 408
    Width = 42
    Height = 13
    Caption = #1041#1102#1076#1078#1077#1090
  end
  object lblBoxOffice: TLabel
    Left = 24
    Top = 451
    Width = 33
    Height = 13
    Caption = #1057#1073#1086#1088#1099
  end
  object lblReady: TLabel
    Left = 24
    Top = 491
    Width = 71
    Height = 13
    Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1085#1086'?'
  end
  object lblRating: TLabel
    Left = 24
    Top = 528
    Width = 41
    Height = 13
    Caption = #1056#1077#1081#1090#1080#1085#1075
  end
  object lblDirector: TLabel
    Left = 24
    Top = 51
    Width = 55
    Height = 13
    Caption = #1056#1077#1078#1080#1089#1089#1105#1088' :'
  end
  object edtTitle: TEdit
    Left = 176
    Top = 21
    Width = 225
    Height = 21
    TabOrder = 0
  end
  object edtDirectorLastName: TEdit
    Left = 176
    Top = 77
    Width = 225
    Height = 21
    TabOrder = 1
  end
  object edtDirectorName: TEdit
    Left = 176
    Top = 104
    Width = 225
    Height = 21
    TabOrder = 2
  end
  object edtDirectorMiddleName: TEdit
    Left = 176
    Top = 131
    Width = 225
    Height = 21
    TabOrder = 3
  end
  object edtCountry: TEdit
    Left = 176
    Top = 221
    Width = 225
    Height = 21
    TabOrder = 4
  end
  object edtDuration: TEdit
    Left = 176
    Top = 293
    Width = 225
    Height = 21
    TabOrder = 5
  end
  object edtWords: TEdit
    Left = 176
    Top = 328
    Width = 225
    Height = 21
    TabOrder = 6
  end
  object edtAwards: TEdit
    Left = 176
    Top = 368
    Width = 225
    Height = 21
    TabOrder = 7
  end
  object edtBudget: TEdit
    Left = 176
    Top = 405
    Width = 225
    Height = 21
    TabOrder = 8
  end
  object edtBoxOffice: TEdit
    Left = 176
    Top = 448
    Width = 225
    Height = 21
    TabOrder = 9
  end
  object btnCancel: TButton
    Left = 256
    Top = 568
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 10
  end
  object btnOK: TButton
    Left = 84
    Top = 568
    Width = 75
    Height = 25
    Caption = #1054#1050
    TabOrder = 11
    OnClick = btnOKClick
  end
  object cmbbxGenre: TComboBox
    Left = 176
    Top = 184
    Width = 225
    Height = 21
    Style = csDropDownList
    TabOrder = 12
    Items.Strings = (
      #1055#1088#1080#1082#1083#1102#1095#1077#1085#1080#1103
      #1069#1082#1096#1085' '
      #1050#1086#1084#1077#1076#1080#1103
      #1044#1077#1090#1077#1082#1090#1080#1074
      #1044#1088#1072#1084#1072
      #1058#1088#1080#1083#1083#1077#1088
      #1060#1072#1085#1090#1072#1089#1090#1080#1082#1072
      #1053#1072#1091#1095#1085#1072#1103' '#1092#1072#1085#1090#1072#1089#1090#1080#1082#1072
      #1059#1078#1072#1089#1090#1080#1082
      #1048#1089#1090#1086#1088#1080#1095#1077#1089#1082#1080#1081
      #1052#1080#1089#1090#1080#1082#1072
      #1052#1077#1083#1086#1076#1088#1072#1084#1072
      #1042#1077#1089#1090#1077#1088#1085
      #1052#1091#1083#1100#1090#1092#1080#1083#1100#1084
      #1052#1100#1102#1079#1080#1082#1083
      #1057#1072#1090#1080#1088#1072
      #1057#1086#1094#1080#1072#1083#1100#1085#1099#1081
      #1044#1088#1091#1075#1086#1077)
  end
  object cmbbxRating: TComboBox
    Left = 176
    Top = 525
    Width = 65
    Height = 21
    Style = csDropDownList
    TabOrder = 13
    Items.Strings = (
      '10'
      '9'
      '8'
      '7'
      '6'
      '5'
      '4'
      '3'
      '2'
      '1')
  end
  object chbxReady: TCheckBox
    Left = 176
    Top = 490
    Width = 17
    Height = 17
    TabOrder = 14
  end
  object edtYear: TEdit
    Left = 176
    Top = 256
    Width = 225
    Height = 21
    TabOrder = 15
  end
end
