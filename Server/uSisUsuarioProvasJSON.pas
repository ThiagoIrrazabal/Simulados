unit uSisUsuarioProvasJSON;

interface

uses Generics.Collections, Rest.Json;

type
  TSis_usuario_provas_perguntas_respostasClass = class
  private
    FId: Extended;
    Fid_prova_pergunta_resposta: Extended;
    Fid_usuario_prova_pergunta: Extended;
  public
    property id: Extended read FId write FId;
    property id_usuario_prova_pergunta: Extended read Fid_usuario_prova_pergunta write Fid_usuario_prova_pergunta;
    property id_prova_pergunta_resposta: Extended read Fid_prova_pergunta_resposta write Fid_prova_pergunta_resposta;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TSis_usuario_provas_perguntas_respostasClass;
  end;

  TSis_usuario_provas_perguntas_BookmarClass = class
  private
    FId: Extended;
    Fid_usuario_prova_pergunta: Extended;
    Fbook_mark: Extended;
  public
    property id: Extended read FId write FId;
    property id_usuario_prova_pergunta: Extended read Fid_usuario_prova_pergunta write Fid_usuario_prova_pergunta;
    property book_mark: Extended read Fbook_mark write Fbook_mark;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TSis_usuario_provas_perguntas_BookmarClass;
  end;

  TSis_usuario_provas_perguntasClass = class
  private
    Fid_prova_pergunta: Extended;
    Fid_usuario_prova: Extended;
    FId: Extended;
    FSis_usuario_provas_perguntas_Bookmar: TArray<TSis_usuario_provas_perguntas_BookmarClass>;
    FSis_usuario_provas_perguntas_respostas: TArray<TSis_usuario_provas_perguntas_respostasClass>;
    Fordem: Integer;
  public
    property id: Extended read FId write FId;
    property id_usuario_prova: Extended read Fid_usuario_prova write Fid_usuario_prova;
    property id_prova_pergunta: Extended read Fid_prova_pergunta write Fid_prova_pergunta;
    property ordem: Integer read Fordem write Fordem;
    property Sis_usuario_provas_perguntas_Bookmar: TArray<TSis_usuario_provas_perguntas_BookmarClass> read FSis_usuario_provas_perguntas_Bookmar write FSis_usuario_provas_perguntas_Bookmar;
    property Sis_usuario_provas_perguntas_respostas: TArray<TSis_usuario_provas_perguntas_respostasClass> read FSis_usuario_provas_perguntas_respostas write FSis_usuario_provas_perguntas_respostas;
    function ToJsonString: string;
    destructor Destroy; override;
    function AddSis_usuario_provas_perguntas_Bookmar: TSis_usuario_provas_perguntas_BookmarClass;
    function AddSis_usuario_provas_perguntas_respostas: TSis_usuario_provas_perguntas_respostasClass;
    class function FromJsonString(AJsonString: string): TSis_usuario_provas_perguntasClass;
  end;

  TSis_usuario_provasClass = class
  private
    FData_hora_fim: Extended;
    FData_hora_inicio: Extended;
    FId: Extended;
    FId_prova: Extended;
    FId_usuario: Extended;
    FQuantidade_acertos: Extended;
    FSis_usuario_provas_perguntas: TArray<TSis_usuario_provas_perguntasClass>;
  public
    property data_hora_fim: Extended read FData_hora_fim write FData_hora_fim;
    property data_hora_inicio: Extended read FData_hora_inicio write FData_hora_inicio;
    property id: Extended read FId write FId;
    property id_prova: Extended read FId_prova write FId_prova;
    property id_usuario: Extended read FId_usuario write FId_usuario;
    property quantidade_acertos: Extended read FQuantidade_acertos write FQuantidade_acertos;
    property Sis_usuario_provas_perguntas: TArray<TSis_usuario_provas_perguntasClass> read FSis_usuario_provas_perguntas write FSis_usuario_provas_perguntas;
    function ToJsonString: string;
    destructor Destroy; override;
    function Add: TSis_usuario_provas_perguntasClass;
    class function FromJsonString(AJsonString: string): TSis_usuario_provasClass;
  end;

  TSisUsuarioProvasJSON = class
  private
    FSis_usuario_provas: TSis_usuario_provasClass;
  public
    property sis_usuario_provas: TSis_usuario_provasClass read FSis_usuario_provas write FSis_usuario_provas;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TSisUsuarioProvasJSON;
  end;

implementation

{TSis_usuario_provasClass}

function TSis_usuario_provasClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

