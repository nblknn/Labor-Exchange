object FirmListForm: TFirmListForm
  Left = 0
  Top = 0
  Caption = #1057#1087#1080#1089#1086#1082' '#1092#1080#1088#1084
  ClientHeight = 377
  ClientWidth = 759
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu
  Position = poScreenCenter
  TextHeight = 20
  object ListView1: TListView
    Left = 8
    Top = 48
    Width = 743
    Height = 321
    Columns = <
      item
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        MinWidth = 50
        Width = 90
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
        Width = 90
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
    ParentFont = False
    TabOrder = 4
    ViewStyle = vsReport
  end
  object ButtonAdd: TButton
    Left = 8
    Top = 8
    Width = 169
    Height = 34
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074#1072#1082#1072#1085#1089#1080#1102
    TabOrder = 0
    OnClick = ButtonAddClick
  end
  object ButtonDelete: TButton
    Left = 200
    Top = 8
    Width = 169
    Height = 34
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1074#1072#1082#1072#1085#1089#1080#1102
    Enabled = False
    TabOrder = 1
  end
  object ButtonSearch: TButton
    Left = 392
    Top = 8
    Width = 169
    Height = 34
    Caption = #1055#1086#1080#1089#1082' '#1074#1072#1082#1072#1085#1089#1080#1080
    Enabled = False
    TabOrder = 2
  end
  object ButtonFindCandidates: TButton
    Left = 582
    Top = 8
    Width = 169
    Height = 34
    Caption = #1055#1086#1076#1086#1073#1088#1072#1090#1100' '#1082#1072#1085#1076#1080#1076#1072#1090#1086#1074
    Enabled = False
    TabOrder = 3
  end
  object MainMenu: TMainMenu
    Left = 264
    Top = 65528
    object N1: TMenuItem
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
  end
end
