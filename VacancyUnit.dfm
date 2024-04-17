object VacancyForm: TVacancyForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1042#1072#1082#1072#1085#1089#1080#1103
  ClientHeight = 272
  ClientWidth = 279
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 15
  object LabelHighEducation: TLabel
    Left = 21
    Top = 153
    Width = 122
    Height = 15
    Caption = #1042#1099#1089#1096#1077#1077' '#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1077':'
  end
  object ButtonSave: TButton
    Left = 20
    Top = 241
    Width = 103
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Enabled = False
    TabOrder = 7
    OnClick = ButtonSaveClick
  end
  object ButtonCancel: TButton
    Left = 149
    Top = 241
    Width = 103
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 9
    OnClick = ButtonCancelClick
  end
  object CheckBoxHighEducation: TCheckBox
    Left = 149
    Top = 153
    Width = 97
    Height = 17
    Caption = #1058#1088#1077#1073#1091#1077#1090#1089#1103
    TabOrder = 5
    OnKeyDown = ControlOnKeyDown
  end
  object LEditFirmName: TLabeledEdit
    Left = 149
    Top = 8
    Width = 121
    Height = 23
    Hint = #1044#1086' 20 '#1089#1080#1084#1074#1086#1083#1086#1074
    EditLabel.Width = 99
    EditLabel.Height = 23
    EditLabel.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1092#1080#1088#1084#1099':'
    LabelPosition = lpLeft
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Text = ''
    TextHint = #1044#1086' 20 '#1089#1080#1084#1074#1086#1083#1086#1074
    OnChange = EditOnChange
    OnKeyDown = ControlOnKeyDown
    OnKeyPress = LEditFirmNameKeyPress
  end
  object LEditSpeciality: TLabeledEdit
    Left = 149
    Top = 37
    Width = 121
    Height = 23
    Hint = #1044#1086' 20 '#1089#1080#1084#1074#1086#1083#1086#1074
    EditLabel.Width = 88
    EditLabel.Height = 23
    EditLabel.Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1100':'
    LabelPosition = lpLeft
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Text = ''
    TextHint = #1044#1086' 20 '#1089#1080#1084#1074#1086#1083#1086#1074
    OnChange = EditOnChange
    OnKeyDown = ControlOnKeyDown
    OnKeyPress = LEditSpecialityKeyPress
  end
  object LEditTitle: TLabeledEdit
    Left = 149
    Top = 66
    Width = 121
    Height = 23
    Hint = #1044#1086' 20 '#1089#1080#1084#1074#1086#1083#1086#1074
    EditLabel.Width = 65
    EditLabel.Height = 23
    EditLabel.Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100':'
    LabelPosition = lpLeft
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Text = ''
    TextHint = #1044#1086' 20 '#1089#1080#1084#1074#1086#1083#1086#1074
    OnChange = EditOnChange
    OnKeyDown = ControlOnKeyDown
    OnKeyPress = LEditTitleKeyPress
  end
  object LEditSalary: TLabeledEdit
    Left = 149
    Top = 95
    Width = 121
    Height = 23
    Hint = '1..99999'
    EditLabel.Width = 66
    EditLabel.Height = 23
    EditLabel.Caption = #1054#1082#1083#1072#1076', '#1088#1091#1073'.:'
    LabelPosition = lpLeft
    NumbersOnly = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Text = ''
    TextHint = '1..99999'
    OnChange = EditOnChange
    OnKeyDown = ControlOnKeyDown
    OnKeyPress = LEditSalaryKeyPress
  end
  object LEditVacationDays: TLabeledEdit
    Left = 149
    Top = 124
    Width = 121
    Height = 23
    Hint = '1..99'
    EditLabel.Width = 143
    EditLabel.Height = 23
    EditLabel.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1076#1085#1077#1081' '#1086#1090#1087#1091#1089#1082#1072':'
    LabelPosition = lpLeft
    NumbersOnly = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    Text = ''
    TextHint = '1..99'
    OnChange = EditOnChange
    OnKeyDown = ControlOnKeyDown
    OnKeyPress = LEditVacationDaysKeyPress
  end
  object LEditMinAge: TLabeledEdit
    Left = 149
    Top = 176
    Width = 121
    Height = 23
    Hint = '14..99'
    EditLabel.Width = 131
    EditLabel.Height = 23
    EditLabel.Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1099#1081' '#1074#1086#1079#1088#1072#1089#1090':'
    LabelPosition = lpLeft
    NumbersOnly = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    Text = ''
    TextHint = '14..99'
    OnChange = EditOnChange
    OnKeyDown = ControlOnKeyDown
    OnKeyPress = LEditMinAgeKeyPress
  end
  object LEditMaxAge: TLabeledEdit
    Left = 149
    Top = 207
    Width = 121
    Height = 23
    Hint = '14..99'
    EditLabel.Width = 135
    EditLabel.Height = 23
    EditLabel.Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1099#1081' '#1074#1086#1079#1088#1072#1089#1090':'
    LabelPosition = lpLeft
    NumbersOnly = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    Text = ''
    TextHint = '14..99'
    OnChange = EditOnChange
    OnKeyDown = ControlOnKeyDown
    OnKeyPress = LEditMaxAgeKeyPress
  end
end
