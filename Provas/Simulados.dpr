program Simulados;

uses
  MidasLib,
  SysUtils,
  Vcl.Forms,
  uMenu in 'uMenu.pas' {frmMenu},
  ufrmLogin in 'Login\ufrmLogin.pas' {frmLogin},
  ufrmSignUp in 'Login\ufrmSignUp.pas' {frmSignUp},
  uRequisicoes in 'uRequisicoes.pas',
  uAcessToken in '..\Server\uAcessToken.pas',
  uSisProvasJSON in '..\Server\uSisProvasJSON.pas',
  ufrmQuestao in 'ufrmQuestao.pas' {frmQuestao},
  uSisUsuarioProvasJSON in '..\Server\uSisUsuarioProvasJSON.pas',
  ufrmEsmaecer in 'Aguarde\ufrmEsmaecer.pas' {frmEsmaecer},
  ufrmAguarde in 'Aguarde\ufrmAguarde.pas' {frmAguarde},
  ufrmResultado in 'ufrmResultado.pas' {frmResultado},
  ufrmResultadoQuestoes in 'ufrmResultadoQuestoes.pas' {frmResultadoQuestoes},
  ufrmResultadoCategorias in 'ufrmResultadoCategorias.pas' {frmResultadoCategorias},
  uSisPerguntasCategoriasJSON in '..\Server\uSisPerguntasCategoriasJSON.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  frmLogin := TfrmLogin.Create(Application);
  if (frmLogin.ShowModal = 1) then
  begin
    Application.CreateForm(TfrmMenu, frmMenu);
    frmMenu.ConsultarSimulados;
    frmMenu.AcessToken := frmLogin.AcessToken;
    frmMenu.Usuario := frmLogin.Usuario;
    frmMenu.Adm := frmLogin.Adm;
    frmMenu.pnlUsuario.Caption := frmLogin.Nome;
  end;
  Application.Run;
end.
