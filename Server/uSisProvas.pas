unit uSisProvas;

interface

uses
  Data.SqlExpr,
  System.StrUtils,
  System.SysUtils,
  uSisProvasPerguntas,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  uConexao;
 
type 
  /// <summary> 
  /// Table: SIS_PROVAS. 
  /// </summary> 
  ISisProvas = interface(IInterface) 
    ['{423810D0-2B7C-4281-8141-CA358D6A9D5A}'] 
 
    /// <summary> 
    /// Field: TEMPO. 
    /// </summary> 
    function Tempo(const Value: Integer): ISisProvas; overload; 
    function Tempo: Integer; overload; 
    function ConsultaTempo(const Value: Integer): ISisProvas; 
 
    /// <summary> 
    /// Field: DESCRICAO. 
    /// </summary> 
    function Descricao(const Value: string): ISisProvas; overload;
    function Descricao: string; overload; 
    function ConsultaDescricao(const Value: string): ISisProvas; 
 
    /// <summary>
    /// Field: ID.
    /// </summary>
    function ID(const Value: Integer): ISisProvas; overload;
    function ID: Integer; overload;
    function ConsultaID(const Value: Integer): ISisProvas;

    /// <summary>
    /// Field: SIS_PROVAS_PERGUNTAS.
    /// </summary>
    function ListaSisProvasPerguntas(const Value: TArray<ISisProvasPerguntas>): ISisProvas; overload;
    function ListaSisProvasPerguntas: TArray<ISisProvasPerguntas>; overload;
    function ConsultaListaSisProvasPerguntas(const Value: Integer): ISisProvas;
 
    function Find: ISisProvas;
    function Insert: ISisProvas;
    function InsertIf(const Value: Boolean): ISisProvas;
    function DestroyComponents: ISisProvas;
    function CloseConnection: ISisProvas;
  end;

  TSisProvas = class(TConexao, ISisProvas)
  strict private
    FTempo: Integer;
    FDescricao: string;
    FID: Integer;
    FListaSisProvasPerguntas: TArray<ISisProvasPerguntas>;
    FSQLConsulta: TStringBuilder;
    FSQLInsert: TStringBuilder; 
    procedure ClearFields;
  public
    constructor Create; overload;
    destructor Destroy; override; 
    class function New: ISisProvas;
    function Tempo(const Value: Integer): ISisProvas; overload; 
    function Tempo: Integer; overload; 
    function ConsultaTempo(const Value: Integer): ISisProvas; 
    function Descricao(const Value: string): ISisProvas; overload;
    function Descricao: string; overload; 
    function ConsultaDescricao(const Value: string): ISisProvas; 
    function ID(const Value: Integer): ISisProvas; overload; 
    function ID: Integer; overload;
    function ConsultaID(const Value: Integer): ISisProvas;
    function ListaSisProvasPerguntas(const Value: TArray<ISisProvasPerguntas>): ISisProvas; overload;
    function ListaSisProvasPerguntas: TArray<ISisProvasPerguntas>; overload;
    function ConsultaListaSisProvasPerguntas(const Value: Integer): ISisProvas;
    function Find: ISisProvas; 
    function Insert: ISisProvas;
    function InsertIf(const Value: Boolean): ISisProvas;
    function DestroyComponents: ISisProvas;
    function CloseConnection: ISisProvas;
  end; 
 
implementation 
 
{ TSisProvas }
 
constructor TSisProvas.Create;
begin 
  inherited Create(True);
  FSQLConsulta := TStringBuilder.Create; 
  FSQLConsulta.Append('select * from SIS_PROVAS where 0=0 '); 
 
  FSQLInsert := TStringBuilder.Create; 
  FSQLInsert.Append('insert into SIS_PROVAS '); 
 
  ClearFields; 
end; 
 
destructor TSisProvas.Destroy;
begin
  Self.DestroyComponents;
  inherited;
end; 
 
function TSisProvas.DestroyComponents: ISisProvas;
var
  I, Y: Integer;
begin
  Result := Self;
  for I := 0 to Length(FListaSisProvasPerguntas) - 1 do
  begin
    for Y := 0 to Length(FListaSisProvasPerguntas[I].ListaSisProvasPerguntasRespostas) - 1 do
      FListaSisProvasPerguntas[I].ListaSisProvasPerguntasRespostas[Y] := nil;

    FListaSisProvasPerguntas[I] := nil;
  end;

  if Assigned(FSQLConsulta) then
    FreeAndNil(FSQLConsulta);

  if Assigned(FSQLInsert) then
    FreeAndNil(FSQLInsert);
end;

class function TSisProvas.New: ISisProvas;
begin 
  Result := Self.Create;
end; 
 
