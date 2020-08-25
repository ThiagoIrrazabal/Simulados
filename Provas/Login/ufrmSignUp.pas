unit ufrmSignUp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ExtDlgs,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage;

type
  TfrmSignUp = class(TForm)
    pnlImgLogin: TGridPanel;
    pnlImage: TPanel;
    pnlBody: TGridPanel;
    pnlUser: TPanel;
    lblUser: TLabel;
    pnlEnter: TPanel;
    pnlSignUp: TPanel;
    pnlEdtUserBorder: TPanel;
    pnlEdtUser: TPanel;
    edtUser: TEdit;
    imgUser: TImage;
    pnlPassword: TPanel;
    lblPassword: TLabel;
    pnlEdtPasswordBorder: TPanel;
    pnlEdtPassword: TPanel;
    imgPassword: TImage;
    edtPassword: TEdit;
    imgEdit: TImage;
    dlgImage: TOpenDialog;
    pnlCircle: TPanel;
    imgLogin: TImage;
    pnlEmail: TPanel;
    lblEmail: TLabel;
    pnlEdtEmailBorder: TPanel;
    pnlEdtEmail: TPanel;
    imgEmail: TImage;
    edtEmail: TEdit;
    pnlClose: TPanel;
    pnlCloseButton: TPanel;
    pnlCompartilharInformacoes: TPanel;
    ckbCompartilhar: TCheckBox;
    procedure edtUserEnter(Sender: TObject);
    procedure edtUserExit(Sender: TObject);
    procedure edtPasswordEnter(Sender: TObject);
    procedure edtPasswordExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pnlSignUpMouseEnter(Sender: TObject);
    procedure pnlSignUpMouseLeave(Sender: TObject);
    procedure imgLoginMouseEnter(Sender: TObject);
    procedure imgLoginMouseLeave(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnlSignUpClick(Sender: TObject);
    procedure edtUserChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmailChange(Sender: TObject);
    procedure edtEmailEnter(Sender: TObject);
    procedure edtEmailExit(Sender: TObject);
    procedure pnlCloseButtonClick(Sender: TObject);
    procedure pnlCloseButtonMouseEnter(Sender: TObject);
    procedure pnlCloseButtonMouseLeave(Sender: TObject);
    procedure edtPasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FTop, FLeft, FHeight, FWidth: Integer;
    BMP: TBitmap;
    JPG: TJPEGImage;
    PNG: TPngImage;
    Path: TFileName;
    FMaxLength: Integer;
  public
    { Public declarations }
    property MaxLength: Integer read FMaxLength write FMaxLength;
  end;

var
  frmSignUp: TfrmSignUp;

implementation

{$R *.dfm}

uses uRequisicoes, System.JSON, StrUtils, System.UITypes;

procedure TfrmSignUp.edtEmailChange(Sender: TObject);
begin
  if (lblEmail.Caption = 'E-Mail exists') then
  begin
    if not FileExists(Path + '\' + edtEmail.Text) then
    begin
      lblEmail.Caption := 'E-Mail';
      lblEmail.Font.Color := clGray;
    end;
  end;
end;

procedure TfrmSignUp.edtEmailEnter(Sender: TObject);
begin
  pnlEdtEmailBorder.Color := clHighlight;

  if (edtEmail.Text = 'E-Mail') then
    edtEmail.Clear;
end;

procedure TfrmSignUp.edtEmailExit(Sender: TObject);
begin
  pnlEdtEmailBorder.Color := clBtnFace;

  if (edtEmail.Text = EmptyStr) then
    edtEmail.Text := 'E-Mail';
end;

procedure TfrmSignUp.edtPasswordEnter(Sender: TObject);
begin
  pnlEdtPasswordBorder.Color := clHighlight;

  if (edtPassword.Text = 'Password') then
    edtPassword.Clear;
end;

procedure TfrmSignUp.edtPasswordExit(Sender: TObject);
begin
  pnlEdtPasswordBorder.Color := clBtnFace;

  if (edtPassword.Text = EmptyStr) then
    edtPassword.Text := 'Password';
end;

procedure TfrmSignUp.edtPasswordKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13) then
    pnlSignUpClick(pnlSignUp);
end;

procedure TfrmSignUp.edtUserChange(Sender: TObject);
begin
  if (lblUser.Caption = 'Name exists') then
  begin
    if not FileExists(Path + '\' + edtUser.Text) then
    begin
      lblUser.Caption := 'Name';
      lblUser.Font.Color := clGray;
    end;
  end;
end;

procedure TfrmSignUp.edtUserEnter(Sender: TObject);
begin
  pnlEdtUserBorder.Color := clHighlight;

  if (edtUser.Text = 'Name') then
    edtUser.Clear;
end;

procedure TfrmSignUp.edtUserExit(Sender: TObject);
begin
  pnlEdtUserBorder.Color := clBtnFace;

  if (edtUser.Text = EmptyStr) then
    edtUser.Text := 'Name';
end;

procedure TfrmSignUp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(BMP) then
    FreeAndNil(BMP);
  if Assigned(PNG) then
    FreeAndNil(PNG);
  if Assigned(JPG) then
    FreeAndNil(JPG);
end;

procedure TfrmSignUp.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
    Self.Close;
end;

procedure TfrmSignUp.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    Perform(WM_NEXTDLGCTL,0,0);
end;

procedure TfrmSignUp.FormShow(Sender: TObject);
var
  BX: TRect;
  mdo: HRGN;
begin
  edtUser.MaxLength := FMaxLength;
  Path := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'users';
  FTop := imgEdit.Top;
  FLeft := imgEdit.Left;
  FHeight := imgEdit.Height;
  FWidth := imgEdit.Width;

  with pnlCircle do
  begin
    BX := ClientRect;
    mdo := CreateRoundRectRgn(BX.Left, BX.Top, BX.Right,
    BX.Bottom, 75, 75);
    Perform(EM_GETRECT, 0, lParam(@BX));
    InflateRect(BX, 10, 10);
    Perform(EM_SETRECTNP, 0, lParam(@BX));
    SetWindowRgn(Handle, mdo, True);
    Invalidate;
  end;
end;

procedure TfrmSignUp.imgLoginMouseEnter(Sender: TObject);
begin
  imgEdit.Left := FLeft - 2;
  imgEdit.Top := FTop - 2;
  imgEdit.Height := FHeight + 4;
  imgEdit.Width := FWidth + 4;
end;

procedure TfrmSignUp.imgLoginMouseLeave(Sender: TObject);
begin
  imgEdit.Left := FLeft;
  imgEdit.Top := FTop;
  imgEdit.Height := FHeight;
  imgEdit.Width := FWidth;
end;

procedure TfrmSignUp.pnlCloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSignUp.pnlCloseButtonMouseEnter(Sender: TObject);
begin
  pnlCloseButton.Cursor := crHandPoint;
end;

procedure TfrmSignUp.pnlCloseButtonMouseLeave(Sender: TObject);
begin
  pnlCloseButton.Cursor := crDefault;
end;

procedure TfrmSignUp.pnlSignUpClick(Sender: TObject);
var
  Success, lExit: Boolean;
  ReqInsert: IRequisicoes;
  JSON: TJSONObject;
  Messages: string;
begin
  lExit := False;
  if (edtUser.Text = EmptyStr) or (edtUser.Text = 'Name') then
  begin
    lblUser.Caption := 'Enter name';
    lblUser.Font.Color := clRed;
    lExit := True;
  end
  else
  begin
    lblUser.Caption := 'Name';
    lblUser.Font.Color := clGray;
  end;

  if (edtEmail.Text = EmptyStr) or (edtEmail.Text = 'Name') then
  begin
    lblEmail.Caption := 'Enter name';
    lblEmail.Font.Color := clRed;
    lExit := True;
  end
  else
  begin
    lblEmail.Caption := 'Name';
    lblEmail.Font.Color := clGray;
  end;

  if (edtPassword.Text = EmptyStr) or (edtPassword.Text = 'Password') then
  begin
    lblPassword.Caption := 'Enter password';
    lblPassword.Font.Color := clRed;
    lExit := True;
  end
  else
  begin
    lblPassword.Caption := 'Password';
    lblPassword.Font.Color := clGray;
  end;

  if not(lExit) then
  begin
    ReqInsert := TRequisicoes.New
                             .EndPoint('simuladosapi/v1/TApiMethods/user')
                             .Body(UTF8String('{' + #13#10 +
                                                    '"nome": "' + edtUser.Text + '",' + #13#10 +
                                                    '"email": "' + edtEmail.Text + '",' + #13#10 +
                                                    '"senha": "' + edtPassword.Text + '",' + #13#10 +
                                                    '"compartilhar": "' + ifThen(ckbCompartilhar.Checked, 'True', 'False') + '"' + #13#10 +
                                               '}'))
                             .Post;
    JSON := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ReqInsert.JSONResponse), 0) as TJSONObject;
    try
      Success := JSON.Values['success'].AsType<Boolean>;
      Messages := JSON.Values['message'].Value;
      MessageDlg('Success: ' + ifThen(Success.ToString = '-1', 'True', 'False') + #13#10 + Messages, mtInformation, [mbOK], 0);
      Close;
    finally
      FreeAndNil(JSON);
    end;
  end;
end;

procedure TfrmSignUp.pnlSignUpMouseEnter(Sender: TObject);
begin
  pnlSignUp.Cursor := crHandPoint;
  pnlSignUp.Margins.Left := 8;
  pnlSignUp.Margins.Top := 8;
  pnlSignUp.Margins.Right := 8;
  pnlSignUp.Margins.Bottom := 8;
end;

procedure TfrmSignUp.pnlSignUpMouseLeave(Sender: TObject);
begin
  pnlSignUp.Cursor := crDefault;
  pnlSignUp.Margins.Left := 10;
  pnlSignUp.Margins.Top := 10;
  pnlSignUp.Margins.Right := 10;
  pnlSignUp.Margins.Bottom := 10;
end;

end.
