object Prop: TProp
  Left = 205
  Top = 136
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1057#1074#1086#1081#1089#1090#1074#1072
  ClientHeight = 242
  ClientWidth = 280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 218
    Width = 54
    Height = 13
    Caption = #1055#1088#1080#1086#1088#1080#1090#1077#1090
  end
  object Label2: TLabel
    Left = 24
    Top = 219
    Width = 33
    Height = 13
    Caption = #1042#1099#1073#1086#1088
  end
  object ButtonCancel: TButton
    Left = 216
    Top = 216
    Width = 57
    Height = 21
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 6
  end
  object ButtonOk: TButton
    Left = 216
    Top = 184
    Width = 57
    Height = 21
    Caption = 'OK'
    Default = True
    TabOrder = 5
    OnClick = ButtonOkClick
  end
  object EditCapacity: TLabeledEdit
    Left = 4
    Top = 64
    Width = 117
    Height = 21
    EditLabel.Width = 39
    EditLabel.Height = 13
    EditLabel.Caption = #1056#1072#1079#1084#1077#1088
    MaxLength = 4
    TabOrder = 3
  end
  object EditState: TLabeledEdit
    Left = 144
    Top = 64
    Width = 129
    Height = 21
    EditLabel.Width = 54
    EditLabel.Height = 13
    EditLabel.Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077
    MaxLength = 128
    TabOrder = 4
    OnKeyPress = EditStateKeyPress
  end
  object EditDX: TLabeledEdit
    Left = 180
    Top = 20
    Width = 93
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
    Width = 81
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
  object EditUsl1: TLabeledEdit
    Left = 64
    Top = 104
    Width = 57
    Height = 21
    EditLabel.Width = 50
    EditLabel.Height = 13
    EditLabel.BiDiMode = bdLeftToRight
    EditLabel.Caption = #1059#1089#1083#1086#1074#1080#1077'1'
    EditLabel.ParentBiDiMode = False
    MaxLength = 128
    TabOrder = 7
  end
  object EditUsl2: TLabeledEdit
    Left = 64
    Top = 144
    Width = 57
    Height = 21
    EditLabel.Width = 50
    EditLabel.Height = 13
    EditLabel.BiDiMode = bdLeftToRight
    EditLabel.Caption = #1059#1089#1083#1086#1074#1080#1077'2'
    EditLabel.ParentBiDiMode = False
    MaxLength = 128
    TabOrder = 8
  end
  object EditP1: TLabeledEdit
    Left = 144
    Top = 104
    Width = 57
    Height = 21
    EditLabel.Width = 13
    EditLabel.Height = 13
    EditLabel.Caption = 'P1'
    MaxLength = 4
    TabOrder = 9
  end
  object EditP2: TLabeledEdit
    Left = 144
    Top = 144
    Width = 57
    Height = 21
    EditLabel.Width = 13
    EditLabel.Height = 13
    EditLabel.Caption = 'P2'
    MaxLength = 4
    TabOrder = 10
  end
  object EditP3: TLabeledEdit
    Left = 144
    Top = 184
    Width = 57
    Height = 21
    EditLabel.Width = 13
    EditLabel.Height = 13
    EditLabel.Caption = 'P3'
    MaxLength = 4
    TabOrder = 11
  end
  object EditUsl3: TLabeledEdit
    Left = 64
    Top = 184
    Width = 57
    Height = 21
    EditLabel.Width = 50
    EditLabel.Height = 13
    EditLabel.BiDiMode = bdLeftToRight
    EditLabel.Caption = #1059#1089#1083#1086#1074#1080#1077'3'
    EditLabel.ParentBiDiMode = False
    MaxLength = 128
    TabOrder = 12
  end
  object BoxUsl1: TComboBox
    Left = 8
    Top = 104
    Width = 41
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 13
    Text = '='
    Items.Strings = (
      '='
      '<>'
      '>'
      '>='
      '<'
      '<=')
  end
  object BoxUsl2: TComboBox
    Left = 8
    Top = 144
    Width = 41
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 14
    Text = '='
    Items.Strings = (
      '='
      '<>'
      '>'
      '>='
      '<'
      '<=')
  end
  object BoxUsl3: TComboBox
    Left = 8
    Top = 184
    Width = 41
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 15
    Text = '='
    Items.Strings = (
      '='
      '<>'
      '>'
      '>='
      '<'
      '<=')
  end
  object EditP4: TLabeledEdit
    Left = 216
    Top = 104
    Width = 57
    Height = 21
    EditLabel.Width = 13
    EditLabel.Height = 13
    EditLabel.Caption = 'P4'
    TabOrder = 16
  end
  object EditP5: TLabeledEdit
    Left = 216
    Top = 144
    Width = 57
    Height = 21
    EditLabel.Width = 13
    EditLabel.Height = 13
    EditLabel.Caption = 'P5'
    TabOrder = 17
  end
  object BoxUsl7: TComboBox
    Left = 64
    Top = 216
    Width = 137
    Height = 21
    ItemHeight = 13
    TabOrder = 18
    Items.Strings = (
      #1073#1077#1079' '#1087#1088#1080#1086#1088#1080#1090#1077#1090#1072
      #1087#1086' '#1087#1088#1080#1086#1088#1080#1090#1077#1090#1091)
  end
  object BoxUsl8: TComboBox
    Left = 64
    Top = 216
    Width = 137
    Height = 21
    ItemHeight = 13
    TabOrder = 19
    Items.Strings = (
      #1073#1077#1079' '#1074#1099#1073#1086#1088#1072
      #1086#1090#1089#1077#1095#1077#1085#1080#1077' '#1093#1074#1086#1089#1090#1072
      #1087#1077#1088#1077#1093#1086#1076' '#1087#1086' '#1087#1088#1077#1074#1099#1096#1077#1085#1080#1102' '#1076#1083#1080#1085#1099' '#1086#1095#1077#1088#1077#1076#1080
      #1087#1088#1080#1086#1088#1080#1090#1077#1090#1085#1099#1081' '#1087#1077#1088#1077#1093#1086#1076' '#1089' '#1086#1090#1089#1077#1095#1077#1085#1080#1077#1084' '#1093#1074#1086#1089#1090#1072)
  end
end
