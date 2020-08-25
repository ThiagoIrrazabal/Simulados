unit uSisCategorias;

interface

uses
  Data.SqlExpr,
  System.StrUtils,
  System.SysUtils,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  uConexao;

type
  /// <summary>
  /// Table: SIS_CATEGORIA.
  /// </summary>
  ISisCategorias = interface(IInterface)
    ['{6AB096CC-8DB5-4E99-B93C-5851FBFE7D4B}']

    /// <summary>
    /// Field: ID.
    /// </summary>
    function ID(const Value: Integer): ISisCategorias; overload;
    function ID: Integer; overload;
    function ConsultaID(const Value: Integer): ISisCategorias;

     /// <summary>
    /// Field: DESCRICAO.
    /// </summary>
    function Descricao(const Value: string): ISisCategorias; overload;
    function Descricao: string; overload;

    /// <summary>
    /// Field: LISTA_SIS_CATEGORIAS.
    /// </summary>
    function ListaSisCategorias(const Value: TArray<ISisCategorias>): ISisCategorias; overload;
    function ListaSisCategorias: TArray<ISisCategorias>; overload;

    function Find: ISisCategorias;
    function DestroyComponents: ISisCategorias;
    function CloseConnection: ISisCategorias;
  end;

  TSisCategorias = class(TConexao, ISisCategorias)
  strict private
    FID: Integer;
    FDescricao: string;
    FSQLConsulta: TStringBuilder;
    FListaSisCategorias: TArray<ISisCategorias>;
    procedure ClearFields;
  public
    constructor Create; overload;
    destructor Destroy; override;
    class function New: ISisCategorias;
    function ID(const Value: Integer): ISisCategorias; overload;
    function ID: Integer; overload;
    function ConsultaID(const Value: Integer): ISisCategorias;
    function Descricao(const Value: string): ISisCategorias; overload;
    function Descricao: string; overload;
    function ListaSisCategorias(const Value: TArray<ISisCategorias>): ISisCategorias; overload;
    function ListaSisCategorias: TArray<ISisCategorias>; overload;
    function Find: ISisCategorias;
    function DestroyComponents: ISisCategorias;
    function CloseConnection: ISisCategorias;
  end;

implementation

{ TSisCategorias }

constructor TSisCategorias.Create;
begin
  inherited Create;
  FSQLConsulta := TStringBuilder.Create;
  FSQLConsulta.Append('select ID, DESCRICAO, COUNT(*) over() from SIS_CATEGORIAS where 0=0 ');

  ClearFields;
end;

destructor TSisCategorias.Destroy;
begin
  Self.DestroyComponents;
  inherited;
end;

function TSisCategorias.DestroyComponents: ISisCategorias;
var
  I: Integer;
begin
  Result := Self;
  for I := 0 to Length(FListaSisCategorias) - 1 do
    FListaSisCategorias[I] := nil;

  if Assigned(FSQLConsulta) then
    FreeAndNil(FSQLConsulta);
end;

class function TSisCategorias.New: ISisCategorias;
begin
  Result := Self.Create;
end;

procedure TSisCategorias.ClearFields;
begin
  Self.FID := -1;
  Self.FDescricao := EmptyStr;
end;

function TSisCategorias.Descricao(const Value: string): ISisCategorias;
begin
  Result := Self;
  FDescricao := Value;
end;

function TSisCategorias.Descricao: string;
begin
  Result := FDescricao;
end;

function TSisCategorias.ID(const Value: Integer): ISisCategorias;
begin
  Result := Self;
  FID := Value;
end;

function TSisCategorias.ID: Integer;
begin
  Result := FID;
end;

function TSisCategorias.ListaSisCategorias: TArray<ISisCategorias>;
begin
  Result := FListaSisCategorias;
end;

function TSisCategorias.ListaSisCategorias(
  const Value: TArray<ISisCategorias>): ISisCategorias;
begin
  Result := Self;
  FListaSisCategorias := Value;
end;

function TSisCategorias.CloseConnection: ISisCategorias;
begin
  Result := Self;
  if Assigned(Connection) then
    Connection.Close;
end;

function TSisCategorias.ConsultaID(const Value: Integer): ISisCategorias;
begin
  Result := Self;
  FSQLConsulta.Append(' AND ID = ' + Value.ToString);
end;

function TSisCategorias.Find: ISisCategorias;
var
  sdsConsulta: TFDQuery;
begin
  Result := Self;
  sdsConsulta := TFDQuery.Create(nil);
  try
    sdsConsulta.Connection := Connection;
    sdsConsulta.SQL.Add(FSQLConsulta.ToString + ' ORDER BY ID ASC');
    sdsConsulta.Open;
    if not(sdsConsulta.IsEmpty) then
    begin
      Self.FID := sdsConsulta.FieldByName('ID').AsInteger;
      Self.FDescricao := sdsConsulta.FieldByName('DESCRICAO').AsString;

      SetLength(FListaSisCategorias, sdsConsulta.FieldByName('COUNT').AsInteger);
      sdsConsulta.First;
      while not(sdsConsulta.Eof) do
      begin
        FListaSisCategorias[sdsConsulta.RecNo - 1] :=
          TSisCategorias.New
                        .ID(sdsConsulta.FieldByName('ID').AsInteger)
                        .Descricao(sdsConsulta.FieldByName('DESCRICAO').AsString);
        sdsConsulta.Next;
      end;
    end
    else ClearFields;
  finally
    FreeAndNil(sdsConsulta);
  end;
end;

end.
