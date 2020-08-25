unit uMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, uSisProvasJSON, ufrmQuestao, uSisUsuarioProvasJSON;

type
  TfrmMenu = class(TForm)
    pnlProvas: TPanel;
    pnlBackGround: TPanel;
    pnlTop: TPanel;
    pnlUsuario: TPanel;
    pnlTempo: TPanel;
    pnlNomeProva: TPanel;
    pnlProva: TPanel;
    pnlOpcoes: TPanel;
    imgDetailButton: TImage;
    lblSimulados: TLabel;
    tmrShow: TTimer;
    pnlBotoes: TPanel;
    btnVoltar: TButton;
    btnAvancar: TButton;
    tmrTempo: TTimer;
    pnlBookMarks: TPanel;
    procedure FormShow(Sender: TObject);
    procedure pnlOpcoesMouseEnter(Sender: TObject);
    procedure pnlOpcoesMouseLeave(Sender: TObject);
    procedure lblSimuladosClick(Sender: TObject);
    procedure tmrShowTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrTempoTimer(Sender: TObject);
    procedure pnlProvasResize(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAvancarClick(Sender: TObject);
  private
  var
    Provas: TProvas;
    Prova, Tempo, Contador: Integer;
    Sis_provas_perguntas: TSis_provas_perguntasClass;
    Sis_usuario_provas: TSis_usuario_provasClass;
    Sis_usuario_provas_perguntas: TSis_usuario_provas_perguntasClass;
    FrmQuestao: TfrmQuestao;
    ProvaIniciada: Boolean;
    Pergunta, OldPergunta: Integer;
    FAcessToken: string;
    FUsuario: Integer;
    FAdm: Boolean;
    FVerQuestoes: Boolean;
    procedure CriarPanelSimulado(const ID: Integer; const Descricao: string);
    procedure SimuladoClick(Sender: TObject);
    function FormatSecsToHMS(Secs: LongInt): string;
    procedure MouseEnter(Sender: TObject);
    procedure MouseLeave(Sender: TObject);
    procedure MudarQuestao(const Concluir: Boolean = False);
    procedure BookMarkClick(Sender: TObject);
    procedure IniciarProva;
    procedure ConsultaUsuarioProva;
    procedure IniciarUsuarioProva;
    procedure ConsultaUsuarioProvaPergunta;
    procedure ConsultaUsuarioProvaPerguntaMax;
    function ConsultaUsuarioProvaPerguntaProx(const ProximaOrdem: Integer): TSis_provas_perguntasClass;
    procedure IncluirUsuarioProvaPergunta;
    procedure ConsultaUsuarioProvaPerguntaResposta;
    procedure IncluirUsuarioProvaPerguntaRespotas;
    procedure Finalizar;
    procedure ProvaAdm;
    procedure ProvaNormal;
    procedure QuestaoAdm(const Concluir: Boolean);
    procedure QuestaoNormal(const Concluir: Boolean);
    procedure AvancarAdm;
    procedure AvancarNormal;
    procedure VoltarAdm;
    procedure VoltarNormal;
    procedure CloseForms(Sender: TObject; var Action: TCloseAction);
    { Private declarations }
  public
    { Public declarations }
    procedure ConsultarSimulados;
    destructor Destroy; override;
    property AcessToken: string read FAcessToken write FAcessToken;
    property Usuario: Integer read FUsuario write FUsuario;
    property Adm: Boolean read FAdm write FAdm;
    property VerQuestoes: Boolean read FVerQuestoes write FVerQuestoes;
  end;

var
  frmMenu: TfrmMenu;
  csCriticalSection: TRTLCriticalSection;

implementation

{$R *.dfm}

uses uRequisicoes, DateUtils, ufrmAguarde, ufrmResultado, Soap.XSBuiltIns,
  ufrmResultadoQuestoes, ufrmResultadoCategorias, uSisPerguntasCategoriasJSON;

procedure TfrmMenu.CloseForms(Sender: TObject; var Action: TCloseAction);
begin
  pnlBotoes.Visible := False;
  btnAvancar.Enabled := True;
  btnVoltar.Enabled := False;
  btnAvancar.Caption := 'Avançar';
  OldPergunta := 1;
  Pergunta := 1;
  tmrTempo.Enabled := False;
  Contador := 0;
  ProvaIniciada := False;
end;

procedure TfrmMenu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FrmQuestao) then
    FreeAndNil(FrmQuestao);

  if Assigned(Provas) then
    FreeAndNil(Provas);

  if Assigned(Sis_usuario_provas) then
    FreeAndNil(Sis_usuario_provas);

  if Assigned(Sis_usuario_provas_perguntas) then
    FreeAndNil(Sis_usuario_provas_perguntas);

  if Assigned(Sis_provas_perguntas) then
    FreeAndNil(Sis_provas_perguntas);
end;

procedure TfrmMenu.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F5) then
  begin
    if Assigned(frmResultadoQuestoes) then
      frmResultadoQuestoes.BuscarRespostas;
  end;
end;

procedure TfrmMenu.FormShow(Sender: TObject);
begin
  pnlProvas.Width := 43;
  Contador := 0;
  Pergunta := 1;
  OldPergunta := 1;
  ProvaIniciada := False;
  btnVoltar.Enabled := False;
  tmrShow.Enabled := True;
end;

procedure TfrmMenu.lblSimuladosClick(Sender: TObject);
begin
  if (pnlProvas.Width = 43) then
    pnlProvas.Width := 265
  else pnlProvas.Width := 43;
end;

procedure TfrmMenu.MouseEnter(Sender: TObject);
begin
  if (Sender is TPanel) then
  begin
    if (TPanel(Sender).Caption <> EmptyStr) then
    begin
      TPanel(Sender).Color := clHighlight;
      TPanel(Sender).Cursor := crHandPoint;
    end;
  end
  else
  begin
    if (TPanel(TWinControl(Sender).Parent).Caption <> EmptyStr) then
    begin
      TPanel(TWinControl(Sender).Parent).Color := clHighlight;
      TPanel(TWinControl(Sender).Parent).Cursor := crHandPoint;
    end;
  end;
end;

procedure TfrmMenu.MouseLeave(Sender: TObject);
begin
  if (Sender is TPanel) then
  begin
    if (TPanel(Sender).Caption <> EmptyStr) then
    begin
      TPanel(Sender).Color := $00000017;
      TPanel(Sender).Cursor := crDefault;
    end;
  end
  else
  begin
    if (TPanel(TWinControl(Sender).Parent).Caption <> EmptyStr) then
    begin
      TPanel(TWinControl(Sender).Parent).Color := $00000017;
      TPanel(TWinControl(Sender).Parent).Cursor := crDefault;
    end;
  end;
