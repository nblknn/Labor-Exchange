object FindCandidatesForm: TFindCandidatesForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1055#1086#1076#1073#1086#1088' '#1082#1072#1085#1076#1080#1076#1072#1090#1086#1074
  ClientHeight = 388
  ClientWidth = 758
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 20
  object LabelVacancy: TLabel
    Left = 8
    Top = 2
    Width = 68
    Height = 20
    Caption = #1042#1072#1082#1072#1085#1089#1080#1103':'
  end
  object LabelCandidates: TLabel
    Left = 8
    Top = 84
    Width = 162
    Height = 20
    Caption = #1053#1072#1081#1076#1077#1085#1085#1099#1077' '#1082#1072#1085#1076#1080#1076#1072#1090#1099':'
  end
  object ListViewVacancy: TListView
    Left = 8
    Top = 28
    Width = 743
    Height = 50
    Columns = <
      item
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1092#1080#1088#1084#1099
        MinWidth = 50
        Width = 110
      end
      item
        Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1100
        MinWidth = 50
        Width = 100
      end
      item
        Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
        MinWidth = 50
        Width = 100
      end
      item
        Caption = #1054#1082#1083#1072#1076
        MinWidth = 50
        Width = 70
      end
      item
        Caption = #1044#1085#1077#1081' '#1086#1090#1087#1091#1089#1082#1072
        MinWidth = 50
        Width = 90
      end
      item
        Caption = #1042#1099#1089#1096#1077#1077' '#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1077
        MinWidth = 50
        Width = 135
      end
      item
        Caption = #1042#1086#1079#1088#1072#1089#1090#1085#1086#1081' '#1076#1080#1072#1087#1072#1079#1086#1085
        MinWidth = 50
        Width = 133
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    TabOrder = 0
    ViewStyle = vsReport
  end
  object ListViewCandidates: TListView
    Left = 8
    Top = 110
    Width = 745
    Height = 279
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
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    TabOrder = 1
    ViewStyle = vsReport
  end
  object MainMenu: TMainMenu
    Left = 688
    Top = 80
    object MMFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object MMSaveFile: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        Enabled = False
        ShortCut = 16467
        OnClick = MMSaveFileClick
      end
    end
    object N1: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      object N4: TMenuItem
        Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
        ShortCut = 112
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object N2: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      end
    end
  end
  object SaveDialog: TSaveDialog
    Left = 632
    Top = 224
  end
end
