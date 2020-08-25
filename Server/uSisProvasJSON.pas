unit uSisProvasJSON;

interface

uses Generics.Collections, Rest.Json;

type
  TSis_provas_perguntas_respostasClass = class
  private
    FCerta: Boolean;
    FId: Extended;
    FId_pergunta: Extended;
    FOpcao: String;
    FResposta: String;
  public
    property certa: Boolean read FCerta write FCerta;
    property id: Extended read FId write FId;
    property id_pergunta: Extended read FId_pergunta write FId_pergunta;
    property opcao: String read FOpcao write FOpcao;
    property resposta: String read FResposta write FResposta;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TSis_provas_perguntas_respostasClass;
  end;

  TSis_provas_perguntasClass = class
  private
    FId: Extended;
    FId_prova: Extended;
    FPergunta: String;
    Fordem: Integer;
    FSis_provas_perguntas_respostas: TArray<TSis_provas_perguntas_respostasClass>;
    Fcategoria: String;
  public
    property id: Extended read FId write FId;
    property id_prova: Extended read FId_prova write FId_prova;
    property pergunta: String read FPergunta write FPergunta;
    property ordem: Integer read Fordem write Fordem;
    property categoria: String read Fcategoria write Fcategoria;
    property sis_provas_perguntas_respostas: TArray<TSis_provas_perguntas_respostasClass> read FSis_provas_perguntas_respostas write FSis_provas_perguntas_respostas;
    destructor Destroy; override;
    function Add: TSis_provas_perguntas_respostasClass;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TSis_provas_perguntasClass;
  end;

  TSis_provaClass = class
  private
    FDescricao: String;
    FId: Extended;
    FSis_provas_perguntas: TArray<TSis_provas_perguntasClass>;
    FTempo: Extended;
  public
    property descricao: String read FDescricao write FDescricao;
    property id: Extended read FId write FId;
    property sis_provas_perguntas: TArray<TSis_provas_perguntasClass> read FSis_provas_perguntas write FSis_provas_perguntas;
    property tempo: Extended read FTempo write FTempo;
    destructor Destroy; override;
    function Add: TSis_provas_perguntasClass;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TSis_provaClass;
  end;

  TProvasClass = class
  private
    FSis_prova: TSis_provaClass;
  public
    property sis_prova: TSis_provaClass read FSis_prova write FSis_prova;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TProvasClass;
  end;

  TProvas = class
  private
    FProvas: TArray<TProvasClass>;
  public
    property provas: TArray<TProvasClass> read FProvas write FProvas;
    destructor Destroy; override;
    function Add: TProvasClass;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TProvas;
  end;

implementation

{TSis_provas_perguntas_respostasClass}

function TSis_provas_perguntas_respostasClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TSis_provas_perguntas_respostasClass.FromJsonString(AJsonString: string): TSis_provas_perguntas_respostasClass;
begin
  result := TJson.JsonToObject<TSis_provas_perguntas_respostasClass>(AJsonString)
end;

{TSis_provas_perguntasClass}

function TSis_provas_perguntasClass.Add: TSis_provas_perguntas_respostasClass;
begin
  SetLength(FSis_provas_perguntas_respostas, Length(FSis_provas_perguntas_respostas) + 1);
  FSis_provas_perguntas_respostas[Length(FSis_provas_perguntas_respostas) - 1] := TSis_provas_perguntas_respostasClass.Create;
  Result := FSis_provas_perguntas_respostas[Length(FSis_provas_perguntas_respostas) - 1];
end;

destructor TSis_provas_perguntasClass.Destroy;
var
  Lsis_provas_perguntas_respostasItem: TSis_provas_perguntas_respostasClass;
begin
  for Lsis_provas_perguntas_respostasItem in FSis_provas_perguntas_respostas do
    Lsis_provas_perguntas_respostasItem.free;

  inherited;
end;

function TSis_provas_perguntasClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TSis_provas_perguntasClass.FromJsonString(AJsonString: string): TSis_provas_perguntasClass;
begin
  result := TJson.JsonToObject<TSis_provas_perguntasClass>(AJsonString)
end;

{TSis_provaClass}

function TSis_provaClass.Add: TSis_provas_perguntasClass;
begin
  SetLength(FSis_provas_perguntas, Length(FSis_provas_perguntas) + 1);
  FSis_provas_perguntas[Length(FSis_provas_perguntas) - 1] := TSis_provas_perguntasClass.Create;
  Result := FSis_provas_perguntas[Length(FSis_provas_perguntas) - 1];
end;

destructor TSis_provaClass.Destroy;
var
  Lsis_provas_perguntasItem: TSis_provas_perguntasClass;
begin

 for Lsis_provas_perguntasItem in FSis_provas_perguntas do
   Lsis_provas_perguntasItem.free;

  inherited;
end;

function TSis_provaClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TSis_provaClass.FromJsonString(AJsonString: string): TSis_provaClass;
begin
  result := TJson.JsonToObject<TSis_provaClass>(AJsonString)
end;

{TProvasClass}

constructor TProvasClass.Create;
begin
  inherited;
  FSis_prova := TSis_provaClass.Create();
end;

destructor TProvasClass.Destroy;
begin
  FSis_prova.free;
  inherited;
end;

function TProvasClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TProvasClass.FromJsonString(AJsonString: string): TProvasClass;
begin
  result := TJson.JsonToObject<TProvasClass>(AJsonString)
end;

{TRootClass}

function TProvas.Add: TProvasClass;
begin
  SetLength(FProvas, Length(FProvas) + 1);
  FProvas[Length(FProvas) - 1] := TProvasClass.Create;
  Result := FProvas[Length(FProvas) - 1];
end;

destructor TProvas.Destroy;
var
  LprovasItem: TProvasClass;
begin
  for LprovasItem in FProvas do
    LprovasItem.free;

  inherited;
end;

function TProvas.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TProvas.FromJsonString(AJsonString: string): TProvas;
begin
  result := TJson.JsonToObject<TProvas>(AJsonString)
end;

end.



