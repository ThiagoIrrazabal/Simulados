unit uSisPerguntasCategoriasJSON;

interface

uses Generics.Collections, Rest.Json;

type
  TCategoriasClass = class
  private
    FDescricao: String;
    FPercentual: Extended;
  public
    property descricao: String read FDescricao write FDescricao;
    property percentual: Extended read FPercentual write FPercentual;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TCategoriasClass;
  end;

  TCategorias = class
  private
    FCategorias: TArray<TCategoriasClass>;
  public
    property categorias: TArray<TCategoriasClass> read FCategorias write FCategorias;
    function Add: TCategoriasClass;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TCategorias;
  end;

implementation

{TCategoriasClass}


function TCategoriasClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TCategoriasClass.FromJsonString(AJsonString: string): TCategoriasClass;
begin
  result := TJson.JsonToObject<TCategoriasClass>(AJsonString)
end;

{TCategorias}

function TCategorias.Add: TCategoriasClass;
begin
  SetLength(FCategorias, Length(FCategorias) + 1);
  categorias[Length(FCategorias) - 1] := TCategoriasClass.Create;
  Result := FCategorias[Length(FCategorias) - 1];
end;

destructor TCategorias.Destroy;
var
  LcategoriasItem: TCategoriasClass;
begin
  for LcategoriasItem in FCategorias do
    LcategoriasItem.free;

  inherited;
end;

function TCategorias.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TCategorias.FromJsonString(AJsonString: string): TCategorias;
begin
  result := TJson.JsonToObject<TCategorias>(AJsonString);
end;

end.
