object SearchVacancyForm: TSearchVacancyForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1055#1086#1080#1089#1082' '#1074#1072#1082#1072#1085#1089#1080#1080
  ClientHeight = 203
  ClientWidth = 205
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object Edit1: TEdit
    Left = 8
    Top = 110
    Width = 185
    Height = 23
    Enabled = False
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 139
    Width = 75
    Height = 25
    Caption = #1053#1072#1081#1090#1080
    Enabled = False
    TabOrder = 1
  end
  object Button2: TButton
    Left = 118
    Top = 139
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
  end
  object Button3: TButton
    Left = 64
    Top = 170
    Width = 75
    Height = 25
    Caption = #1057#1083#1077#1076#1091#1102#1097#1072#1103
    Enabled = False
    TabOrder = 3
  end
  object DBRadioGroup1: TDBRadioGroup
    Left = 8
    Top = 8
    Width = 185
    Height = 96
    Caption = #1055#1086#1080#1089#1082' '#1087#1086':'
    Items.Strings = (
      #1053#1072#1079#1074#1072#1085#1080#1102' '#1092#1080#1088#1084#1099
      #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1080
      #1044#1086#1083#1078#1085#1086#1089#1090#1080)
    TabOrder = 4
  end
end
