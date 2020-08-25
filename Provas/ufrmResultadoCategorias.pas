unit ufrmResultadoCategorias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, ufrmEsmaecer,
  Vcl.Samples.Gauges;

type
  TfrmResultadoCategorias = class(TForm)
    pnlBackGround: TPanel;
    pnlProva: TPanel;
    lblProva: TLabel;
    pnlCloseButton: TPanel;
    Panel5: TPanel;
    btnVerQuestoes: TButton;
    pnlCategoria11: TPanel;
    progress11: TGauge;
    pnlDescricaoCategoria11: TPanel;
    pnlCategoria10: TPanel;
    progress10: TGauge;
    pnlDescricaoCategoria10: TPanel;
    pnlCategoria9: TPanel;
    progress9: TGauge;
    pnlDescricaoCategoria9: TPanel;
    pnlCategoria8: TPanel;
    progress8: TGauge;
    pnlDescricaoCategoria8: TPanel;
    pnlCategoria7: TPanel;
    progress7: TGauge;
    pnlDescricaoCategoria7: TPanel;
    pnlCategoria6: TPanel;
    progress6: TGauge;
    pnlDescricaoCategoria6: TPanel;
    pnlCategoria5: TPanel;
    progress5: TGauge;
    pnlDescricaoCategoria5: TPanel;
    pnlCategoria4: TPanel;
    progress4: TGauge;
    pnlDescricaoCategoria4: TPanel;
    pnlCategoria3: TPanel;
    progress3: TGauge;
    pnlDescricaoCategoria3: TPanel;
    pnlCategoria2: TPanel;
    progress2: TGauge;
    pnlDescricaoCategoria2: TPanel;
    pnlCategoria1: TPanel;
    progress1: TGauge;
    pnlDescricaoCategoria1: TPanel;
    procedure pnlCloseButtonClick(Sender: TObject);
    procedure pnlCloseButtonMouseEnter(Sender: TObject);
    procedure pnlCloseButtonMouseLeave(Sender: TObject);
    procedure btnVerQuestoesClick(Sender: TObject);
  private
  var
    FFrmEsmaecer: TfrmEsmaecer;
    FVerQuestoes: Boolean;
  public
    destructor Destroy; override;
    class function New(const NumeroProva: Integer): TfrmResultadoCategorias;
    property VerQuestoes: Boolean read FVerQuestoes write FVerQuestoes;
  end;

var
  frmResultadoCategorias: TfrmResultadoCategorias;

implementation

{$R *.dfm}

procedure TfrmResultadoCategorias.btnVerQuestoesClick(Sender: TObject);
begin
  FVerQuestoes := True;
  ModalResult := mrOk;
end;

destructor TfrmResultadoCategorias.Destroy;
begin
  if Assigned(FFrmEsmaecer) then
    FreeAndNil(FFrmEsmaecer);

  inherited Destroy;
end;

class function TfrmResultadoCategorias.New(const NumeroProva: Integer): TfrmResultadoCategorias;
begin
  Result := Self.Create(nil);
  Result.lblProva.Caption := Format(Result.lblProva.Caption, [NumeroProva.ToString]);
  Result.Position := poScreenCenter;
  Result.AlphaBlend := True;
  Result.AlphaBlendValue := 200;
  Result.FFrmEsmaecer := TfrmEsmaecer.New(Result);
  Application.ProcessMessages;
end;

procedure TfrmResultadoCategorias.pnlCloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmResultadoCategorias.pnlCloseButtonMouseEnter(Sender: TObject);
begin
  pnlCloseButton.Cursor := crHandPoint;
end;

procedure TfrmResultadoCategorias.pnlCloseButtonMouseLeave(Sender: TObject);
begin
  pnlCloseButton.Cursor := crDefault;
end;

end.
