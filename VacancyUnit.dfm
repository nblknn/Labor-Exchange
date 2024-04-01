object VacancyForm: TVacancyForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1042#1072#1082#1072#1085#1089#1080#1103
  ClientHeight = 299
  ClientWidth = 296
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  TextHeight = 15
  object LabelName: TLabel
    Left = 55
    Top = 11
    Width = 99
    Height = 15
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1092#1080#1088#1084#1099':'
  end
  object LabelSpeciality: TLabel
    Left = 66
    Top = 40
    Width = 88
    Height = 15
    Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1100':'
  end
  object LabelPosition: TLabel
    Left = 89
    Top = 69
    Width = 65
    Height = 15
    Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100':'
  end
  object LabelVacationDays: TLabel
    Left = 11
    Top = 127
    Width = 143
    Height = 15
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1076#1085#1077#1081' '#1086#1090#1087#1091#1089#1082#1072':'
  end
  object LabelHighEducation: TLabel
    Left = 32
    Top = 155
    Width = 122
    Height = 15
    Caption = #1042#1099#1089#1096#1077#1077' '#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1077':'
  end
  object LabelSalary: TLabel
    Left = 117
    Top = 98
    Width = 37
    Height = 15
    Caption = #1054#1082#1083#1072#1076':'
  end
  object LabelMinAge: TLabel
    Left = 23
    Top = 202
    Width = 131
    Height = 15
    Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1099#1081' '#1074#1086#1079#1088#1072#1089#1090':'
  end
  object LabelMaxAge: TLabel
    Left = 19
    Top = 233
    Width = 135
    Height = 15
    Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1099#1081' '#1074#1086#1079#1088#1072#1089#1090':'
  end
  object EditName: TEdit
    Left = 160
    Top = 8
    Width = 121
    Height = 23
    Hint = #1044#1086' 30 '#1089#1080#1084#1074#1086#1083#1086#1074
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TextHint = #1044#1086' 30 '#1089#1080#1084#1074#1086#1083#1086#1074
  end
  object EditSalary: TEdit
    Left = 160
    Top = 95
    Width = 121
    Height = 23
    Hint = '1..99999'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    TextHint = '1..99999'
  end
  object EditPosition: TEdit
    Left = 160
    Top = 66
    Width = 121
    Height = 23
    Hint = #1044#1086' 30 '#1089#1080#1084#1074#1086#1083#1086#1074
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    TextHint = #1044#1086' 30 '#1089#1080#1084#1074#1086#1083#1086#1074
  end
  object EditSpeciality: TEdit
    Left = 160
    Top = 37
    Width = 121
    Height = 23
    Hint = #1044#1086' 30 '#1089#1080#1084#1074#1086#1083#1086#1074
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    TextHint = #1044#1086' 30 '#1089#1080#1084#1074#1086#1083#1086#1074
  end
  object EditVacationDays: TEdit
    Left = 160
    Top = 124
    Width = 121
    Height = 23
    Hint = '1..99'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    TextHint = '1..99'
  end
  object EditMinAge: TEdit
    Left = 160
    Top = 199
    Width = 121
    Height = 23
    Hint = '14..99'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    TextHint = '14..99'
  end
  object Edit7: TEdit
    Left = 160
    Top = 230
    Width = 121
    Height = 23
    Hint = '14..99'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    TextHint = '14..99'
  end
  object RadioButtonRequired: TRadioButton
    Left = 160
    Top = 153
    Width = 113
    Height = 17
    Caption = #1058#1088#1077#1073#1091#1077#1090#1089#1103
    TabOrder = 5
  end
  object RadioButtonNotRequired: TRadioButton
    Left = 160
    Top = 176
    Width = 113
    Height = 17
    Caption = #1053#1077' '#1090#1088#1077#1073#1091#1077#1090#1089#1103
    TabOrder = 6
  end
  object ButtonSave: TButton
    Left = 31
    Top = 264
    Width = 103
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 9
  end
  object ButtonCancel: TButton
    Left = 160
    Top = 264
    Width = 103
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 10
    OnClick = ButtonCancelClick
  end
  object MainMenu: TMainMenu
    Left = 9
    Top = 64
    object MMInstruction: TMenuItem
      Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
    end
  end
end
