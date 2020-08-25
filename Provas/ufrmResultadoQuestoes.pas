unit ufrmResultadoQuestoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.AppEvnts, Datasnap.DBClient;

type
  TfrmResultadoQuestoes = class(TForm)
    pnlBackGround: TPanel;
    pnlQuestao: TPanel;
    lblQuestao: TLabel;
    Panel1: TPanel;
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
    pnlResposta5: TPanel;
    ckbResposta5: TCheckBox;
    mmResposta5: TMemo;
    pnlResposta6: TPanel;
    ckbResposta6: TCheckBox;
    mmResposta6: TMemo;
    mmPergunta: TMemo;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ApplicationEvents1: TApplicationEvents;
    ClientDataSet1: TClientDataSet;
    Timer1: TTimer;
    pnlCloseButton: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure pnlCloseButtonClick(Sender: TObject);
  private
    FIDUsuarioProva: Integer;
    { Private declarations }
    procedure JsonToDataset(aDataset : TDataSet; aJSON : string);
  public
    { Public declarations }
    Pergunta: Integer;
    IDPergunta: Integer;
    procedure BuscarRespostas;
    property IDUsuarioProva: Integer read FIDUsuarioProva write FIDUsuarioProva;
  end;

var
  frmResultadoQuestoes: TfrmResultadoQuestoes;

implementation

{$R *.dfm}

uses uRequisicoes, REST.Response.Adapter, System.JSON;

procedure TfrmResultadoQuestoes.ApplicationEvents1Message(var Msg: tagMSG;
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

procedure TfrmResultadoQuestoes.BuscarRespostas;
begin
  Timer1.Enabled := True;
end;

procedure TfrmResultadoQuestoes.FormCreate(Sender: TObject);
begin
  pnlResposta1.Visible := False;
  pnlResposta2.Visible := False;
  pnlResposta3.Visible := False;
  pnlResposta4.Visible := False;
  pnlResposta5.Visible := False;
  pnlResposta6.Visible := False;
  FIDUsuarioProva := 0;
end;

procedure TfrmResultadoQuestoes.JsonToDataset(aDataset: TDataSet;
  aJSON: string);
var
  JObj: TJSONArray;
  vConv : TCustomJSONDataSetAdapter;
begin
  if (aJSON = EmptyStr) then
  begin
    Exit;
  end;

  JObj := TJSONObject.ParseJSONValue(aJSON) as TJSONArray;
  vConv := TCustomJSONDataSetAdapter.Create(Nil);

  try
    vConv.Dataset := aDataset;
    vConv.UpdateDataSet(JObj);
  finally
    vConv.Free;
    JObj.Free;
  end;
end;

procedure TfrmResultadoQuestoes.pnlCloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmResultadoQuestoes.Timer1Timer(Sender: TObject);
var
  ReqUsuariosQuestoes: IRequisicoes;
  JSON: string;
begin
  Timer1.Enabled := False;
  ReqUsuariosQuestoes := TRequisicoes.New
                                     .EndPoint('simuladosapi/v1/TApiMethods/ProvasPerguntas/' + IDPergunta.ToString + '/' + FIDUsuarioProva.ToString)
                                     .Get;
  try
    JSON := ReqUsuariosQuestoes.JSONResponse.Replace('{"respostas":', '', [rfIgnoreCase]);
    JSON := Copy(JSON, 1, Length(JSON) - 1);
    JsonToDataset(ClientDataSet1, JSON);
  finally
    ReqUsuariosQuestoes := nil;
  end;
end;

end.
