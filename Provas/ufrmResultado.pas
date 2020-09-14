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
  end;

var
  frmResultado: TfrmResultado;

implementation

{$R *.dfm}

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
