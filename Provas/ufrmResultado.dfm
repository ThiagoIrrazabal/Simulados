object frmResultado: TfrmResultado
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 163
  ClientWidth = 390
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBackGround: TPanel
    AlignWithMargins = True
    Left = 2
    Top = 2
    Width = 386
    Height = 159
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object pnlProva: TPanel
      Left = 0
      Top = 0
      Width = 386
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Color = 12615680
      ParentBackground = False
      TabOrder = 0
      object lblProva: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 2
        Width = 107
        Height = 20
        Margins.Left = 5
        Margins.Top = 2
        Align = alLeft
        Caption = 'Simulado %s'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitHeight = 19
      end
      object pnlCloseButton: TPanel
        AlignWithMargins = True
        Left = 360
        Top = 3
        Width = 23
        Height = 19
        Align = alRight
        BevelOuter = bvNone
        Caption = 'X'
        Color = 4605680
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        OnClick = pnlCloseButtonClick
        OnMouseEnter = pnlCloseButtonMouseEnter
        OnMouseLeave = pnlCloseButtonMouseLeave
      end
    end
    object GridPanel1: TGridPanel
      Left = 0
      Top = 25
      Width = 386
      Height = 134
      Align = alClient
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = Panel1
          Row = 0
        end
        item
          Column = 0
          Control = Panel2
          Row = 1
        end
        item
          Column = 0
          Control = Panel3
          Row = 2
        end
        item
          Column = 0
          Control = Panel4
          Row = 3
        end>
      RowCollection = <
        item
          Value = 25.000000000000000000
        end
        item
          Value = 25.000000000000000000
        end
        item
          Value = 25.000000000000000000
        end
        item
          Value = 25.000000000000000000
        end>
      TabOrder = 1
      object Panel1: TPanel
        Left = 1
        Top = 1
        Width = 384
        Height = 33
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object lblDataHoraInicio: TLabel
          AlignWithMargins = True
          Left = 10
          Top = 8
          Width = 119
          Height = 22
          Margins.Left = 10
          Margins.Top = 8
          Align = alLeft
          Caption = 'Data/Hora In'#237'cio: %s'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12615680
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ExplicitHeight = 16
        end
      end
      object Panel2: TPanel
        Left = 1
        Top = 34
        Width = 384
        Height = 33
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object lblDataHoraFim: TLabel
          AlignWithMargins = True
          Left = 10
          Top = 8
          Width = 110
          Height = 22
          Margins.Left = 10
          Margins.Top = 8
          Align = alLeft
          Caption = 'Data/Hora Fim: %s'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12615680
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ExplicitHeight = 16
        end
      end
      object Panel3: TPanel
        Left = 1
        Top = 67
        Width = 384
        Height = 33
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 2
        object lblTempoExecucao: TLabel
          AlignWithMargins = True
          Left = 10
          Top = 8
          Width = 142
          Height = 22
          Margins.Left = 10
          Margins.Top = 8
          Align = alLeft
          Caption = 'Tempo de execu'#231#227'o: %s'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12615680
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ExplicitHeight = 16
        end
      end
      object Panel4: TPanel
        Left = 1
        Top = 100
        Width = 384
        Height = 33
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 3
        object lblQuantidadeAcertos: TLabel
          AlignWithMargins = True
          Left = 10
          Top = 8
          Width = 258
          Height = 22
          Margins.Left = 10
          Margins.Top = 8
          Align = alLeft
          Caption = 'Quantidade de Acertos: %s de %s Quest'#245'es.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 12615680
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ExplicitHeight = 16
        end
      end
    end
  end
end
