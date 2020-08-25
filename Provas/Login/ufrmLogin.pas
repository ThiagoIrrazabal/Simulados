unit ufrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, uAcessToken;

type
  TfrmLogin = class(TForm)
    pnlImgLogin: TGridPanel;
    pnlImage: TPanel;
    pnlBody: TGridPanel;
    pnlUser: TPanel;
    lblUser: TLabel;
    pnlRemember: TPanel;
    ckbRememberme: TCheckBox;
    pnlEnter: TPanel;
    pnlLogin: TPanel;
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
    lblSignup: TLabel;
    pnlCircle: TPanel;
    imgLogin: TImage;
    pnlClose: TPanel;
    pnlCloseButton: TPanel;
    procedure edtUserEnter(Sender: TObject);
    procedure edtUserExit(Sender: TObject);
    procedure edtPasswordEnter(Sender: TObject);
    procedure edtPasswordExit(Sender: TObject);
    procedure lblSignupMouseEnter(Sender: TObject);
    procedure lblSignupMouseLeave(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pnlLoginMouseEnter(Sender: TObject);
    procedure pnlLoginMouseLeave(Sender: TObject);
    procedure lblSignupClick(Sender: TObject);
    procedure pnlImageMouseEnter(Sender: TObject);
    procedure pnlImageMouseLeave(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnlLoginClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure pnlCloseButtonClick(Sender: TObject);
    procedure pnlCloseButtonMouseEnter(Sender: TObject);
    procedure pnlCloseButtonMouseLeave(Sender: TObject);
  private
    { Private declarations }
    UserPath, Path: TFileName;
    BMP: TBitmap;
    JPG: TJPEGImage;
    PNG: TPngImage;
    FMaxLength: Integer;
    FAcessToken: string;
    FNome: string;
    FUsuario: Integer;
    FAdm: Boolean;
  public
    { Public declarations }
    property MaxLength: Integer read FMaxLength write FMaxLength;
    property AcessToken: string read FAcessToken write FAcessToken;
    property Usuario: Integer read FUsuario write FUsuario;
    property Nome: string read FNome write FNome;
    property Adm: Boolean read FAdm write FAdm;
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}
{$WARN SYMBOL_PLATFORM OFF}

uses ufrmSignUp, System.IniFiles, uRequisicoes, uMenu, System.JSON;

procedure TfrmLogin.edtPasswordEnter(Sender: TObject);
begin
  if (lblPassword.Font.Color = clRed) then
    pnlEdtPasswordBorder.Color := clRed
  else
    pnlEdtPasswordBorder.Color := clHighlight;

  if (edtPassword.Text = 'Password') then
    edtPassword.Clear;
end;

procedure TfrmLogin.edtPasswordExit(Sender: TObject);
begin
  pnlEdtPasswordBorder.Color := clBtnFace;

  if (edtPassword.Text = EmptyStr) then
    edtPassword.Text := 'Password';
end;

procedure TfrmLogin.edtPasswordKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    pnlLoginClick(pnlLogin);
end;

procedure TfrmLogin.edtUserEnter(Sender: TObject);
begin
  if (lblUser.Font.Color = clRed) then
    pnlEdtUserBorder.Color := clRed
  else
    pnlEdtUserBorder.Color := clHighlight;

  if (edtUser.Text = 'E-Mail') then
    edtUser.Clear;
end;

procedure TfrmLogin.edtUserExit(Sender: TObject);
begin
  pnlEdtUserBorder.Color := clBtnFace;

  if (edtUser.Text = EmptyStr) then
    edtUser.Text := 'E-Mail';
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
var
  IniFile: TIniFile;
  Attributes: Integer;
begin
  if Assigned(BMP) then
    FreeAndNil(BMP);
  if Assigned(PNG) then
    FreeAndNil(PNG);
  if Assigned(JPG) then
    FreeAndNil(JPG);

  if ckbRememberme.Checked and (FNome <> EmptyStr) then
  begin
    Attributes := faArchive + faNormal;
    FileSetAttr(Path + 'remember.ini', Attributes);

    IniFile := TIniFile.Create(Path + 'remember.ini');
    try
      IniFile.WriteString('Login', 'Username', edtUser.Text);
    finally
      FreeAndNil(IniFile);
    end;

    Attributes := faArchive + faHidden + faReadOnly;
    FileSetAttr(Path + 'remember.ini', Attributes);
  end;
end;

procedure TfrmLogin.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
    Close;
end;

procedure TfrmLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    Perform(WM_NEXTDLGCTL,0,0);
end;

procedure TfrmLogin.FormShow(Sender: TObject);
var
  Attributes: Integer;
  BX: TRect;
  mdo: HRGN;
  IniFile: TIniFile;
begin
  edtUser.MaxLength := FMaxLength;
  Path := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  UserPath := Path + 'users';
  if not DirectoryExists(UserPath) then
    ForceDirectories(UserPath);

  Attributes := faDirectory + faHidden;
  FileSetAttr(UserPath, Attributes);

  with pnlCircle do
  begin
    BX := ClientRect;
    mdo := CreateRoundRectRgn(BX.Left, BX.Top, BX.Right,
    BX.Bottom, 100, 100);
    Perform(EM_GETRECT, 0, lParam(@BX));
    InflateRect(BX, - 4, - 4);
    Perform(EM_SETRECTNP, 0, lParam(@BX));
    SetWindowRgn(Handle, mdo, True);
    Invalidate;
  end;

  IniFile := TIniFile.Create(Path + 'remember.ini');
  try
    edtUser.Text := IniFile.ReadString('Login', 'Username', 'E-Mail');
    ckbRememberme.Checked := (edtUser.Text <> 'E-Mail');
  finally
    FreeAndNil(IniFile);
  end;
end;

procedure TfrmLogin.lblSignupClick(Sender: TObject);
var
  frmSignUp: TfrmSignUp;
begin
  frmSignUp := TfrmSignUp.Create(Self);
  try
    frmSignUp.MaxLength := FMaxLength;
    frmSignUp.ShowModal;
  finally
    FreeAndNil(frmSignUp);
  end;
end;

procedure TfrmLogin.lblSignupMouseEnter(Sender: TObject);
begin
  lblSignup.Cursor := crHandPoint;
end;

procedure TfrmLogin.lblSignupMouseLeave(Sender: TObject);
begin
  lblSignup.Cursor := crDefault;
end;

procedure TfrmLogin.pnlImageMouseEnter(Sender: TObject);
begin
  imgLogin.Margins.Left := 0;
  imgLogin.Margins.Top := 0;
  imgLogin.Margins.Right := 0;
  imgLogin.Margins.Bottom := 0;
end;

procedure TfrmLogin.pnlImageMouseLeave(Sender: TObject);
begin
  imgLogin.Margins.Left := 1;
  imgLogin.Margins.Top := 1;
  imgLogin.Margins.Right := 1;
  imgLogin.Margins.Bottom := 1;
end;

procedure TfrmLogin.pnlLoginClick(Sender: TObject);
var
  ReqAccessToken, ReqUsuario: IRequisicoes;
  AccessToken: TAcessToken;
  JSON: TJSONObject;
begin
  lblUser.Caption := 'E-Mail';
  lblUser.Font.Color := clGray;
  if (edtUser.Focused) then
    pnlEdtUserBorder.Color := clHighlight
  else pnlEdtUserBorder.Color := clBtnFace;

  lblPassword.Caption := 'Password';
  lblPassword.Font.Color := clGray;
  if (edtPassword.Focused) then
    pnlEdtPasswordBorder.Color := clHighlight
  else pnlEdtPasswordBorder.Color := clBtnFace;

  if (edtUser.Text <> EmptyStr) and (edtPassword.Text <> EmptyStr) then
  begin
    if (edtUser.Text <> 'E-Mail') and (edtPassword.Text <> 'Password') then
    begin
      ReqAccessToken := TRequisicoes.New
                                 .EndPoint('simuladosapi/v1/TApiMethods/login')
                                 .Body(UTF8String('{' + #13#10 +
                                                        '"email": "' + edtUser.Text + '",' + #13#10 +
                                                        '"senha": "' + edtPassword.Text + '"' + #13#10 +
                                                   '}'))
                                 .Post;
      try
        AccessToken := TAcessToken.FromJSONString(ReqAccessToken.JSONResponse);
        try
          if (ReqAccessToken.ResponseCode = 200) then
          begin
            FAcessToken := AccessToken.access_token;
            FUsuario := AccessToken.id;
            if (FAcessToken <> EmptyStr) then
            begin
              ReqUsuario := TRequisicoes.New
                                        .EndPoint('simuladosapi/v1/TApiMethods/user')
                                        .Body(UTF8String('{' + #13#10 +
                                                                '"email": "' + edtUser.Text + '",' + #13#10 +
                                                                '"senha": "' + edtPassword.Text + '"' + #13#10 +
                                                          '}'))
                                        .Post;
              try
                JSON := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ReqUsuario.JSONResponse), 0) as TJSONObject;
                try
                  Self.Nome := JSON.Values['nome'].Value;
                  Self.Adm := (JSON.Values['adm'].Value.ToUpper = 'TRUE');
                finally
                  FreeAndNil(JSON);
                end;
              finally
                ReqUsuario := nil;
              end;
              Self.ModalResult := mrOk;
            end
            else
            begin
              if (AccessToken.email_password = 'E') then
              begin
                lblUser.Caption := 'E-Mail is not valid.';
                lblUser.Font.Color := clRed;
                pnlEdtUserBorder.Color := clRed;
                edtUser.SetFocus;
              end
              else
              begin
                lblPassword.Caption := 'Password is not valid.';
                lblPassword.Font.Color := clRed;
                pnlEdtPasswordBorder.Color := clRed;
                edtPassword.SetFocus;
              end;
            end;
          end
          else
          begin
            lblUser.Caption := 'E-Mail or password is not valid.';
            lblUser.Font.Color := clRed;
            pnlEdtUserBorder.Color := clRed;
            edtUser.SetFocus;
          end;
        finally
          FreeAndNil(AccessToken);
        end;
      finally
        ReqAccessToken := nil;
      end;
    end;
  end;
end;

procedure TfrmLogin.pnlCloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLogin.pnlCloseButtonMouseEnter(Sender: TObject);
begin
  pnlCloseButton.Cursor := crHandPoint;
end;

procedure TfrmLogin.pnlCloseButtonMouseLeave(Sender: TObject);
begin
  pnlCloseButton.Cursor := crDefault;
end;

procedure TfrmLogin.pnlLoginMouseEnter(Sender: TObject);
begin
  pnlLogin.Cursor := crHandPoint;
  pnlLogin.Margins.Left := 8;
  pnlLogin.Margins.Top := 8;
  pnlLogin.Margins.Right := 8;
  pnlLogin.Margins.Bottom := 8;
end;

procedure TfrmLogin.pnlLoginMouseLeave(Sender: TObject);
begin
  pnlLogin.Cursor := crDefault;
  pnlLogin.Margins.Left := 10;
  pnlLogin.Margins.Top := 10;
  pnlLogin.Margins.Right := 10;
  pnlLogin.Margins.Bottom := 10;
end;

end.
