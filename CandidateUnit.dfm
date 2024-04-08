object CandidateForm: TCandidateForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1050#1072#1085#1076#1080#1076#1072#1090
  ClientHeight = 265
  ClientWidth = 268
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 15
  object LabelHighEducation: TLabel
    Left = 8
    Top = 153
    Width = 122
    Height = 15
    Caption = #1042#1099#1089#1096#1077#1077' '#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1077':'
  end
  object LabelBirthdate: TLabel
    Left = 43
    Top = 95
    Width = 86
    Height = 15
    Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103':'
  end
  object ButtonSave: TButton
    Left = 8
    Top = 234
    Width = 103
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Enabled = False
    TabOrder = 7
    OnClick = ButtonSaveClick
  end
  object ButtonCancel: TButton
    Left = 153
    Top = 234
    Width = 103
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 9
    OnClick = ButtonCancelClick
  end
  object CheckBoxHighEducation: TCheckBox
    Left = 135
    Top = 153
    Width = 97
    Height = 17
    Caption = #1048#1084#1077#1077#1090#1089#1103
    TabOrder = 5
    OnKeyDown = ControlOnKeyDown
  end
  object DateTimePicker: TDateTimePicker
    Left = 135
    Top = 95
    Width = 120
    Height = 23
    Date = 40281.000000000000000000
    Time = 40281.000000000000000000
    MaxDate = 40281.999988425920000000
    MinDate = 8870.000000000000000000
    TabOrder = 3
    OnKeyDown = ControlOnKeyDown
  end
  object LEditSurname: TLabeledEdit
    Left = 135
    Top = 8
    Width = 120
    Height = 23
    Hint = #1044#1086' 20 '#1089#1080#1084#1074#1086#1083#1086#1074
    EditLabel.Width = 54
    EditLabel.Height = 23
    EditLabel.Caption = #1060#1072#1084#1080#1083#1080#1103':'
    LabelPosition = lpLeft
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Text = ''
    TextHint = #1044#1086' 20 '#1089#1080#1084#1074#1086#1083#1086#1074
    OnChange = EditOnChange
    OnKeyDown = ControlOnKeyDown
    OnKeyPress = LEditSurnameKeyPress
  end
  object LEditName: TLabeledEdit
    Left = 135
    Top = 37
    Width = 120
    Height = 23
    Hint = #1044#1086' 20 '#1089#1080#1084#1074#1086#1083#1086#1074
    EditLabel.Width = 27
    EditLabel.Height = 23
    EditLabel.Caption = #1048#1084#1103':'
    LabelPosition = lpLeft
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Text = ''
    TextHint = #1044#1086' 20 '#1089#1080#1084#1074#1086#1083#1086#1074
    OnChange = EditOnChange
    OnKeyDown = ControlOnKeyDown
    OnKeyPress = LEditNameKeyPress
  end
  object LEditPatronymic: TLabeledEdit
    Left = 135
    Top = 66
    Width = 120
    Height = 23
    Hint = #1044#1086' 20 '#1089#1080#1084#1074#1086#1083#1086#1074
    EditLabel.Width = 54
    EditLabel.Height = 23
    EditLabel.Caption = #1054#1090#1095#1077#1089#1090#1074#1086':'
    LabelPosition = lpLeft
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Text = ''
    TextHint = #1044#1086' 20 '#1089#1080#1084#1074#1086#1083#1086#1074
    OnChange = EditOnChange
    OnKeyDown = ControlOnKeyDown
    OnKeyPress = LEditPatronymicKeyPress
  end
  object LEditSpeciality: TLabeledEdit
    Left = 135
    Top = 124
    Width = 120
    Height = 23
    Hint = #1044#1086' 20 '#1089#1080#1084#1074#1086#1083#1086#1074
    EditLabel.Width = 88
    EditLabel.Height = 23
    EditLabel.Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1100':'
    LabelPosition = lpLeft
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    Text = ''
    TextHint = #1044#1086' 20 '#1089#1080#1084#1074#1086#1083#1086#1074
    OnChange = EditOnChange
    OnKeyDown = ControlOnKeyDown
    OnKeyPress = LEditSpecialityKeyPress
  end
  object LEditTitle: TLabeledEdit
    Left = 135
    Top = 176
    Width = 120
    Height = 23
    Hint = #1044#1086' 20 '#1089#1080#1084#1074#1086#1083#1086#1074
    EditLabel.Width = 123
    EditLabel.Height = 23
    EditLabel.Caption = #1046#1077#1083#1072#1077#1084#1072#1103' '#1076#1086#1083#1078#1085#1086#1089#1090#1100':'
    LabelPosition = lpLeft
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    Text = ''
    TextHint = #1044#1086' 20 '#1089#1080#1084#1074#1086#1083#1086#1074
    OnChange = EditOnChange
    OnKeyDown = ControlOnKeyDown
    OnKeyPress = LEditTitleKeyPress
  end
  object LEditSalary: TLabeledEdit
    Left = 135
    Top = 205
    Width = 120
    Height = 23
    Hint = '1..99999'
    EditLabel.Width = 121
    EditLabel.Height = 23
    EditLabel.Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1099#1081' '#1086#1082#1083#1072#1076':'
    LabelPosition = lpLeft
    NumbersOnly = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    Text = ''
    TextHint = '1..99999'
    OnChange = EditOnChange
    OnKeyDown = ControlOnKeyDown
    OnKeyPress = LEditSalaryKeyPress
  end
end
