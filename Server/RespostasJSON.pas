unit RespostasJSON;

interface

uses Generics.Collections, Rest.Json;

type
  TRespostasClass = class
  private
    FNome: String;
    FQuestoes: String;
  public
    property nome: String read FNome write FNome;
    property questoes: String read FQuestoes write FQuestoes;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TRespostasClass;
  end;

  TRespostas = class
  private
    FRespostas: TArray<TRespostasClass>;
  public
    property respostas: TArray<TRespostasClass> read FRespostas write FRespostas;
    destructor Destroy; override;
    function Add: TRespostasClass;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TRespostas;
  end;

implementation

{TRespostasClass}


function TRespostasClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TRespostasClass.FromJsonString(AJsonString: string): TRespostasClass;
begin
  result := TJson.JsonToObject<TRespostasClass>(AJsonString)
end;

{TRootClass}

function TRespostas.Add: TRespostasClass;
begin
  SetLength(FRespostas, Length(FRespostas) + 1);
  FRespostas[Length(FRespostas) - 1] := TRespostasClass.Create;
  Result := FRespostas[Length(FRespostas) - 1];
end;

destructor TRespostas.Destroy;
var
  LrespostasItem: TRespostasClass;
begin
  for LrespostasItem in FRespostas do
    LrespostasItem.free;

  inherited;
end;

function TRespostas.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TRespostas.FromJsonString(AJsonString: string): TRespostas;
begin
  result := TJson.JsonToObject<TRespostas>(AJsonString);
end;

end.

