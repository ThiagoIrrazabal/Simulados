unit ufrmResultado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, ufrmEsmaecer;

type
  TfrmResultado = class(TForm)
    pnlBackGround: TPanel;
    pnlProva: TPanel;
    lblProva: TLabel;
    GridPanel1: TGridPanel;
    Panel1: TPanel;
    lblDataHoraInicio: TLabel;
    Panel2: TPanel;
    lblDataHoraFim: TLabel;
    Panel3: TPanel;
    lblTempoExecucao: TLabel;
    Panel4: TPanel;
    lblQuantidadeAcertos: TLabel;
    pnlCloseButton: TPanel;
    procedure pnlCloseButtonClick(Sender: TObject);
    procedure pnlCloseButtonMouseEnter(Sender: TObject);
    procedure pnlCloseButtonMouseLeave(Sender: TObject);
  private
  var
    FFrmEsmaecer: TfrmEsmaecer;
  public
    destructor Destroy; override;
    class function New(const DataHoraInicio, DataHoraFim: TDateTime;
      const NumeroProva, QuantidadeAcertos: Integer): TfrmResultado;
  end;

var
  frmResultado: TfrmResultado;

implementation

{$R *.dfm}

destructor TfrmResultado.Destroy;
begin
  if Assigned(FFrmEsmaecer) then
    FreeAndNil(FFrmEsmaecer);

  inherited Destroy;
end;

class function TfrmResultado.New(const DataHoraInicio, DataHoraFim: TDateTime;
  const NumeroProva, QuantidadeAcertos: Integer): TfrmResultado;
begin
  Result := Self.Create(nil);
  Result.lblProva.Caption := Format(Result.lblProva.Caption, [NumeroProva.ToString]);
  Result.lblDataHoraInicio.Caption := Format(Result.lblDataHoraInicio.Caption, [FormatDateTime('dd/mm/yyyy hh:nn:ss', DataHoraInicio)]);
  Result.lblDataHoraFim.Caption := Format(Result.lblDataHoraFim.Caption, [FormatDateTime('dd/mm/yyyy hh:nn:ss', DataHoraFim)]);
  Result.lblQuantidadeAcertos.Caption := Format(Result.lblQuantidadeAcertos.Caption, [QuantidadeAcertos.ToString, '60']);
  Result.lblTempoExecucao.Caption := Format(Result.lblTempoExecucao.Caption, [FormatDateTime('hh:nn:ss', DataHoraFim - DataHoraInicio)]);
  Result.Position := poScreenCenter;
  Result.AlphaBlend := True;
  Result.AlphaBlendValue := 200;
  Result.FFrmEsmaecer := TfrmEsmaecer.New(Result);
  Application.ProcessMessages;
end;

procedure TfrmResultado.pnlCloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmResultado.pnlCloseButtonMouseEnter(Sender: TObject);
begin
  pnlCloseButton.Cursor := crHandPoint;
end;

procedure TfrmResultado.pnlCloseButtonMouseLeave(Sender: TObject);
begin
  pnlCloseButton.Cursor := crDefault;
end;

end.
