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
    constructor Create(const DataHoraInicio, DataHoraFim: TDateTime;
      const NumeroProva, QuantidadeAcertos: Integer); overload;
    destructor Destroy; override;
    class function New(const DataHoraInicio, DataHoraFim: TDateTime;
      const NumeroProva, QuantidadeAcertos: Integer): TfrmResultado;
  end;

var
  frmResultado: TfrmResultado;

implementation

{$R *.dfm}

constructor TfrmResultado.Create(const DataHoraInicio, DataHoraFim: TDateTime;
  const NumeroProva, QuantidadeAcertos: Integer);
begin
  inherited Create(nil);
  lblProva.Caption := Format(lblProva.Caption, [NumeroProva.ToString]);
  lblDataHoraInicio.Caption := Format(lblDataHoraInicio.Caption, [FormatDateTime('dd/mm/yyyy hh:nn:ss', DataHoraInicio)]);
  lblDataHoraFim.Caption := Format(lblDataHoraFim.Caption, [FormatDateTime('dd/mm/yyyy hh:nn:ss', DataHoraFim)]);
  lblQuantidadeAcertos.Caption := Format(lblQuantidadeAcertos.Caption, [QuantidadeAcertos.ToString, '60']);
  lblTempoExecucao.Caption := Format(lblTempoExecucao.Caption, [FormatDateTime('hh:nn:ss', DataHoraFim - DataHoraInicio)]);
  Position := poScreenCenter;
  AlphaBlend := True;
  AlphaBlendValue := 200;
  FFrmEsmaecer := TfrmEsmaecer.New(Self);
  Self.BringToFront;
end;

destructor TfrmResultado.Destroy;
begin
  if Assigned(FFrmEsmaecer) then
    FreeAndNil(FFrmEsmaecer);

  inherited Destroy;
end;

class function TfrmResultado.New(const DataHoraInicio, DataHoraFim: TDateTime;
  const NumeroProva, QuantidadeAcertos: Integer): TfrmResultado;
begin
  Result := Self.Create(DataHoraInicio, DataHoraFim, NumeroProva, QuantidadeAcertos);
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
