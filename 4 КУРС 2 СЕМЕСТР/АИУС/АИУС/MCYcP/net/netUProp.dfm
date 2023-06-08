object netProp: TnetProp
  Left = 660
  Top = 353
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1057#1074#1086#1081#1089#1090#1074#1072
  ClientHeight = 172
  ClientWidth = 205
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonCancel: TButton
    Left = 140
    Top = 144
    Width = 61
    Height = 21
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 7
  end
  object ButtonOk: TButton
    Left = 76
    Top = 144
    Width = 61
    Height = 21
    Caption = 'OK'
    Default = True
    TabOrder = 6
    OnClick = ButtonOkClick
  end
  object ButtonActions: TButton
    Left = 4
    Top = 144
    Width = 69
    Height = 21
    Caption = #1044#1077#1081#1089#1090#1074#1080#1103'...'
    Enabled = False
    TabOrder = 5
    Visible = False
  end
  object EditCapacity: TLabeledEdit
    Left = 4
    Top = 64
    Width = 53
    Height = 21
    EditLabel.Width = 39
    EditLabel.Height = 13
    EditLabel.Caption = #1056#1072#1079#1084#1077#1088
    MaxLength = 4
    TabOrder = 3
  end
  object EditState: TLabeledEdit
    Left = 64
    Top = 64
    Width = 65
    Height = 21
    EditLabel.Width = 54
    EditLabel.Height = 13
    EditLabel.Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077
    MaxLength = 128
    TabOrder = 4
  end
  object EditDX: TLabeledEdit
    Left = 148
    Top = 20
    Width = 53
    Height = 21
    EditLabel.Width = 15
    EditLabel.Height = 13
    EditLabel.Caption = 'DX'
    MaxLength = 4
    TabOrder = 2
  end
  object EditMX: TLabeledEdit
    Left = 88
    Top = 20
    Width = 53
    Height = 21
    EditLabel.Width = 16
    EditLabel.Height = 13
    EditLabel.Caption = 'MX'
    MaxLength = 4
    TabOrder = 1
  end
  object EditName: TLabeledEdit
    Left = 4
    Top = 20
    Width = 77
    Height = 21
    EditLabel.Width = 22
    EditLabel.Height = 13
    EditLabel.Caption = #1048#1084#1103
    MaxLength = 8
    TabOrder = 0
  end
  object EditPriority: TLabeledEdit
    Left = 136
    Top = 64
    Width = 65
    Height = 21
    EditLabel.Width = 54
    EditLabel.Height = 13
    EditLabel.Caption = #1055#1088#1080#1086#1088#1080#1090#1077#1090
    MaxLength = 128
    TabOrder = 8
  end
  object EditLamda: TLabeledEdit
    Left = 8
    Top = 112
    Width = 89
    Height = 21
    EditLabel.Width = 91
    EditLabel.Height = 13
    EditLabel.Caption = #1047#1085#1072#1095#1077#1085#1080#1077' '#1051#1103#1084#1073#1076#1072
    Enabled = False
    TabOrder = 9
  end
  object EditFunc: TLabeledEdit
    Left = 112
    Top = 112
    Width = 89
    Height = 21
    EditLabel.Width = 63
    EditLabel.Height = 13
    EditLabel.Caption = #1047#1085#1072#1095#1077#1085#1080#1077' f(t)'
    Enabled = False
    TabOrder = 10
  end
end
