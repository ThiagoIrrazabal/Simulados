unit ufrmQuestao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Menus,
  Vcl.AppEvnts;

type
  TfrmQuestao = class(TForm)
    pnlBackGround: TPanel;
    mmPergunta: TMemo;
    pnlResposta1: TPanel;
    ckbResposta1: TCheckBox;
    mmResposta1: TMemo;
    pnlResposta2: TPanel;
    ckbResposta2: TCheckBox;
    mmResposta2: TMemo;
    pnlResposta3: TPanel;
    ckbResposta3: TCheckBox;
    mmResposta3: TMemo;
    pnlResposta4: TPanel;
    ckbResposta4: TCheckBox;
    mmResposta4: TMemo;
    pnlQuestao: TPanel;
    lblQuestao: TLabel;
    ppmBookMark: TPopupMenu;
    BookMark1: TMenuItem;
    ppmDeletarBookMark: TPopupMenu;
    DeletarBookMark1: TMenuItem;
    pnlResposta5: TPanel;
    ckbResposta5: TCheckBox;
    mmResposta5: TMemo;
    pnlResposta6: TPanel;
    ckbResposta6: TCheckBox;
    mmResposta6: TMemo;
    ApplicationEvents1: TApplicationEvents;
    pnlCloseButton: TPanel;
    procedure BookMark1Click(Sender: TObject);
    procedure DeletarBookMark1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure pnlCloseButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Pergunta: Integer;
    PanelBookMark: TPanel;
    Click: procedure(Sender: TObject) of Object;
  end;

var
  frmQuestao: TfrmQuestao;

implementation

{$R *.dfm}

procedure TfrmQuestao.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
var
  i: SmallInt;

  procedure Scrollar(const Memo: TMemo);
  begin
    if (Msg.wParam = 4287102976) then
    begin
      i := Memo.Perform(EM_LINEINDEX, 0, 0);
      Memo.Perform(EM_LINESCROLL, 0, i + 1);
    end
    else if (Msg.wParam = 7864320) then
    begin
      i := Memo.Perform(EM_LINEINDEX, 0, 0);
      Memo.Perform(EM_LINESCROLL, 0, i - 1);
    end;
  end;
begin
  try
    if Msg.message = WM_MOUSEWHEEL then
    begin
      if (mmPergunta.Lines.Count > 1) and
        (Mouse.CursorPos.Y >= (Self.Top + mmPergunta.Top + 60)) and
        (Mouse.CursorPos.Y <= (Self.Top + mmPergunta.Top + mmPergunta.Height + 60)) then
        Scrollar(mmPergunta)
      else if (mmResposta1.Lines.Count > 1) and
        (Mouse.CursorPos.Y >= (Self.Top + pnlResposta1.Top + 60)) and
        (Mouse.CursorPos.Y <= (Self.Top + pnlResposta1.Top + pnlResposta1.Height + 60)) then
        Scrollar(mmResposta1)
      else if (mmResposta2.Lines.Count > 1) and
        (Mouse.CursorPos.Y >= (Self.Top + pnlResposta2.Top + 60)) and
        (Mouse.CursorPos.Y <= (Self.Top + pnlResposta2.Top + pnlResposta2.Height + 60)) then
        Scrollar(mmResposta2)
      else if (mmResposta3.Lines.Count > 1) and
        (Mouse.CursorPos.Y >= (Self.Top + pnlResposta3.Top + 60)) and
        (Mouse.CursorPos.Y <= (Self.Top + pnlResposta3.Top + pnlResposta3.Height + 60)) then
        Scrollar(mmResposta3)
      else if (mmResposta4.Lines.Count > 1) and
        (Mouse.CursorPos.Y >= (Self.Top + pnlResposta4.Top + 60)) and
        (Mouse.CursorPos.Y <= (Self.Top + pnlResposta4.Top + pnlResposta4.Height + 60)) then
        Scrollar(mmResposta4)
      else if (mmResposta5.Lines.Count > 1) and
        (Mouse.CursorPos.Y >= (Self.Top + pnlResposta5.Top + 60)) and
        (Mouse.CursorPos.Y <= (Self.Top + pnlResposta5.Top + pnlResposta5.Height + 60)) then
        Scrollar(mmResposta5)
      else if (mmResposta6.Lines.Count > 1) and
        (Mouse.CursorPos.Y >= (Self.Top + pnlResposta6.Top + 60)) and
        (Mouse.CursorPos.Y <= (Self.Top + pnlResposta6.Top + pnlResposta6.Height + 60)) then
        Scrollar(mmResposta6);
    end;
  except
  end;
end;

procedure TfrmQuestao.BookMark1Click(Sender: TObject);
var
  Button: TButton;
begin
  Button := TButton.Create(PanelBookMark);
  Button.Name := 'btnBookMark' + Pergunta.ToString;
  Button.Align := alLeft;
  Button.Width := 25;
  Button.Caption := Pergunta.ToString;
  Button.AlignWithMargins := True;
  Button.Margins.Top := 8;
  Button.Margins.Left := 5;
  Button.Margins.Right := 0;
  Button.Margins.Bottom := 8;
  Button.Tag := Pergunta;
  Button.OnClick := Click;
  Button.Parent := PanelBookMark;
  Button.PopupMenu := ppmDeletarBookMark;
  Button.Left := 1500;
end;

procedure TfrmQuestao.DeletarBookMark1Click(Sender: TObject);
begin
  ppmDeletarBookMark.PopupComponent.Free;
end;

procedure TfrmQuestao.FormCreate(Sender: TObject);
begin
  pnlResposta1.Visible := False;
  pnlResposta2.Visible := False;
  pnlResposta3.Visible := False;
  pnlResposta4.Visible := False;
  pnlResposta5.Visible := False;
  pnlResposta6.Visible := False;
end;

procedure TfrmQuestao.pnlCloseButtonClick(Sender: TObject);
begin
  Close;
end;

end.
