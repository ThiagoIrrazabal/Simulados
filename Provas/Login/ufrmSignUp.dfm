object frmSignUp: TfrmSignUp
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 401
  ClientWidth = 255
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlImgLogin: TGridPanel
    Left = 0
    Top = 25
    Width = 255
    Height = 160
    Align = alTop
    BevelOuter = bvNone
    ColumnCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        ColumnSpan = 2
        Control = pnlImage
        Row = 0
      end>
    RowCollection = <
      item
        Value = 100.000000000000000000
      end>
    TabOrder = 0
    DesignSize = (
      255
      160)
    object pnlImage: TPanel
      Left = 69
      Top = 24
      Width = 117
      Height = 112
      Anchors = []
      BevelOuter = bvNone
      Color = clSilver
      TabOrder = 0
      object imgEdit: TImage
        Left = 90
        Top = 85
        Width = 21
        Height = 21
        Stretch = True
        OnMouseEnter = imgLoginMouseEnter
        OnMouseLeave = imgLoginMouseLeave
      end
      object pnlCircle: TPanel
        AlignWithMargins = True
        Left = 15
        Top = 15
        Width = 87
        Height = 82
        Margins.Left = 15
        Margins.Top = 15
        Margins.Right = 15
        Margins.Bottom = 15
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object imgLogin: TImage
          AlignWithMargins = True
          Left = 1
          Top = 1
          Width = 85
          Height = 80
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alClient
          Center = True
          Stretch = True
          OnMouseEnter = imgLoginMouseEnter
          OnMouseLeave = imgLoginMouseLeave
          ExplicitLeft = 23
          ExplicitTop = 23
          ExplicitWidth = 57
          ExplicitHeight = 52
        end
      end
    end
  end
  object pnlBody: TGridPanel
    Left = 0
    Top = 185
    Width = 255
    Height = 216
    Align = alClient
    BevelOuter = bvNone
    ColumnCollection = <
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = pnlUser
        Row = 0
      end
      item
        Column = 0
        Control = pnlEnter
        Row = 4
      end
      item
        Column = 0
        Control = pnlPassword
        Row = 2
      end
      item
        Column = 0
        Control = pnlEmail
        Row = 1
      end
      item
        Column = 0
        Control = pnlCompartilharInformacoes
        Row = 3
      end>
    RowCollection = <
      item
        Value = 24.000000000000000000
      end
      item
        Value = 24.000000000000000000
      end
      item
        Value = 24.000000000000000000
      end
      item
        Value = 10.000000000000000000
      end
      item
        Value = 18.000000000000000000
      end
      item
        SizeStyle = ssAuto
      end>
    TabOrder = 1
    object pnlUser: TPanel
      Left = 0
      Top = 0
      Width = 255
      Height = 51
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object lblUser: TLabel
        AlignWithMargins = True
        Left = 10
        Top = 3
        Width = 27
        Height = 13
        Margins.Left = 10
        Margins.Right = 10
        Align = alTop
        Caption = 'Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object pnlEdtUserBorder: TPanel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Width = 235
        Height = 24
        Margins.Left = 10
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object pnlEdtUser: TPanel
          AlignWithMargins = True
          Left = 1
          Top = 1
          Width = 233
          Height = 22
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alClient
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 0
          object imgUser: TImage
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 19
            Height = 16
            Align = alLeft
            Stretch = True
            ExplicitHeight = 19
          end
          object edtUser: TEdit
            AlignWithMargins = True
            Left = 25
            Top = 4
            Width = 208
            Height = 18
            Margins.Left = 0
            Margins.Top = 4
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alClient
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 100
            ParentFont = False
            TabOrder = 0
            Text = 'Name'
            OnChange = edtUserChange
            OnEnter = edtUserEnter
            OnExit = edtUserExit
          end
        end
      end
    end
    object pnlEnter: TPanel
      Left = 0
      Top = 174
      Width = 255
      Height = 38
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object pnlSignUp: TPanel
        AlignWithMargins = True
        Left = 10
        Top = 2
        Width = 235
        Height = 34
        Margins.Left = 10
        Margins.Top = 2
        Margins.Right = 10
        Margins.Bottom = 2
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Sign Up'
        Color = 16744448
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        OnClick = pnlSignUpClick
        OnMouseEnter = pnlSignUpMouseEnter
        OnMouseLeave = pnlSignUpMouseLeave
      end
    end
    object pnlPassword: TPanel
      Left = 0
      Top = 102
      Width = 255
      Height = 51
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object lblPassword: TLabel
        AlignWithMargins = True
        Left = 10
        Top = 3
        Width = 46
        Height = 13
        Margins.Left = 10
        Margins.Right = 10
        Align = alTop
        Caption = 'Password'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object pnlEdtPasswordBorder: TPanel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Width = 235
        Height = 24
        Margins.Left = 10
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object pnlEdtPassword: TPanel
          AlignWithMargins = True
          Left = 1
          Top = 1
          Width = 233
          Height = 22
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alClient
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 0
          object imgPassword: TImage
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 19
            Height = 16
            Align = alLeft
            Proportional = True
            Stretch = True
            ExplicitHeight = 19
          end
          object edtPassword: TEdit
            AlignWithMargins = True
            Left = 25
            Top = 4
            Width = 208
            Height = 18
            Margins.Left = 0
            Margins.Top = 4
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alClient
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 20
            ParentFont = False
            PasswordChar = '*'
            TabOrder = 0
            Text = 'Password'
            OnEnter = edtPasswordEnter
            OnExit = edtPasswordExit
            OnKeyDown = edtPasswordKeyDown
          end
        end
      end
    end
    object pnlEmail: TPanel
      Left = 0
      Top = 51
      Width = 255
      Height = 51
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object lblEmail: TLabel
        AlignWithMargins = True
        Left = 10
        Top = 3
        Width = 28
        Height = 13
        Margins.Left = 10
        Margins.Right = 10
        Align = alTop
        Caption = 'E-Mail'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object pnlEdtEmailBorder: TPanel
        AlignWithMargins = True
        Left = 10
        Top = 22
        Width = 235
        Height = 24
        Margins.Left = 10
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object pnlEdtEmail: TPanel
          AlignWithMargins = True
          Left = 1
          Top = 1
          Width = 233
          Height = 22
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alClient
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 0
          object imgEmail: TImage
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 19
            Height = 16
            Align = alLeft
            Stretch = True
            ExplicitHeight = 19
          end
          object edtEmail: TEdit
            AlignWithMargins = True
            Left = 25
            Top = 4
            Width = 208
            Height = 18
            Margins.Left = 0
            Margins.Top = 4
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alClient
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            MaxLength = 100
            ParentFont = False
            TabOrder = 0
            Text = 'E-Mail'
            OnChange = edtEmailChange
            OnEnter = edtEmailEnter
            OnExit = edtEmailExit
          end
        end
      end
    end
    object pnlCompartilharInformacoes: TPanel
      Left = 0
      Top = 153
      Width = 255
      Height = 21
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      object ckbCompartilhar: TCheckBox
        AlignWithMargins = True
        Left = 10
        Top = 3
        Width = 145
        Height = 15
        Margins.Left = 10
        Margins.Right = 10
        Align = alLeft
        Caption = 'Compartilhar informa'#231#245'es'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 0
      end
    end
  end
  object pnlClose: TPanel
    Left = 0
    Top = 0
    Width = 255
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object pnlCloseButton: TPanel
      AlignWithMargins = True
      Left = 230
      Top = 2
      Width = 23
      Height = 23
      Margins.Left = 0
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 0
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
  object dlgImage: TOpenDialog
    Left = 112
    Top = 184
  end
end
