object CandidateListForm: TCandidateListForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1057#1087#1080#1089#1086#1082' '#1082#1072#1085#1076#1080#1076#1072#1090#1086#1074
  ClientHeight = 381
  ClientWidth = 760
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  TextHeight = 20
  object ButtonAdd: TButton
    Left = 8
    Top = 8
    Width = 169
    Height = 42
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1072#1085#1076#1080#1076#1072#1090#1072
    TabOrder = 0
    OnClick = ButtonAddClick
  end
  object ButtonDelete: TButton
    Left = 200
    Top = 8
    Width = 169
    Height = 42
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1082#1072#1085#1076#1080#1076#1072#1090#1072
    Enabled = False
    TabOrder = 1
  end
  object ButtonDeficite: TButton
    Left = 583
    Top = 8
    Width = 169
    Height = 42
    Caption = #1057#1087#1080#1089#1086#1082' '#1076#1077#1092#1080#1094#1080#1090#1085#1099#1093' '#1089#1087#1077#1094#1080#1072#1083#1080#1089#1090#1086#1074
    Enabled = False
    TabOrder = 2
    WordWrap = True
  end
  object ButtonSearch: TButton
    Left = 392
    Top = 8
    Width = 169
    Height = 42
    Caption = #1055#1086#1080#1089#1082' '#1082#1072#1085#1076#1080#1076#1072#1090#1072
    Enabled = False
    TabOrder = 3
  end
  object ListView: TListView
    Left = 8
    Top = 56
    Width = 745
    Height = 321
    Columns = <
      item
        Caption = #1060#1072#1084#1080#1083#1080#1103
        MinWidth = 50
        Width = 80
      end
      item
        Caption = #1048#1084#1103
        MinWidth = 50
        Width = 70
      end
      item
        Caption = #1054#1090#1095#1077#1089#1090#1074#1086
        MinWidth = 50
        Width = 80
      end
      item
        Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103
        MinWidth = 50
        Width = 100
      end
      item
        Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1100
        MinWidth = 50
        Width = 110
      end
      item
        Caption = #1042#1099#1089#1096#1077#1077' '#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1077
        MinWidth = 50
        Width = 135
      end
      item
        Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
        MinWidth = 50
        Width = 95
      end
      item
        Caption = #1054#1082#1083#1072#1076
        MinWidth = 50
        Width = 70
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    RowSelect = True
    ParentFont = False
    TabOrder = 4
    ViewStyle = vsReport
  end
  object MainMenu: TMainMenu
    Left = 264
    Top = 65528
    object MMFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object MMOpenFile: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100'...'
        ShortCut = 16463
      end
      object MMSaveFile: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        Enabled = False
        ShortCut = 16467
      end
    end
    object MMInstruction: TMenuItem
      Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
    end
  end
end
