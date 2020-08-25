unit ufrmAguarde;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmEsmaecer, Vcl.ExtCtrls;

type
  TfrmAguarde = class(TForm)
    Panel1: TPanel;
  private
  var
    FFrmEsmaecer: TfrmEsmaecer;
    { Private declarations }
  public
    { Public declarations }
    destructor Destroy; override;
    class function New(const Mensagem: string): TfrmAguarde;
  end;

var
  frmAguarde: TfrmAguarde;

implementation

{$R *.dfm}

destructor TfrmAguarde.Destroy;
begin
  if Assigned(FFrmEsmaecer) then
    FreeAndNil(FFrmEsmaecer);

  inherited Destroy;
end;

class function TfrmAguarde.New(const Mensagem: string): TfrmAguarde;
begin
  Result := Self.Create(nil);
  Result.Panel1.Caption := Mensagem;
  Result.Position := poScreenCenter;
  Result.AlphaBlend := True;
  Result.AlphaBlendValue := 200;
  Result.FFrmEsmaecer := TfrmEsmaecer.New(Result);
  Result.Show;
  Application.ProcessMessages;
end;

end.