function TSis_usuario_provasClass.Add: TSis_usuario_provas_perguntasClass;
begin
  SetLength(FSis_usuario_provas_perguntas, Length(FSis_usuario_provas_perguntas) + 1);
  FSis_usuario_provas_perguntas[Length(FSis_usuario_provas_perguntas) - 1] := TSis_usuario_provas_perguntasClass.Create;
  Result := FSis_usuario_provas_perguntas[Length(FSis_usuario_provas_perguntas) - 1];
end;

destructor TSis_usuario_provasClass.Destroy;
var
  Sis_usuario_provas_perguntas: TSis_usuario_provas_perguntasClass;
begin
  for Sis_usuario_provas_perguntas in FSis_usuario_provas_perguntas do
    Sis_usuario_provas_perguntas.Free;

  inherited;
end;

class function TSis_usuario_provasClass.FromJsonString(AJsonString: string): TSis_usuario_provasClass;
begin
  result := TJson.JsonToObject<TSis_usuario_provasClass>(AJsonString);
end;

{TRootClass}

constructor TSisUsuarioProvasJSON.Create;
begin
  inherited;
  FSis_usuario_provas := TSis_usuario_provasClass.Create();
end;

destructor TSisUsuarioProvasJSON.Destroy;
begin
  FSis_usuario_provas.free;
  inherited;
end;

function TSisUsuarioProvasJSON.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TSisUsuarioProvasJSON.FromJsonString(AJsonString: string): TSisUsuarioProvasJSON;
begin
  result := TJson.JsonToObject<TSisUsuarioProvasJSON>(AJsonString);
end;

{ TSis_usuario_provas_perguntas_respostasClass }

class function TSis_usuario_provas_perguntas_respostasClass.FromJsonString(
  AJsonString: string): TSis_usuario_provas_perguntas_respostasClass;
begin
  result := TJson.JsonToObject<TSis_usuario_provas_perguntas_respostasClass>(AJsonString);
end;

function TSis_usuario_provas_perguntas_respostasClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

{ TSis_usuario_provas_perguntasClass }

function TSis_usuario_provas_perguntasClass.AddSis_usuario_provas_perguntas_Bookmar: TSis_usuario_provas_perguntas_BookmarClass;
begin
  SetLength(FSis_usuario_provas_perguntas_Bookmar, Length(FSis_usuario_provas_perguntas_Bookmar) + 1);
  FSis_usuario_provas_perguntas_Bookmar[Length(FSis_usuario_provas_perguntas_Bookmar) - 1] := TSis_usuario_provas_perguntas_BookmarClass.Create;
  Result := FSis_usuario_provas_perguntas_Bookmar[Length(FSis_usuario_provas_perguntas_Bookmar) - 1];
end;

function TSis_usuario_provas_perguntasClass.AddSis_usuario_provas_perguntas_respostas: TSis_usuario_provas_perguntas_respostasClass;
begin
  SetLength(FSis_usuario_provas_perguntas_Respostas, Length(FSis_usuario_provas_perguntas_Respostas) + 1);
  FSis_usuario_provas_perguntas_Respostas[Length(FSis_usuario_provas_perguntas_Respostas) - 1] := TSis_usuario_provas_perguntas_respostasClass.Create;
  Result := FSis_usuario_provas_perguntas_Respostas[Length(FSis_usuario_provas_perguntas_Respostas) - 1];
end;

destructor TSis_usuario_provas_perguntasClass.Destroy;
var
  Sis_usuario_provas_perguntas_Bookmar: TSis_usuario_provas_perguntas_BookmarClass;
  Sis_usuario_provas_perguntas_respostas: TSis_usuario_provas_perguntas_respostasClass;
begin
  for Sis_usuario_provas_perguntas_Bookmar in FSis_usuario_provas_perguntas_Bookmar do
    Sis_usuario_provas_perguntas_Bookmar.Free;

  for Sis_usuario_provas_perguntas_respostas in FSis_usuario_provas_perguntas_respostas do
    Sis_usuario_provas_perguntas_respostas.Free;

  inherited;
end;

class function TSis_usuario_provas_perguntasClass.FromJsonString(
  AJsonString: string): TSis_usuario_provas_perguntasClass;
begin
  result := TJson.JsonToObject<TSis_usuario_provas_perguntasClass>(AJsonString);
end;

function TSis_usuario_provas_perguntasClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

{ TSis_usuario_provas_perguntas_BookmarClass }

class function TSis_usuario_provas_perguntas_BookmarClass.FromJsonString(
  AJsonString: string): TSis_usuario_provas_perguntas_BookmarClass;
begin
  result := TJson.JsonToObject<TSis_usuario_provas_perguntas_BookmarClass>(AJsonString);
end;

function TSis_usuario_provas_perguntas_BookmarClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

end.

