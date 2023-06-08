object Prop: TProp
  Left = 358
  Top = 286
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1057#1074#1086#1081#1089#1090#1074#1072
  ClientHeight = 314
  ClientWidth = 296
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
    Left = 96
    Top = 48
    Width = 58
    Height = 13
    Caption = #1087#1088#1086#1087#1091#1089#1082#1072#1090#1100
  end
  object ButtonCancel: TButton
    Left = 140
    Top = 136
    Width = 61
    Height = 21
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 7
  end
  object ButtonOk: TButton
    Left = 76
    Top = 136
    Width = 61
    Height = 21
    Caption = 'OK'
    Default = True
    TabOrder = 6
    OnClick = ButtonOkClick
  end
  object ButtonActions: TButton
    Left = 4
    Top = 136
    Width = 69
    Height = 21
    Caption = #1044#1077#1081#1089#1090#1074#1080#1103'...'
    Enabled = False
    TabOrder = 5
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
    OnEnter = Prov
  end
  object EditState_red: TLabeledEdit
    Left = 8
    Top = 104
    Width = 25
    Height = 21
    EditLabel.Width = 6
    EditLabel.Height = 13
    EditLabel.Caption = 'a'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clRed
    EditLabel.Font.Height = -11
    EditLabel.Font.Name = 'MS Sans Serif'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    MaxLength = 128
    TabOrder = 4
    OnEnter = Prov
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
    Left = 8
    Top = 64
    Width = 65
    Height = 21
    EditLabel.Width = 54
    EditLabel.Height = 13
    EditLabel.Caption = #1055#1088#1080#1086#1088#1080#1090#1077#1090
    MaxLength = 128
    TabOrder = 8
  end
  object EditState_green: TLabeledEdit
    Left = 40
    Top = 104
    Width = 25
    Height = 21
    EditLabel.Width = 6
    EditLabel.Height = 13
    EditLabel.Caption = 'b'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clGreen
    EditLabel.Font.Height = -11
    EditLabel.Font.Name = 'MS Sans Serif'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    MaxLength = 128
    TabOrder = 9
    OnEnter = Prov
  end
  object CheckListBox1: TCheckListBox
    Left = 112
    Top = 72
    Width = 33
    Height = 33
    ItemHeight = 13
    Items.Strings = (
      'a'
      'b')
    TabOrder = 10
  end
  object WeightOfLink: TLabeledEdit
    Left = 8
    Top = 64
    Width = 161
    Height = 21
    EditLabel.Width = 171
    EditLabel.Height = 13
    EditLabel.Caption = #1060#1086#1088#1084#1091#1083#1072' '#1074#1077#1089#1072' '#1076#1091#1075#1080' '#1090#1080#1087#1072' 2a+b+3c'
    MaxLength = 128
    TabOrder = 11
    Visible = False
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 24
    Width = 97
    Height = 17
    Caption = #1048#1085#1075#1080#1073#1080#1090#1086#1088#1085#1072#1103
    TabOrder = 12
  end
end
