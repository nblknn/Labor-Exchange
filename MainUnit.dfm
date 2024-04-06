object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1041#1080#1088#1078#1072' '#1090#1088#1091#1076#1072
  ClientHeight = 222
  ClientWidth = 244
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  TextHeight = 20
  object LabelProgramName: TLabel
    Left = 72
    Top = 8
    Width = 104
    Height = 25
    Caption = #1041#1080#1088#1078#1072' '#1090#1088#1091#1076#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object ButtonFirmList: TButton
    Left = 47
    Top = 48
    Width = 153
    Height = 41
    Caption = #1057#1087#1080#1089#1086#1082' '#1092#1080#1088#1084
    TabOrder = 0
    OnClick = ButtonFirmListClick
  end
  object ButtonCandidateList: TButton
    Left = 47
    Top = 110
    Width = 153
    Height = 42
    Caption = #1057#1087#1080#1089#1086#1082' '#1082#1072#1085#1076#1080#1076#1072#1090#1086#1074
    TabOrder = 1
    OnClick = ButtonCandidateListClick
  end
  object ButtonExit: TButton
    Left = 47
    Top = 172
    Width = 153
    Height = 43
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 2
    WordWrap = True
    OnClick = ButtonExitClick
  end
  object MainMenu: TMainMenu
    Left = 40
    Top = 40
    object MMHelp: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      object MMInstruction: TMenuItem
        Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
        ShortCut = 112
      end
      object MMSeparator: TMenuItem
        Caption = '-'
      end
      object MMProgramInfo: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      end
    end
  end
end
