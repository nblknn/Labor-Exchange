object DeficitForm: TDeficitForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1044#1077#1092#1080#1094#1080#1090#1085#1099#1077' '#1089#1087#1077#1094#1080#1072#1083#1080#1089#1090#1099
  ClientHeight = 367
  ClientWidth = 755
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu
  Position = poScreenCenter
  OnClose = FormClose
  OnHelp = FormHelp
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 20
  object LabelInfo: TLabel
    Left = 8
    Top = 8
    Width = 635
    Height = 20
    Caption = 
      #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1076#1072#1085#1085#1099#1093' '#1082#1072#1085#1076#1080#1076#1072#1090#1086#1074' '#1085#1072' '#1076#1086#1083#1078#1085#1086#1089#1090#1100' '#1085#1080#1078#1077' 10 '#1087#1088#1086#1094#1077#1085#1090#1086#1074' '#1086#1090' '#1082 +
      #1086#1083#1080#1095#1077#1089#1090#1074#1072' '#1074#1072#1082#1072#1085#1089#1080#1081':'
  end
  object ListView: TListView
    Left = 5
    Top = 40
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
        Width = 85
      end
      item
        Caption = #1054#1082#1083#1072#1076', '#1088#1091#1073'.'
        MinWidth = 50
        Width = 80
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
  object SaveDialog: TSaveDialog
    DefaultExt = '*.can'
    Filter = #1057#1087#1080#1089#1086#1082' '#1082#1072#1085#1076#1080#1076#1072#1090#1086#1074' (*.can)|*.can'
    Left = 424
    Top = 192
  end
  object MainMenu: TMainMenu
    Left = 640
    Top = 200
    object MMFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object MMSaveFile: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        Enabled = False
        ShortCut = 16467
        OnClick = MMSaveFileClick
      end
    end
  end
end