end;

procedure TfrmMenu.pnlOpcoesMouseEnter(Sender: TObject);
begin
  if (Sender is TPanel) then
  begin
    TPanel(Sender).Color := clHighlight;
    TPanel(Sender).Cursor := crHandPoint;
  end
  else
  begin
    TPanel(TWinControl(Sender).Parent).Color := clHighlight;
    TPanel(TWinControl(Sender).Parent).Cursor := crHandPoint;
  end;
end;

procedure TfrmMenu.pnlOpcoesMouseLeave(Sender: TObject);
begin
  if (Sender is TPanel) then
  begin
    TPanel(Sender).Color := $00000017;
    TPanel(Sender).Cursor := crDefault;
  end
  else
  begin
    TPanel(TWinControl(Sender).Parent).Color := $00000017;
    TPanel(TWinControl(Sender).Parent).Cursor := crDefault;
  end;
end;

procedure TfrmMenu.pnlProvasResize(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to pnlProvas.ControlCount - 1 do
  begin
    if (pnlProvas.Controls[I] is TPanel) then
    begin
      if (TPanel(pnlProvas.Controls[I]).Hint = EmptyStr) then
      begin
        TPanel(pnlProvas.Controls[I]).Hint := TPanel(pnlProvas.Controls[I]).Caption;
        TPanel(pnlProvas.Controls[I]).Caption := '';
      end
      else
      begin
        TPanel(pnlProvas.Controls[I]).Caption := TPanel(pnlProvas.Controls[I]).Hint;
        TPanel(pnlProvas.Controls[I]).Hint := '';
      end;
    end;
  end;
end;

procedure TfrmMenu.ProvaAdm;
begin
  if Adm or FVerQuestoes then
  begin
    OldPergunta := 1;
    Pergunta := 1;
    Contador := 0;
    ProvaIniciada := True;
    pnlBotoes.Visible := True;
    btnAvancar.Enabled := True;
    MudarQuestao;
  end;
end;

procedure TfrmMenu.ProvaNormal;
begin
  if not Adm and not FVerQuestoes then
  begin
    if (Sis_usuario_provas.data_hora_fim = 0) then
    begin
      Contador := SecondsBetween(TimeOf(Now),
        TimeOf(FloatToDateTime(Sis_usuario_provas.data_hora_inicio)));

      if (Contador <= 3600) then
      begin
        ProvaIniciada := True;
        pnlBotoes.Visible := True;
        btnAvancar.Enabled := True;
        MudarQuestao;
        ConsultaUsuarioProvaPergunta;
        IncluirUsuarioProvaPergunta;
        ConsultaUsuarioProvaPerguntaResposta;
      end
      else
      begin
        MudarQuestao(True);
      end;
    end
    else
    begin
      Finalizar;
    end;
  end;
end;

procedure TfrmMenu.IniciarProva;
begin
  frmAguarde := TfrmAguarde.New('Aguarde...');
  try
    if not(ProvaIniciada) then
    begin
      if Assigned(Sis_usuario_provas) then
        FreeAndNil(Sis_usuario_provas);

      ConsultaUsuarioProva;

      if (Sis_usuario_provas.id = 0) then
        IniciarUsuarioProva;

      ConsultaUsuarioProvaPerguntaMax;
      ProvaAdm;
      ProvaNormal;
      btnVoltar.Enabled := (Pergunta > 1);
    end;
  finally
    if Assigned(frmAguarde) then
      FreeAndNil(frmAguarde);
  end;
end;

procedure TfrmMenu.ConsultaUsuarioProvaPergunta;
var
  ReqConsultaUsuarioProvaPergunta: IRequisicoes;
  SisUsuarioProvaID, SisProvasPerguntasID: string;
begin
  if Assigned(Sis_provas_perguntas) then
  begin
    if Assigned(Sis_usuario_provas_perguntas) then
      FreeAndNil(Sis_usuario_provas_perguntas);

    SisUsuarioProvaID := FloatToStr(Sis_usuario_provas.id);
    SisProvasPerguntasID := FloatToStr(Sis_provas_perguntas.id);
    ReqConsultaUsuarioProvaPergunta := TRequisicoes.New
                                                   .EndPoint('simuladosapi/v1/TApiMethods/UsuarioProvasPerguntas/' + SisUsuarioProvaID + '/' + SisProvasPerguntasID)
                                                   .Get;
    try
      Sis_usuario_provas_perguntas :=
        TSis_usuario_provas_perguntasClass.FromJsonString(ReqConsultaUsuarioProvaPergunta.JSONResponse);
      if (Sis_usuario_provas_perguntas.id > 0) then
        Pergunta := Sis_usuario_provas_perguntas.ordem;
    finally
      ReqConsultaUsuarioProvaPergunta := nil;
    end;
  end;
end;

procedure TfrmMenu.ConsultaUsuarioProvaPerguntaMax;
var
  ReqConsultaUsuarioProvaPergunta: IRequisicoes;
begin
  if Assigned(Sis_usuario_provas_perguntas) then
    FreeAndNil(Sis_usuario_provas_perguntas);

  ReqConsultaUsuarioProvaPergunta := TRequisicoes.New
                                                 .EndPoint('simuladosapi/v1/TApiMethods/UsuarioProvasPerguntasMax/' + Sis_usuario_provas.id.ToString)
                                                 .Get;
  try
    Sis_usuario_provas_perguntas :=
      TSis_usuario_provas_perguntasClass.FromJsonString(ReqConsultaUsuarioProvaPergunta.JSONResponse);
    if (Sis_usuario_provas_perguntas.id > 0) then
      Pergunta := Sis_usuario_provas_perguntas.ordem;
  finally
    ReqConsultaUsuarioProvaPergunta := nil;
  end;
end;

function TfrmMenu.ConsultaUsuarioProvaPerguntaProx(
  const ProximaOrdem: Integer): TSis_provas_perguntasClass;
var
  ReqConsultaProvaPergunta: IRequisicoes;
begin
  if Assigned(Sis_usuario_provas_perguntas) then
    FreeAndNil(Sis_usuario_provas_perguntas);

  ReqConsultaProvaPergunta := TRequisicoes.New
                                          .EndPoint('simuladosapi/v1/TApiMethods/UsuarioProvasPerguntasProx/' + Prova.ToString + '/' + Pergunta.ToString)
                                          .Get;
  try
    Result := TSis_provas_perguntasClass.FromJsonString(ReqConsultaProvaPergunta.JSONResponse);
  finally
    ReqConsultaProvaPergunta := nil;
  end;
end;

procedure TfrmMenu.ConsultaUsuarioProvaPerguntaResposta;
var
  ReqConsultaUsuarioProvaPerguntaResposta: IRequisicoes;
  Consulta_Sis_usuario_provas_perguntas: TSis_usuario_provas_perguntasClass;
  Sis_usuario_provas_perguntas_respostas: TSis_usuario_provas_perguntas_respostasClass;
  Respostas: TSis_provas_perguntas_respostasClass;
  Habilitar: Boolean;
  SisUsuarioProvasPerguntasID: string;
begin
  Habilitar := True;
  if Assigned(Sis_usuario_provas_perguntas) then
  begin
    SisUsuarioProvasPerguntasID := FloatToStr(Sis_usuario_provas_perguntas.id);
    ReqConsultaUsuarioProvaPerguntaResposta :=
      TRequisicoes.New
                  .EndPoint('simuladosapi/v1/TApiMethods/UsuarioProvasPerguntasRespostas/' + SisUsuarioProvasPerguntasID)
                  .Get;
    try
      Consulta_Sis_usuario_provas_perguntas :=
        TSis_usuario_provas_perguntasClass.FromJsonString(ReqConsultaUsuarioProvaPerguntaResposta.JSONResponse);
      try
        for Respostas in Sis_provas_perguntas.sis_provas_perguntas_respostas do
        begin
          for Sis_usuario_provas_perguntas_respostas in Consulta_Sis_usuario_provas_perguntas.Sis_usuario_provas_perguntas_respostas do
          begin
            Habilitar := False;
            if (Respostas.id = Sis_usuario_provas_perguntas_respostas.id_prova_pergunta_resposta) then
            begin
              if not FrmQuestao.ckbResposta1.Checked then
                FrmQuestao.ckbResposta1.Checked := Respostas.opcao.Equals('A');

              if not FrmQuestao.ckbResposta2.Checked then
                FrmQuestao.ckbResposta2.Checked := Respostas.opcao.Equals('B');

              if not FrmQuestao.ckbResposta3.Checked then
                FrmQuestao.ckbResposta3.Checked := Respostas.opcao.Equals('C');

              if not FrmQuestao.ckbResposta4.Checked then
                FrmQuestao.ckbResposta4.Checked := Respostas.opcao.Equals('D');

              if not FrmQuestao.ckbResposta5.Checked then
                FrmQuestao.ckbResposta5.Checked := Respostas.opcao.Equals('E');

              if not FrmQuestao.ckbResposta6.Checked then
                FrmQuestao.ckbResposta6.Checked := Respostas.opcao.Equals('F');
            end;
          end;
        end;
      finally
        FreeAndNil(Consulta_Sis_usuario_provas_perguntas);
      end;

      FrmQuestao.pnlResposta1.Enabled := Habilitar;
      FrmQuestao.pnlResposta2.Enabled := Habilitar;
      FrmQuestao.pnlResposta3.Enabled := Habilitar;
      FrmQuestao.pnlResposta4.Enabled := Habilitar;
      FrmQuestao.pnlResposta5.Enabled := Habilitar;
      FrmQuestao.pnlResposta6.Enabled := Habilitar;
    finally
      ReqConsultaUsuarioProvaPerguntaResposta := nil;
    end;
  end;
end;

procedure TfrmMenu.ConsultarSimulados;
var
  myThread: TThread;
begin
  myThread := TThread.CreateAnonymousThread(
  procedure
  var
    ReqSimulados: IRequisicoes;
  begin
    EnterCriticalSection(csCriticalSection);
    try
      ReqSimulados := TRequisicoes.New
                                  .EndPoint('simuladosapi/v1/TApiMethods/simulados')
                                  .Get;
      try
        Provas := TProvas.FromJsonString(ReqSimulados.JSONResponse);
      finally
        ReqSimulados := nil;
      end;
    finally
      LeaveCriticalSection(csCriticalSection);
    end;
  end);
  myThread.Start();
end;

procedure TfrmMenu.ConsultaUsuarioProva;
var
  ReqConsultaUsuarioProva: IRequisicoes;
begin
  if not(Assigned(Sis_usuario_provas)) then
  begin
    ReqConsultaUsuarioProva := TRequisicoes.New
                                           .EndPoint('simuladosapi/v1/TApiMethods/UsuarioProvas/' + FUsuario.ToString + '/' + Prova.ToString)
                                           .Get;
    try
      Sis_usuario_provas := TSis_usuario_provasClass.FromJsonString(ReqConsultaUsuarioProva.JSONResponse);
    finally
      ReqConsultaUsuarioProva := nil;
    end;
  end;
end;

procedure TfrmMenu.IncluirUsuarioProvaPergunta;
var
  IDPergunta: Integer;
  ReqConsultaUsuarioProvaPergunta: IRequisicoes;
begin
  if (Sis_usuario_provas_perguntas.id = -1) then
  begin
    try
      IDPergunta := Trunc(Sis_provas_perguntas.id);
      Sis_usuario_provas_perguntas.id_usuario_prova := Sis_usuario_provas.id;
      Sis_usuario_provas_perguntas.id_prova_pergunta := IDPergunta;
      Sis_usuario_provas_perguntas.ordem := Pergunta;
      ReqConsultaUsuarioProvaPergunta := TRequisicoes.New
                                                     .EndPoint('simuladosapi/v1/TApiMethods/UsuarioProvasPerguntas')
                                                     .Body(UTF8String(Sis_usuario_provas_perguntas.ToJsonString))
                                                     .Post;
      if (ReqConsultaUsuarioProvaPergunta.ResponseCode = 200) then
      begin
        FreeAndNil(Sis_usuario_provas_perguntas);
        Sis_usuario_provas_perguntas := TSis_usuario_provas_perguntasClass.FromJsonString(ReqConsultaUsuarioProvaPergunta.JSONResponse);
      end;
    finally
      ReqConsultaUsuarioProvaPergunta := nil;
    end;
  end;
end;

procedure TfrmMenu.IncluirUsuarioProvaPerguntaRespotas;
var
  lSis_usuario_provas_perguntas: TSis_usuario_provas_perguntasClass;
  Respostas: TSis_provas_perguntas_respostasClass;
  ReqInsertUsuarioProvaPerguntaResposta: IRequisicoes;
begin
  if (FrmQuestao.pnlResposta1.Enabled) then
  begin
    lSis_usuario_provas_perguntas := TSis_usuario_provas_perguntasClass.Create;
    try
      lSis_usuario_provas_perguntas.id := Sis_usuario_provas_perguntas.id;
      lSis_usuario_provas_perguntas.id_prova_pergunta := Sis_provas_perguntas.id;
      lSis_usuario_provas_perguntas.id_usuario_prova := Sis_usuario_provas_perguntas.id_usuario_prova;
      lSis_usuario_provas_perguntas.ordem := Sis_usuario_provas_perguntas.ordem;
      for Respostas in Sis_provas_perguntas.sis_provas_perguntas_respostas do
      begin
        if Respostas.opcao.Equals('A') and FrmQuestao.ckbResposta1.Checked then
        begin
          with lSis_usuario_provas_perguntas.AddSis_usuario_provas_perguntas_respostas do
          begin
            id_usuario_prova_pergunta := Sis_usuario_provas_perguntas.id;
            id_prova_pergunta_resposta := Respostas.id;
          end;
        end
        else if Respostas.opcao.Equals('B') and FrmQuestao.ckbResposta2.Checked then
        begin
          with lSis_usuario_provas_perguntas.AddSis_usuario_provas_perguntas_respostas do
          begin
            id_usuario_prova_pergunta := Sis_usuario_provas_perguntas.id;
            id_prova_pergunta_resposta := Respostas.id;
          end;
        end
        else if Respostas.opcao.Equals('C') and FrmQuestao.ckbResposta3.Checked then
        begin
          with lSis_usuario_provas_perguntas.AddSis_usuario_provas_perguntas_respostas do
          begin
            id_usuario_prova_pergunta := Sis_usuario_provas_perguntas.id;
            id_prova_pergunta_resposta := Respostas.id;
          end;
        end
        else if Respostas.opcao.Equals('D') and FrmQuestao.ckbResposta4.Checked then
        begin
          with lSis_usuario_provas_perguntas.AddSis_usuario_provas_perguntas_respostas do
          begin
            id_usuario_prova_pergunta := Sis_usuario_provas_perguntas.id;
            id_prova_pergunta_resposta := Respostas.id;
          end;
        end
        else if Respostas.opcao.Equals('E') and FrmQuestao.ckbResposta5.Checked then
        begin
          with lSis_usuario_provas_perguntas.AddSis_usuario_provas_perguntas_respostas do
          begin
            id_usuario_prova_pergunta := Sis_usuario_provas_perguntas.id;
            id_prova_pergunta_resposta := Respostas.id;
          end;
        end
        else if Respostas.opcao.Equals('F') and FrmQuestao.ckbResposta6.Checked then
        begin
          with lSis_usuario_provas_perguntas.AddSis_usuario_provas_perguntas_respostas do
          begin
            id_usuario_prova_pergunta := Sis_usuario_provas_perguntas.id;
            id_prova_pergunta_resposta := Respostas.id;
          end;
        end;
      end;

      try
        ReqInsertUsuarioProvaPerguntaResposta :=
          TRequisicoes.New
                      .EndPoint('simuladosapi/v1/TApiMethods/UsuarioProvasPerguntasRespostas')
                      .Body(UTF8String(lSis_usuario_provas_perguntas.ToJsonString))
                      .Post;
      finally
        ReqInsertUsuarioProvaPerguntaResposta := nil;
      end;
    finally
      FreeAndNil(lSis_usuario_provas_perguntas);
    end;
  end;
end;

procedure TfrmMenu.IniciarUsuarioProva;
var
  ReqConsultaUsuarioProva: IRequisicoes;
begin
  try
    Sis_usuario_provas.id_usuario := FUsuario;
    Sis_usuario_provas.id_prova := Prova;
    Sis_usuario_provas.data_hora_inicio := Now;
    ReqConsultaUsuarioProva := TRequisicoes.New
                                             .EndPoint('simuladosapi/v1/TApiMethods/UsuarioProvas')
                                             .Body(UTF8String(Sis_usuario_provas.ToJsonString))
                                             .Post;

    if (ReqConsultaUsuarioProva.ResponseCode = 200) then
    begin
      FreeAndNil(Sis_usuario_provas);
      Sis_usuario_provas := TSis_usuario_provasClass.FromJsonString(ReqConsultaUsuarioProva.JSONResponse);
    end;
  finally
    ReqConsultaUsuarioProva := nil;
  end;
end;

procedure TfrmMenu.SimuladoClick(Sender: TObject);
begin
  if not(ProvaIniciada) then
  begin
    if (Sender is TPanel) then
      Prova := TPanel(Sender).Tag
    else Prova := TPanel(TWinControl(Sender).Parent).Tag;

    IniciarProva;
  end;
end;

procedure TfrmMenu.Finalizar;
var
  ReqFinalizarProva, ReqCategorias: IRequisicoes;
  lSis_usuario_provas: TSis_usuario_provasClass;
  frmResultado: TfrmResultado;
  Categorias: TCategorias;
  CategoriasClass: TCategoriasClass;
  frmResultadoCategorias: TfrmResultadoCategorias;
  Contador: Integer;

  function ISODateStrToDate(Date: TDateTime): string;
  var
    xsDate: TXSDateTime;
  begin
    xsDate := TXSDateTime.Create;
    try
      xsDate.AsDateTime := Date;
      Exit(xsDate.NativeToXS);
    finally
      xsDate.Free;
    end;
  end;
begin
  if not(Assigned(frmAguarde)) then
    frmAguarde := TfrmAguarde.New('Aguarde...');
  try
    ReqFinalizarProva := TRequisicoes.New
                                     .EndPoint('simuladosapi/v1/TApiMethods/FinalizarProva/' + FUsuario.ToString + '/' + Prova.ToString + '/' + ISODateStrToDate(Now))
                                     .Get;
  finally
    if Assigned(frmAguarde) then
      FreeAndNil(frmAguarde);
  end;

  try
    lSis_usuario_provas := TSis_usuario_provasClass.FromJsonString(ReqFinalizarProva.JSONResponse);
    try
      frmResultado :=
        TfrmResultado.New(lSis_usuario_provas.data_hora_inicio,
                          lSis_usuario_provas.data_hora_fim,
                          Prova,
                          Trunc(lSis_usuario_provas.quantidade_acertos));
      try
        frmResultado.ShowModal;
      finally
        FreeAndNil(frmResultado);
      end;
    finally
      FreeAndNil(lSis_usuario_provas);
    end;
  finally
    ReqFinalizarProva := nil;
  end;

  Application.ProcessMessages;
  frmResultadoCategorias :=
    TfrmResultadoCategorias.New(Prova);
  try
    if not(Assigned(frmAguarde)) then
      frmAguarde := TfrmAguarde.New('Aguarde...');
    try
      ReqCategorias := TRequisicoes.New
                                   .EndPoint('simuladosapi/v1/TApiMethods/UsuarioPerguntasCategorias/' + Prova.ToString + '/' + FUsuario.ToString)
                                   .Get;
    finally
      if Assigned(frmAguarde) then
        FreeAndNil(frmAguarde);
    end;

    Contador := 0;
    Categorias := TCategorias.FromJsonString(ReqCategorias.JSONResponse);
    try
      for CategoriasClass in Categorias.categorias do
      begin
        Inc(Contador);
        if (Contador = 1) then
        begin
          frmResultadoCategorias.pnlDescricaoCategoria1.Caption := CategoriasClass.descricao;
          frmResultadoCategorias.progress1.Progress := Trunc(CategoriasClass.percentual);
        end
        else if (Contador = 2) then
        begin
          frmResultadoCategorias.pnlDescricaoCategoria2.Caption := CategoriasClass.descricao;
          frmResultadoCategorias.progress2.Progress := Trunc(CategoriasClass.percentual);
        end
        else if (Contador = 3) then
        begin
          frmResultadoCategorias.pnlDescricaoCategoria3.Caption := CategoriasClass.descricao;
          frmResultadoCategorias.progress3.Progress := Trunc(CategoriasClass.percentual);
        end
        else if (Contador = 4) then
        begin
          frmResultadoCategorias.pnlDescricaoCategoria4.Caption := CategoriasClass.descricao;
          frmResultadoCategorias.progress4.Progress := Trunc(CategoriasClass.percentual);
        end
        else if (Contador = 5) then
        begin
          frmResultadoCategorias.pnlDescricaoCategoria5.Caption := CategoriasClass.descricao;
          frmResultadoCategorias.progress5.Progress := Trunc(CategoriasClass.percentual);
        end
        else if (Contador = 6) then
        begin
          frmResultadoCategorias.pnlDescricaoCategoria6.Caption := CategoriasClass.descricao;
          frmResultadoCategorias.progress6.Progress := Trunc(CategoriasClass.percentual);
        end
        else if (Contador = 7) then
        begin
          frmResultadoCategorias.pnlDescricaoCategoria7.Caption := CategoriasClass.descricao;
          frmResultadoCategorias.progress7.Progress := Trunc(CategoriasClass.percentual);
        end
        else if (Contador = 8) then
        begin
          frmResultadoCategorias.pnlDescricaoCategoria8.Caption := CategoriasClass.descricao;
          frmResultadoCategorias.progress8.Progress := Trunc(CategoriasClass.percentual);
        end
        else if (Contador = 9) then
        begin
          frmResultadoCategorias.pnlDescricaoCategoria9.Caption := CategoriasClass.descricao;
          frmResultadoCategorias.progress9.Progress := Trunc(CategoriasClass.percentual);
        end
        else if (Contador = 10) then
        begin
          frmResultadoCategorias.pnlDescricaoCategoria10.Caption := CategoriasClass.descricao;
          frmResultadoCategorias.progress10.Progress := Trunc(CategoriasClass.percentual);
        end
        else if (Contador = 11) then
        begin
          frmResultadoCategorias.pnlDescricaoCategoria11.Caption := CategoriasClass.descricao;
          frmResultadoCategorias.progress11.Progress := Trunc(CategoriasClass.percentual);
        end;
      end;
    finally
      FreeAndNil(Categorias);
    end;

    frmResultadoCategorias.ShowModal;
    FVerQuestoes := frmResultadoCategorias.VerQuestoes;
  finally
    FreeAndNil(frmResultadoCategorias);
  end;

  if Assigned(Sis_usuario_provas) then
    FreeAndNil(Sis_usuario_provas);

  if Assigned(Sis_usuario_provas_perguntas) then
    FreeAndNil(Sis_usuario_provas_perguntas);

  if Assigned(Sis_provas_perguntas) then
    FreeAndNil(Sis_provas_perguntas);

  if FVerQuestoes then
    IniciarProva
  else Prova := 0;
end;

procedure TfrmMenu.QuestaoAdm(const Concluir: Boolean);
var
  Perguntas: TSis_provas_perguntasClass;
  Respostas: TSis_provas_perguntas_respostasClass;
  UltimaPergunta: Boolean;
begin
  if Adm or FVerQuestoes then
  begin
    if not(Concluir) then
    begin
      frmResultadoQuestoes := TfrmResultadoQuestoes.Create(nil);
      frmResultadoQuestoes.OnClose := CloseForms;
      Perguntas := ConsultaUsuarioProvaPerguntaProx(Pergunta);

      if Assigned(Sis_provas_perguntas) then
        FreeAndNil(Sis_provas_perguntas);

      if Assigned(Sis_usuario_provas) and FVerQuestoes then
        frmResultadoQuestoes.IDUsuarioProva := Trunc(Sis_usuario_provas.id);

      if Assigned(Perguntas) then
      begin
        if (Perguntas.ordem = Pergunta) then
        begin
          Sis_provas_perguntas := Perguntas;
          frmResultadoQuestoes.IDPergunta := Trunc(Perguntas.id);
          pnlNomeProva.Caption := Provas.provas[0].sis_prova.descricao;
          frmResultadoQuestoes.mmPergunta.Lines.Add(Perguntas.pergunta);
          frmResultadoQuestoes.lblQuestao.Caption := 'Questão ' + Perguntas.ordem.ToString + ' (' + Perguntas.categoria + ')';
          frmResultadoQuestoes.Pergunta := Pergunta;
          for Respostas in Perguntas.sis_provas_perguntas_respostas do
          begin
            if (Respostas.opcao = 'A') then
            begin
              frmResultadoQuestoes.ckbResposta1.Checked := Respostas.certa;
              frmResultadoQuestoes.pnlResposta1.Visible := True;
              frmResultadoQuestoes.mmResposta1.Lines.Add(Respostas.resposta);
              frmResultadoQuestoes.ckbResposta1.Tag := Trunc(Respostas.id);
              if Respostas.certa then
                frmResultadoQuestoes.pnlResposta1.Tag := 1;
            end
            else if (Respostas.opcao = 'B') then
            begin
              frmResultadoQuestoes.ckbResposta2.Checked := Respostas.certa;
              frmResultadoQuestoes.pnlResposta2.Visible := True;
              frmResultadoQuestoes.mmResposta2.Lines.Add(Respostas.resposta);
              frmResultadoQuestoes.ckbResposta2.Tag := Trunc(Respostas.id);
              if Respostas.certa then
                frmResultadoQuestoes.pnlResposta2.Tag := 1;
            end
            else if (Respostas.opcao = 'C') then
            begin
              frmResultadoQuestoes.ckbResposta3.Checked := Respostas.certa;
              frmResultadoQuestoes.pnlResposta3.Visible := True;
              frmResultadoQuestoes.mmResposta3.Lines.Add(Respostas.resposta);
              frmResultadoQuestoes.ckbResposta3.Tag := Trunc(Respostas.id);
              if Respostas.certa then
                frmResultadoQuestoes.pnlResposta3.Tag := 1;
            end
            else if (Respostas.opcao = 'D') then
            begin
              frmResultadoQuestoes.ckbResposta4.Checked := Respostas.certa;
              frmResultadoQuestoes.pnlResposta4.Visible := True;
              frmResultadoQuestoes.mmResposta4.Lines.Add(Respostas.resposta);
              frmResultadoQuestoes.ckbResposta4.Tag := Trunc(Respostas.id);
              if Respostas.certa then
                frmResultadoQuestoes.pnlResposta4.Tag := 1;
            end
            else if (Respostas.opcao = 'E') then
            begin
              frmResultadoQuestoes.ckbResposta5.Checked := Respostas.certa;
              frmResultadoQuestoes.pnlResposta5.Visible := True;
              frmResultadoQuestoes.mmResposta5.Lines.Add(Respostas.resposta);
              frmResultadoQuestoes.ckbResposta5.Tag := Trunc(Respostas.id);
              if Respostas.certa then
                frmResultadoQuestoes.pnlResposta5.Tag := 1;
            end
            else if (Respostas.opcao = 'F') then
            begin
              frmResultadoQuestoes.ckbResposta6.Checked := Respostas.certa;
              frmResultadoQuestoes.pnlResposta6.Visible := True;
              frmResultadoQuestoes.mmResposta6.Lines.Add(Respostas.resposta);
              frmResultadoQuestoes.ckbResposta6.Tag := Trunc(Respostas.id);
              if Respostas.certa then
                frmResultadoQuestoes.pnlResposta6.Tag := 1;
            end;
          end;

          if frmResultadoQuestoes.mmResposta1.Lines.Count > 1 then
          begin
            frmResultadoQuestoes.pnlResposta1.Height := frmResultadoQuestoes.pnlResposta1.Height + (frmResultadoQuestoes.mmResposta1.Lines.Count * 15);
            frmResultadoQuestoes.ckbResposta1.Margins.Bottom := frmResultadoQuestoes.pnlResposta1.Height - 16;
          end;

          if frmResultadoQuestoes.mmResposta2.Lines.Count > 1 then
          begin
            frmResultadoQuestoes.pnlResposta2.Height := frmResultadoQuestoes.pnlResposta2.Height + (frmResultadoQuestoes.mmResposta2.Lines.Count * 15);
            frmResultadoQuestoes.ckbResposta2.Margins.Bottom := frmResultadoQuestoes.pnlResposta2.Height - 16;
          end;

          if frmResultadoQuestoes.mmResposta3.Lines.Count > 1 then
          begin
            frmResultadoQuestoes.pnlResposta3.Height := frmResultadoQuestoes.pnlResposta3.Height + (frmResultadoQuestoes.mmResposta3.Lines.Count * 15);
            frmResultadoQuestoes.ckbResposta3.Margins.Bottom := frmResultadoQuestoes.pnlResposta3.Height - 16;
          end;

          if frmResultadoQuestoes.mmResposta4.Lines.Count > 1 then
          begin
            frmResultadoQuestoes.pnlResposta4.Height := frmResultadoQuestoes.pnlResposta4.Height + (frmResultadoQuestoes.mmResposta4.Lines.Count * 15);
            frmResultadoQuestoes.ckbResposta4.Margins.Bottom := frmResultadoQuestoes.pnlResposta4.Height - 16;
          end;

          if frmResultadoQuestoes.mmResposta5.Lines.Count > 1 then
          begin
            frmResultadoQuestoes.pnlResposta5.Height := frmResultadoQuestoes.pnlResposta5.Height + (frmResultadoQuestoes.mmResposta5.Lines.Count * 15);
            frmResultadoQuestoes.ckbResposta5.Margins.Bottom := frmResultadoQuestoes.pnlResposta5.Height - 16;
          end;

          if frmResultadoQuestoes.mmResposta6.Lines.Count > 1 then
          begin
            frmResultadoQuestoes.pnlResposta6.Height := frmResultadoQuestoes.pnlResposta6.Height + (frmResultadoQuestoes.mmResposta6.Lines.Count * 15);
            frmResultadoQuestoes.ckbResposta6.Margins.Bottom := frmResultadoQuestoes.pnlResposta6.Height - 16;
          end;

          frmResultadoQuestoes.Parent := pnlProva;
          frmResultadoQuestoes.BuscarRespostas;
          frmResultadoQuestoes.Show;
          frmResultadoQuestoes.Align := alClient;
        end;
      end;

      Application.ProcessMessages;
      UltimaPergunta := (Pergunta = 60);
      if UltimaPergunta then
        btnAvancar.Caption := 'Concluir'
      else btnAvancar.Caption := 'Avançar';
    end
    else
    begin
      pnlBotoes.Visible := False;
      btnAvancar.Enabled := True;
      btnVoltar.Enabled := False;
      btnAvancar.Caption := 'Avançar';
      OldPergunta := 1;
      Pergunta := 1;
      tmrTempo.Enabled := False;
      Contador := 0;
      ProvaIniciada := False;
    end;
  end;
end;

procedure TfrmMenu.QuestaoNormal(const Concluir: Boolean);
var
  Perguntas: TSis_provas_perguntasClass;
  Respostas: TSis_provas_perguntas_respostasClass;
  UltimaPergunta: Boolean;
begin
  if not(Adm) and not FVerQuestoes then
  begin
    if not(Concluir) then
    begin
      FrmQuestao := TfrmQuestao.Create(nil);
      FrmQuestao.OnClose := CloseForms;
      FrmQuestao.PanelBookMark := pnlBookMarks;
      FrmQuestao.Click := BookMarkClick;
      Perguntas := ConsultaUsuarioProvaPerguntaProx(Pergunta);

      if Assigned(Sis_provas_perguntas) then
        FreeAndNil(Sis_provas_perguntas);

      if Assigned(Perguntas) then
      begin
        if (Perguntas.ordem = Pergunta) then
        begin
          Sis_provas_perguntas := Perguntas;
          pnlNomeProva.Caption := Provas.provas[0].sis_prova.descricao;
          Tempo := Trunc(Provas.provas[0].sis_prova.tempo);
          tmrTempo.Enabled := True;
          FrmQuestao.mmPergunta.Lines.Add(Perguntas.pergunta);
          FrmQuestao.lblQuestao.Caption := 'Questão ' + Perguntas.ordem.ToString + ' (' + Perguntas.categoria + ')';
          FrmQuestao.Pergunta := Pergunta;
          for Respostas in Perguntas.sis_provas_perguntas_respostas do
          begin
            if (Respostas.opcao = 'A') then
            begin
              FrmQuestao.pnlResposta1.Visible := True;
              FrmQuestao.mmResposta1.Lines.Add(Respostas.resposta);
              FrmQuestao.ckbResposta1.Tag := Trunc(Respostas.id);
              if Respostas.certa then
                FrmQuestao.pnlResposta1.Tag := 1;
            end
            else if (Respostas.opcao = 'B') then
            begin
              FrmQuestao.pnlResposta2.Visible := True;
              FrmQuestao.mmResposta2.Lines.Add(Respostas.resposta);
              FrmQuestao.ckbResposta2.Tag := Trunc(Respostas.id);
              if Respostas.certa then
                FrmQuestao.pnlResposta2.Tag := 1;
            end
            else if (Respostas.opcao = 'C') then
            begin
              FrmQuestao.pnlResposta3.Visible := True;
              FrmQuestao.mmResposta3.Lines.Add(Respostas.resposta);
              FrmQuestao.ckbResposta3.Tag := Trunc(Respostas.id);
              if Respostas.certa then
                FrmQuestao.pnlResposta3.Tag := 1;
            end
            else if (Respostas.opcao = 'D') then
            begin
              FrmQuestao.pnlResposta4.Visible := True;
              FrmQuestao.mmResposta4.Lines.Add(Respostas.resposta);
              FrmQuestao.ckbResposta4.Tag := Trunc(Respostas.id);
              if Respostas.certa then
                FrmQuestao.pnlResposta4.Tag := 1;
            end
            else if (Respostas.opcao = 'E') then
            begin
              FrmQuestao.pnlResposta5.Visible := True;
              FrmQuestao.mmResposta5.Lines.Add(Respostas.resposta);
              FrmQuestao.ckbResposta5.Tag := Trunc(Respostas.id);
              if Respostas.certa then
                FrmQuestao.pnlResposta5.Tag := 1;
            end
            else if (Respostas.opcao = 'F') then
            begin
              FrmQuestao.pnlResposta6.Visible := True;
              FrmQuestao.mmResposta6.Lines.Add(Respostas.resposta);
              FrmQuestao.ckbResposta6.Tag := Trunc(Respostas.id);
              if Respostas.certa then
                FrmQuestao.pnlResposta6.Tag := 1;
            end;
          end;

          if FrmQuestao.mmResposta1.Lines.Count > 1 then
          begin
            FrmQuestao.pnlResposta1.Height := FrmQuestao.pnlResposta1.Height + (FrmQuestao.mmResposta1.Lines.Count * 15);
            FrmQuestao.ckbResposta1.Margins.Bottom := FrmQuestao.pnlResposta1.Height - 16;
          end;

          if FrmQuestao.mmResposta2.Lines.Count > 1 then
          begin
            FrmQuestao.pnlResposta2.Height := FrmQuestao.pnlResposta2.Height + (FrmQuestao.mmResposta2.Lines.Count * 15);
            FrmQuestao.ckbResposta2.Margins.Bottom := FrmQuestao.pnlResposta2.Height - 16;
          end;

          if FrmQuestao.mmResposta3.Lines.Count > 1 then
          begin
            FrmQuestao.pnlResposta3.Height := FrmQuestao.pnlResposta3.Height + (FrmQuestao.mmResposta3.Lines.Count * 15);
            FrmQuestao.ckbResposta3.Margins.Bottom := FrmQuestao.pnlResposta3.Height - 16;
          end;

          if FrmQuestao.mmResposta4.Lines.Count > 1 then
          begin
            FrmQuestao.pnlResposta4.Height := FrmQuestao.pnlResposta4.Height + (FrmQuestao.mmResposta4.Lines.Count * 15);
            FrmQuestao.ckbResposta4.Margins.Bottom := FrmQuestao.pnlResposta4.Height - 16;
          end;

          if FrmQuestao.mmResposta5.Lines.Count > 1 then
          begin
            FrmQuestao.pnlResposta5.Height := FrmQuestao.pnlResposta5.Height + (FrmQuestao.mmResposta5.Lines.Count * 15);
            FrmQuestao.ckbResposta5.Margins.Bottom := FrmQuestao.pnlResposta5.Height - 16;
          end;

          if FrmQuestao.mmResposta6.Lines.Count > 1 then
          begin
            FrmQuestao.pnlResposta6.Height := FrmQuestao.pnlResposta6.Height + (FrmQuestao.mmResposta6.Lines.Count * 15);
            FrmQuestao.ckbResposta6.Margins.Bottom := FrmQuestao.pnlResposta6.Height - 16;
          end;

          FrmQuestao.Parent := pnlProva;
          FrmQuestao.Show;
          FrmQuestao.Align := alClient;
        end;
      end;

      Application.ProcessMessages;
      UltimaPergunta := (Pergunta = 60);
      if UltimaPergunta then
        btnAvancar.Caption := 'Concluir'
      else btnAvancar.Caption := 'Avançar';
    end
    else
    begin
      pnlBotoes.Visible := False;
      btnAvancar.Enabled := True;
      btnVoltar.Enabled := False;
      btnAvancar.Caption := 'Avançar';
      OldPergunta := 1;
      Pergunta := 1;
      tmrTempo.Enabled := False;
      Contador := 0;
      ProvaIniciada := False;
      Finalizar;
    end;
  end;
end;

procedure TfrmMenu.MudarQuestao(const Concluir: Boolean);
begin
  QuestaoNormal(Concluir);
  QuestaoAdm(Concluir);
end;

procedure TfrmMenu.BookMarkClick(Sender: TObject);
begin
  if Assigned(FrmQuestao) then
  begin
    if (OldPergunta = 1) then
      OldPergunta := Pergunta;

    Pergunta := TButton(Sender).Tag;
    btnVoltar.Enabled := (Pergunta > 1);
    FreeAndNil(FrmQuestao);
  end;

  MudarQuestao;
end;

procedure TfrmMenu.AvancarAdm;
begin
  if Adm or FVerQuestoes then
  begin
    btnAvancar.Enabled := False;
    try
      if (btnAvancar.Caption = 'Avançar') then
      begin
        if Assigned(frmResultadoQuestoes) then
        begin
          btnVoltar.Enabled := True;
          if (OldPergunta <> 1) then
          begin
            Pergunta := OldPergunta;
            OldPergunta := 1;
          end
          else Pergunta := frmResultadoQuestoes.Pergunta + 1;

          FreeAndNil(frmResultadoQuestoes);
        end;

        MudarQuestao;
      end
      else
      begin
        if Assigned(frmResultadoQuestoes) then
          FreeAndNil(frmResultadoQuestoes);

        MudarQuestao(True);
      end;
    finally
      btnAvancar.Enabled := True;
    end;
  end;
end;

procedure TfrmMenu.AvancarNormal;
begin
  if not Adm and not FVerQuestoes then
  begin
    btnAvancar.Enabled := False;
    try
      if (btnAvancar.Caption = 'Avançar') then
      begin
        if Assigned(FrmQuestao) then
        begin
          btnVoltar.Enabled := True;
          if (OldPergunta <> 1) then
          begin
            Pergunta := OldPergunta;
            OldPergunta := 1;
          end
          else Pergunta := FrmQuestao.Pergunta + 1;

          IncluirUsuarioProvaPerguntaRespotas;
          FreeAndNil(FrmQuestao);
        end;

        MudarQuestao;
        ConsultaUsuarioProvaPergunta;
        IncluirUsuarioProvaPergunta;
        ConsultaUsuarioProvaPerguntaResposta;
      end
      else
      begin
        IncluirUsuarioProvaPerguntaRespotas;
        if Assigned(FrmQuestao) then
          FreeAndNil(FrmQuestao);

        MudarQuestao(True);
      end;
    finally
      btnAvancar.Enabled := True;
    end;
  end;
end;

procedure TfrmMenu.btnAvancarClick(Sender: TObject);
begin
  AvancarNormal;
  AvancarAdm;
end;

procedure TfrmMenu.VoltarAdm;
begin
  if Adm or FVerQuestoes then
  begin
    btnVoltar.Enabled := False;
    if Assigned(frmResultadoQuestoes) then
    begin
      Pergunta := frmResultadoQuestoes.Pergunta - 1;
      btnVoltar.Enabled := (Pergunta > 1);
      FreeAndNil(frmResultadoQuestoes);
    end;

    MudarQuestao;
  end;
end;

procedure TfrmMenu.VoltarNormal;
begin
  if not Adm and not FVerQuestoes then
  begin
    btnVoltar.Enabled := False;
    if Assigned(FrmQuestao) then
    begin
      Pergunta := FrmQuestao.Pergunta - 1;
      btnVoltar.Enabled := (Pergunta > 1);
      FreeAndNil(FrmQuestao);
    end;

    MudarQuestao;
    ConsultaUsuarioProvaPergunta;
    ConsultaUsuarioProvaPerguntaResposta;
  end;
end;

procedure TfrmMenu.btnVoltarClick(Sender: TObject);
begin
  VoltarNormal;
  VoltarAdm;
end;

procedure TfrmMenu.CriarPanelSimulado(const ID: Integer; const Descricao: string);
var
  Panel: TPanel;
begin
  Panel := TPanel.Create(Self);
  Panel.BevelOuter := bvNone;
  Panel.Parent := pnlProvas;
  Panel.Align := alTop;
  Panel.Height := 32;
  Panel.ParentBackground := False;
  Panel.Color := $00000017;
  Panel.OnClick := SimuladoClick;
  Panel.OnMouseEnter := MouseEnter;
  Panel.OnMouseLeave := MouseLeave;
  Panel.Font := lblSimulados.Font;
  Panel.Hint := Descricao;
  Panel.Tag := ID;
  Panel.Top := 1000;
  Panel.AlignWithMargins := True;
  Panel.Margins.Bottom := 1;
  Panel.Margins.Left := 1;
  Panel.Margins.Right := 3;
  Panel.Margins.Top := 2;
end;

destructor TfrmMenu.Destroy;
begin
  if Assigned(Sis_usuario_provas) then
    FreeAndNil(Sis_usuario_provas);

  if Assigned(Sis_usuario_provas_perguntas) then
    FreeAndNil(Sis_usuario_provas_perguntas);

  inherited;
end;

procedure TfrmMenu.tmrShowTimer(Sender: TObject);
var
  frmAguarde: TfrmAguarde;
  lProvas: TProvasClass;
begin
  tmrShow.Enabled := False;
  frmAguarde := TfrmAguarde.New('Aguarde, buscando dados...');
  try
    EnterCriticalSection(csCriticalSection);
    try
      if Assigned(Provas) then
      begin
        for lProvas in Provas.provas do
          CriarPanelSimulado(Trunc(lProvas.sis_prova.id),
            lProvas.sis_prova.descricao);
      end;
    finally
      LeaveCriticalSection(csCriticalSection);
    end;
  finally
    FreeAndNil(frmAguarde);
  end;
end;

function TfrmMenu.FormatSecsToHMS(Secs: LongInt): string;
var
  Hrs, Min: Word;
  horas, minutos, segundos: string;
begin
  Hrs := Secs div 3600;
  Secs := Secs mod 3600;
  Min := Secs div 60;
  Secs := Secs mod 60;

  if Hrs = 0 then
    horas := '00'
  else
    horas := IntToStr(Hrs);

  if Min = 0 then
    minutos := '00'
  else
    if(Min < 10) then
   minutos := '0' + IntToStr(Min)
    else
   minutos := IntToStr(Min);

  if Secs = 0 then
    segundos := '00'
  else
    if(Secs < 10) then
    segundos := '0' + IntToStr(Secs)
    else
     segundos := IntToStr(Secs);

  Result := horas + ':' + minutos + ':' + segundos;
end;

procedure TfrmMenu.tmrTempoTimer(Sender: TObject);
begin
  if (((Tempo * 60) - Contador) > 0) then
  begin
    Inc(Contador);
    pnlTempo.Caption := FormatSecsToHMS((Tempo * 60) - Contador);
  end
  else
  begin
    tmrTempo.Enabled := False;
    btnVoltar.Enabled := False;
    btnAvancar.Enabled := False;
    MudarQuestao(True);
  end;
end;

initialization
  InitializeCriticalSection(csCriticalSection);

finalization
  DeleteCriticalSection(csCriticalSection);

end.
