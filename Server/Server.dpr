program Server;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  FormUnit1 in 'FormUnit1.pas' {Form1},
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas' {ApiMethods: TDSServerModule},
  ServerContainerUnit1 in 'ServerContainerUnit1.pas' {ServerContainer1: TDataModule},
  WebModuleUnit1 in 'WebModuleUnit1.pas' {WebModule1: TWebModule},
  uSisUsuario in 'uSisUsuario.pas',
  uAcessToken in 'uAcessToken.pas',
  uSisUsuarioSession in 'uSisUsuarioSession.pas',
  uSisProvasJSON in 'uSisProvasJSON.pas',
  uSisProvasPerguntas in 'uSisProvasPerguntas.pas',
  uSisProvasPerguntasRespostas in 'uSisProvasPerguntasRespostas.pas',
  uSisProvas in 'uSisProvas.pas',
  uSisUsuarioProvas in 'uSisUsuarioProvas.pas',
  uSisUsuarioProvasJSON in 'uSisUsuarioProvasJSON.pas',
  uSisUsuarioProvasPerguntas in 'uSisUsuarioProvasPerguntas.pas',
  uSisUsuarioProvasPerguntasBookMarks in 'uSisUsuarioProvasPerguntasBookMarks.pas',
  uSisUsuarioProvasPerguntasRespostas in 'uSisUsuarioProvasPerguntasRespostas.pas',
  RespostasJSON in 'RespostasJSON.pas',
  uConexao in 'uConexao.pas',
  uSisCategorias in 'uSisCategorias.pas',
  uSisPerguntasCategoriasJSON in 'uSisPerguntasCategoriasJSON.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
