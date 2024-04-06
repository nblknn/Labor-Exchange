object VacancySearchForm: TVacancySearchForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1055#1086#1080#1089#1082' '#1074#1072#1082#1072#1085#1089#1080#1080
  ClientHeight = 164
  ClientWidth = 199
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  TextHeight = 15
  object LabelSearch: TLabel
    Left = 8
    Top = 8
    Width = 55
    Height = 15
    Caption = #1055#1086#1080#1089#1082' '#1087#1086':'
  end
  object LabelInfo: TLabel
    Left = 8
    Top = 146
    Width = 49
    Height = 15
    Caption = 'LabelInfo'
    Visible = False
  end
  object EditValue: TEdit
    Left = 8
    Top = 61
    Width = 185
    Height = 23
    Hint = #1044#1086' 20 '#1089#1080#1084#1074#1086#1083#1086#1074
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TextHint = #1044#1086' 20 '#1089#1080#1084#1074#1086#1083#1086#1074
    OnChange = EditValueChange
    OnKeyPress = EditValueKeyPress
  end
  object ButtonSearch: TButton
    Left = 8
    Top = 90
    Width = 75
    Height = 25
    Caption = #1053#1072#1081#1090#1080
    Enabled = False
    TabOrder = 1
    OnClick = ButtonSearchClick
  end
  object ButtonCancel: TButton
    Left = 118
    Top = 90
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = ButtonCancelClick
  end
  object ButtonNext: TButton
    Left = 64
    Top = 121
    Width = 75
    Height = 25
    Caption = #1044#1072#1083#1100#1096#1077
    Enabled = False
    TabOrder = 3
    OnClick = ButtonNextClick
  end
  object ComboBoxParam: TComboBox
    Left = 8
    Top = 32
    Width = 185
    Height = 23
    Hint = #1044#1086' 20 '#1089#1080#1084#1074#1086#1083#1086#1074
    TabOrder = 4
    OnSelect = ComboBoxParamSelect
    Items.Strings = (
      #1053#1072#1079#1074#1072#1085#1080#1102' '#1092#1080#1088#1084#1099
      #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1080
      #1044#1086#1083#1078#1085#1086#1089#1090#1080)
  end
end
