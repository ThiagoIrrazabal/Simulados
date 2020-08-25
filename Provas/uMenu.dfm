object frmMenu: TfrmMenu
  Left = 0
  Top = 0
  Caption = 'Menu'
  ClientHeight = 456
  ClientWidth = 851
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlProvas: TPanel
    Left = 0
    Top = 0
    Width = 200
    Height = 456
    Align = alLeft
    BevelOuter = bvNone
    Color = 23
    ParentBackground = False
    TabOrder = 0
    OnResize = pnlProvasResize
    object pnlOpcoes: TPanel
      AlignWithMargins = True
      Left = 1
      Top = 2
      Width = 197
      Height = 32
      Margins.Left = 1
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 1
      Align = alTop
      BevelOuter = bvNone
      Color = 23
      ParentBackground = False
      TabOrder = 0
      OnClick = lblSimuladosClick
      OnMouseEnter = pnlOpcoesMouseEnter
      OnMouseLeave = pnlOpcoesMouseLeave
      object imgDetailButton: TImage
        Left = 0
        Top = 0
        Width = 32
        Height = 32
        Align = alLeft
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
          00200806000000737A7AF4000000097048597300000B1300000B1301009A9C18
          000000664944415478DA63641860C038EA8041E780FFFFFF7B03A919402C4365
          BB9E0071062323E356420E784C03CBE18E003A4076D03B6060A380DE60D401A3
          0E187C0E18F06C38180AA20177C0684938EA8051070CAC03063C1B0E868268C0
          1D305A128E3A80AE00007C764221F03AEC720000000049454E44AE426082}
        Stretch = True
        OnClick = lblSimuladosClick
        OnMouseEnter = pnlOpcoesMouseEnter
        OnMouseLeave = pnlOpcoesMouseLeave
      end
      object lblSimulados: TLabel
        AlignWithMargins = True
        Left = 42
        Top = 7
        Width = 155
        Height = 25
        Margins.Left = 10
        Margins.Top = 7
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        Caption = 'Simulados Dispon'#237'veis'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = lblSimuladosClick
        OnMouseEnter = pnlOpcoesMouseEnter
        OnMouseLeave = pnlOpcoesMouseLeave
        ExplicitWidth = 140
        ExplicitHeight = 16
      end
    end
  end
  object pnlBackGround: TPanel
    Left = 200
    Top = 0
    Width = 651
    Height = 456
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object pnlTop: TPanel
      Left = 0
      Top = 0
      Width = 651
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      object pnlUsuario: TPanel
        AlignWithMargins = True
        Left = 376
        Top = 0
        Width = 273
        Height = 25
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 0
        Align = alClient
        BevelOuter = bvNone
        Color = 12615680
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
      end
      object pnlTempo: TPanel
        AlignWithMargins = True
        Left = 189
        Top = 0
        Width = 185
        Height = 25
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        BevelOuter = bvNone
        Color = 12615680
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
      end
      object pnlNomeProva: TPanel
        AlignWithMargins = True
        Left = 2
        Top = 0
        Width = 185
        Height = 25
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 0
        Align = alLeft
        BevelOuter = bvNone
        Color = 12615680
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Times New Roman'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
      end
    end
    object pnlProva: TPanel
      Left = 0
      Top = 25
      Width = 651
      Height = 431
      Align = alClient
      BevelOuter = bvNone
      Padding.Left = 80
      Padding.Top = 40
      Padding.Right = 80
      Padding.Bottom = 40
      ParentBackground = False
      TabOrder = 1
      object pnlBotoes: TPanel
        AlignWithMargins = True
        Left = 82
        Top = 348
        Width = 487
        Height = 41
        Margins.Left = 2
        Margins.Top = 0
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alBottom
        BevelOuter = bvNone
        Color = 12615680
        ParentBackground = False
        TabOrder = 0
        Visible = False
        DesignSize = (
          487
          41)
        object btnVoltar: TButton
          Left = 11
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Voltar'
          TabOrder = 0
          OnClick = btnVoltarClick
        end
        object btnAvancar: TButton
          Left = 400
          Top = 8
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Avan'#231'ar'
          TabOrder = 1
          OnClick = btnAvancarClick
        end
        object pnlBookMarks: TPanel
          Left = 92
          Top = 0
          Width = 157
          Height = 41
          BevelOuter = bvNone
          TabOrder = 2
        end
      end
    end
  end
  object tmrShow: TTimer
    Enabled = False
    Interval = 10
    OnTimer = tmrShowTimer
    Left = 416
    Top = 208
  end
  object tmrTempo: TTimer
    Enabled = False
    OnTimer = tmrTempoTimer
    Left = 488
    Top = 208
  end
end
