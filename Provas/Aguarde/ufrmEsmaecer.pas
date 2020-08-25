unit ufrmEsmaecer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TfrmEsmaecer = class(TForm)
    procedure FormActivate(Sender: TObject);
  strict private
    FFormOwner: TForm;
  private
    { Private declarations }
  public
    { Public declarations }
    class function New(AForm: TForm): TfrmEsmaecer;
  end;

implementation

{$R *.dfm}

{ TfrmEsmaecer }

procedure TfrmEsmaecer.FormActivate(Sender: TObject);
begin
  if Assigned(FFormOwner) then
    FFormOwner.BringToFront;
end;

class function TfrmEsmaecer.New(AForm: TForm): TfrmEsmaecer;
begin
  Result := Self.Create(nil);
  Result.FFormOwner := AForm;
  Result.Top := Screen.ActiveForm.Top;
  Result.Left := Screen.ActiveForm.Left;
  Result.Height := Screen.ActiveForm.Height;
  Result.Width := Screen.ActiveForm.Width;
  Result.AlphaBlend := True;
  Result.AlphaBlendValue := 180;
  Result.Show;
end;

end.