function TSisProvas.ListaSisProvasPerguntas(
  const Value: TArray<ISisProvasPerguntas>): ISisProvas;
begin
  Result := Self;
  FListaSisProvasPerguntas := Value;
end;

function TSisProvas.ListaSisProvasPerguntas: TArray<ISisProvasPerguntas>;
begin
  Result := FListaSisProvasPerguntas;
end;

procedure TSisProvas.ClearFields;
begin 
  Self.FTempo := -1; 
  Self.FDescricao := ''; 
  Self.FID := -1; 
end; 
 
function TSisProvas.Tempo(const Value: Integer): ISisProvas; 
begin 
  Result := Self; 
  FTempo := Value; 
end; 
 
function TSisProvas.Tempo: Integer; 
begin 
  Result := FTempo; 
end; 
 
function TSisProvas.ConsultaTempo(const Value: Integer): ISisProvas; 
begin 
  Result := Self; 
  FSQLConsulta.Append(' AND TEMPO = ' + Value.ToString); 
end; 
 
function TSisProvas.Descricao(const Value: string): ISisProvas; 
begin 
  Result := Self; 
  FDescricao := Value; 
end; 
 
function TSisProvas.Descricao: string; 
begin 
  Result := FDescricao; 
end; 
 
function TSisProvas.CloseConnection: ISisProvas;
begin
  Result := Self;
  if Assigned(Connection) then
    Connection.Close;
end;

function TSisProvas.ConsultaDescricao(const Value: string): ISisProvas;
begin 
  Result := Self; 
  FSQLConsulta.Append(' AND DESCRICAO = ' + Value.QuotedString);
end; 
 
function TSisProvas.ID(const Value: Integer): ISisProvas; 
begin 
  Result := Self; 
  FID := Value; 
end; 
 
function TSisProvas.ID: Integer; 
begin 
  Result := FID; 
end; 
 
function TSisProvas.ConsultaID(const Value: Integer): ISisProvas; 
begin 
  Result := Self;
  FSQLConsulta.Append(' AND ID = ' + Value.ToString); 
end; 
 
function TSisProvas.ConsultaListaSisProvasPerguntas(const Value: Integer): ISisProvas;
begin
  Result := Self;
  ListaSisProvasPerguntas(TSisProvasPerguntas.New
                                             .ConsultaIDProva(Value)
                                             .Find
                                             .CloseConnection
                                             .ListaISisProvasPerguntas);
end;

function TSisProvas.Find: ISisProvas;
var 
  sdsConsulta: TFDQuery;
begin 
  Result := Self;
  sdsConsulta := TFDQuery.Create(nil);
  try 
    sdsConsulta.Connection := Connection;
    sdsConsulta.SQL.Add(FSQLConsulta.ToString);
    sdsConsulta.Open; 
    if not(sdsConsulta.IsEmpty) then 
    begin 
      Self.FTempo := sdsConsulta.FieldByName('TEMPO').AsInteger; 
      Self.FDescricao := sdsConsulta.FieldByName('DESCRICAO').AsString; 
      Self.FID := sdsConsulta.FieldByName('ID').AsInteger;
    end
    else ClearFields; 
  finally
    FreeAndNil(sdsConsulta); 
  end; 
end; 
 
function TSisProvas.Insert: ISisProvas; 
var 
  sdsInsert: TFDQuery;
  Values: string; 
begin 
  Result := Self; 
  sdsInsert := TFDQuery.Create(nil);
  try 
    sdsInsert.Connection := Connection;
    // Campos Opcionais
 
    if (Self.FTempo >= 0) then
      Values := Values + ', :TEMPO'; 
 
    if not(Self.FDescricao.IsEmpty) then 
      Values := Values + ', :DESCRICAO';
 
    FSQLInsert.Append('(' + StringReplace(Values, ':', '',
      [rfReplaceAll, rfIgnoreCase]) + ')').Append(' VALUES ') 
      .Append('(' + Values + ') returning ID');
 
    sdsInsert.SQL.Add(FSQLInsert.ToString);
 
    // Campos Opcionais
 
    if (Self.FTempo >= 0) then 
      sdsInsert.ParamByName('TEMPO').AsInteger := Self.FTempo; 
 
    if not(Self.FDescricao.IsEmpty) then
      sdsInsert.ParamByName('DESCRICAO').AsString := Self.FDescricao; 
 
    sdsInsert.Open;
    Self.FID := sdsInsert.FieldByName('ID').AsInteger;
  finally 
    FreeAndNil(sdsInsert); 
  end; 
end; 
 
function TSisProvas.InsertIf(const Value: Boolean): ISisProvas; 
begin 
  if Value then 
    Result := Insert 
  else Result := Self; 
end; 

end.