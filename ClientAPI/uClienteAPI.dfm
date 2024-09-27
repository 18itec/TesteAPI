object FPrincipal: TFPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Constula CEP'
  ClientHeight = 276
  ClientWidth = 264
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object EdtCEP: TEdit
    Left = 8
    Top = 79
    Width = 131
    Height = 25
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnEnter = EdtCEPEnter
  end
  object BtnConsult: TButton
    Left = 145
    Top = 79
    Width = 113
    Height = 25
    Caption = 'Consultar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = BtnConsultClick
  end
  object gpStatus: TGroupBox
    Left = 8
    Top = 8
    Width = 248
    Height = 57
    Caption = 'Status Server'
    TabOrder = 2
    object pnlStatusServer: TPanel
      Left = 16
      Top = 22
      Width = 217
      Height = 21
      BevelOuter = bvNone
      Caption = 'On-Line'
      Color = 9803263
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
    end
  end
  object gpResult: TGroupBox
    Left = 8
    Top = 110
    Width = 250
    Height = 115
    Caption = 'Resultado'
    TabOrder = 3
    object mResult: TMemo
      Left = 2
      Top = 17
      Width = 246
      Height = 96
      Align = alClient
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object BtnClose: TButton
    Left = 8
    Top = 231
    Width = 250
    Height = 34
    Caption = 'Fechar'
    TabOrder = 4
    OnClick = BtnCloseClick
  end
end
