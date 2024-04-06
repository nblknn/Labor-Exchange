object VacancyListForm: TVacancyListForm
  Left = 0
  Top = 0
  Caption = #1057#1087#1080#1089#1086#1082' '#1074#1072#1082#1072#1085#1089#1080#1081
  ClientHeight = 381
  ClientWidth = 762
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
  OnKeyDown = FormKeyDown
  TextHeight = 20
  object ListView: TListView
    Left = 8
    Top = 55
    Width = 743
    Height = 321
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
    TabOrder = 4
    ViewStyle = vsReport
    OnChange = ListViewChange
    OnDblClick = ListViewDblClick
    OnSelectItem = ListViewSelectItem
  end
  object ButtonAdd: TButton
    Left = 8
    Top = 8
    Width = 169
    Height = 41
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074#1072#1082#1072#1085#1089#1080#1102
    TabOrder = 0
    OnClick = ButtonAddClick
  end
  object ButtonDelete: TButton
    Left = 200
    Top = 8
    Width = 169
    Height = 41
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1074#1072#1082#1072#1085#1089#1080#1102
    Enabled = False
    TabOrder = 1
    OnClick = ButtonDeleteClick
  end
  object ButtonSearch: TButton
    Left = 392
    Top = 8
    Width = 169
    Height = 41
    Caption = #1055#1086#1080#1089#1082' '#1074#1072#1082#1072#1085#1089#1080#1080
    Enabled = False
    TabOrder = 2
    OnClick = ButtonSearchClick
  end
  object ButtonFindCandidates: TButton
    Left = 582
    Top = 8
    Width = 169
    Height = 41
    Caption = #1055#1086#1076#1086#1073#1088#1072#1090#1100' '#1082#1072#1085#1076#1080#1076#1072#1090#1086#1074
    Enabled = False
    TabOrder = 3
    OnClick = ButtonFindCandidatesClick
  end
  object MainMenu: TMainMenu
    Left = 264
    Top = 65528
    object MMFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object MMOpenFile: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100'...'
        ShortCut = 16463
        OnClick = MMOpenFileClick
      end
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
    Left = 304
    Top = 120
  end
  object OpenDialog: TOpenDialog
    Left = 544
    Top = 120
  end
end
