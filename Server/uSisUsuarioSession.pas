unit uSisUsuarioSession;
 
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
  /// Table: SIS_USUARIO_SESSION. 
  /// </summary> 
  ISisUsuarioSession = interface(IInterface) 
    ['{CE54F81A-C781-453A-AD25-B35BE2CE81F9}'] 
 
    /// <summary>
    /// Field: EXPIRES_IN.
    /// </summary>
    function ExpiresIn(const Value: Integer): ISisUsuarioSession; overload; 
    function ExpiresIn: Integer; overload; 
    function ConsultaMaxExpiresIn: ISisUsuarioSession;

    /// <summary>
    /// Field: DATA.
    /// </summary>
    function Data(const Value: TDateTime): ISisUsuarioSession; overload;
    function Data: TDateTime; overload;
 
    /// <summary> 
    /// Field: TOKEN_TYPE. 
    /// </summary> 
    function TokenType(const Value: string): ISisUsuarioSession; overload; 
    function TokenType: string; overload; 
    function ConsultaTokenType(const Value: string): ISisUsuarioSession; 
 
    /// <summary> 
    /// Field: ACCESS_TOKEN. 
    /// </summary> 
    function AccessToken(const Value: string): ISisUsuarioSession; overload; 
    function AccessToken: string; overload; 
    function ConsultaAccessToken(const Value: string): ISisUsuarioSession; 
 
    /// <summary> 
    /// Field: ID_USUARIO. 
    /// </summary> 
    function IDUsuario(const Value: Integer): ISisUsuarioSession; overload; 
    function IDUsuario: Integer; overload; 
    function ConsultaIDUsuario(const Value: Integer): ISisUsuarioSession; 
 
    /// <summary> 
    /// Field: ID. 
    /// </summary> 
    function ID(const Value: Integer): ISisUsuarioSession; overload; 
    function ID: Integer; overload; 
    function ConsultaID(const Value: Integer): ISisUsuarioSession; 
 
    function Find: ISisUsuarioSession; 
    function Insert: ISisUsuarioSession; 
    function InsertIf(const Value: Boolean): ISisUsuarioSession; 
  end; 

  TSisUsuarioSession = class(TConexao, ISisUsuarioSession)
  strict private
    FExpiresIn: Integer;
    FData: TDateTime;
    FTokenType: string;
    FAccessToken: string;
    FIDUsuario: Integer;
    FID: Integer;
    FSQLConsulta: TStringBuilder;
    FSQLInsert: TStringBuilder; 
    procedure ClearFields;
  public
    constructor Create; overload;
    destructor Destroy; override;
    class function New: ISisUsuarioSession;
    function ExpiresIn(const Value: Integer): ISisUsuarioSession; overload; 
    function ExpiresIn: Integer; overload;
    function Data(const Value: TDateTime): ISisUsuarioSession; overload;
    function Data: TDateTime; overload;
    function ConsultaMaxExpiresIn: ISisUsuarioSession;
    function TokenType(const Value: string): ISisUsuarioSession; overload;
    function TokenType: string; overload;
    function ConsultaTokenType(const Value: string): ISisUsuarioSession;
    function AccessToken(const Value: string): ISisUsuarioSession; overload;
    function AccessToken: string; overload;
    function ConsultaAccessToken(const Value: string): ISisUsuarioSession;
    function IDUsuario(const Value: Integer): ISisUsuarioSession; overload;
    function IDUsuario: Integer; overload;
    function ConsultaIDUsuario(const Value: Integer): ISisUsuarioSession;
    function ID(const Value: Integer): ISisUsuarioSession; overload;
    function ID: Integer; overload;
    function ConsultaID(const Value: Integer): ISisUsuarioSession;
    function Find: ISisUsuarioSession; 
    function Insert: ISisUsuarioSession; 
    function InsertIf(const Value: Boolean): ISisUsuarioSession; 
  end; 
 
implementation 
 
{ TSisUsuarioSession }
 
constructor TSisUsuarioSession.Create;
begin 
  inherited Create(True);
  FSQLConsulta := TStringBuilder.Create; 
  FSQLConsulta.Append('select * from SIS_USUARIO_SESSION where 0=0 '); 
 
  FSQLInsert := TStringBuilder.Create; 
  FSQLInsert.Append('insert into SIS_USUARIO_SESSION '); 
 
  ClearFields; 
end; 
 
function TSisUsuarioSession.Data: TDateTime;
begin
  Result := FData;
end;

function TSisUsuarioSession.Data(const Value: TDateTime): ISisUsuarioSession;
begin
  Result := Self;
  FData := Value;
end;

destructor TSisUsuarioSession.Destroy;
begin 
  if Assigned(FSQLConsulta) then
    FreeAndNil(FSQLConsulta);

  if Assigned(FSQLInsert) then
    FreeAndNil(FSQLInsert);

  inherited;
end; 
 
class function TSisUsuarioSession.New: ISisUsuarioSession;
begin
  Result := Self.Create;
end; 
 
procedure TSisUsuarioSession.ClearFields;
begin 
  Self.FExpiresIn := -1; 
  Self.FTokenType := ''; 
  Self.FAccessToken := ''; 
  Self.FIDUsuario := -1; 
  Self.FID := -1; 
end; 
 
function TSisUsuarioSession.ExpiresIn(const Value: Integer): ISisUsuarioSession; 
begin 
  Result := Self; 
  FExpiresIn := Value; 
end; 
 
function TSisUsuarioSession.ExpiresIn: Integer; 
begin 
  Result := FExpiresIn;
end; 
 
function TSisUsuarioSession.ConsultaMaxExpiresIn: ISisUsuarioSession;
begin
  Result := Self;
  FSQLConsulta.Append(' ORDER BY EXPIRES_IN DESC');
end; 
 
function TSisUsuarioSession.TokenType(const Value: string): ISisUsuarioSession; 
begin 
  Result := Self; 
  FTokenType := Value; 
end; 
 
function TSisUsuarioSession.TokenType: string; 
begin 
  Result := FTokenType; 
end; 
 
function TSisUsuarioSession.ConsultaTokenType(const Value: string): ISisUsuarioSession; 
begin 
  Result := Self; 
  FSQLConsulta.Append(' AND TOKEN_TYPE = ' + Value.QuotedString);
end;
 
function TSisUsuarioSession.AccessToken(const Value: string): ISisUsuarioSession; 
begin 
  Result := Self; 
  FAccessToken := Value; 
end; 
 
function TSisUsuarioSession.AccessToken: string; 
begin 
  Result := FAccessToken; 
end; 
 
function TSisUsuarioSession.ConsultaAccessToken(const Value: string): ISisUsuarioSession; 
begin 
  Result := Self; 
  FSQLConsulta.Append(' AND ACCESS_TOKEN = ' + Value.QuotedString);
end; 
 
function TSisUsuarioSession.IDUsuario(const Value: Integer): ISisUsuarioSession; 
begin 
  Result := Self; 
  FIDUsuario := Value; 
end; 
 
function TSisUsuarioSession.IDUsuario: Integer; 
begin 
  Result := FIDUsuario; 
end; 
 
function TSisUsuarioSession.ConsultaIDUsuario(const Value: Integer): ISisUsuarioSession; 
begin 
  Result := Self; 
  FSQLConsulta.Append(' AND ID_USUARIO = ' + Value.ToString); 
end; 
 
function TSisUsuarioSession.ID(const Value: Integer): ISisUsuarioSession; 
begin 
  Result := Self; 
  FID := Value; 
end; 
 
function TSisUsuarioSession.ID: Integer; 
begin 
  Result := FID; 
end; 
 
function TSisUsuarioSession.ConsultaID(const Value: Integer): ISisUsuarioSession; 
begin 
  Result := Self; 
  FSQLConsulta.Append(' AND ID = ' + Value.ToString); 
end; 
 
function TSisUsuarioSession.Find: ISisUsuarioSession; 
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
      Self.FExpiresIn := sdsConsulta.FieldByName('EXPIRES_IN').AsInteger; 
      Self.FTokenType := sdsConsulta.FieldByName('TOKEN_TYPE').AsString; 
      Self.FAccessToken := sdsConsulta.FieldByName('ACCESS_TOKEN').AsString; 
      Self.FIDUsuario := sdsConsulta.FieldByName('ID_USUARIO').AsInteger; 
      Self.FID := sdsConsulta.FieldByName('ID').AsInteger;
      Self.FData := sdsConsulta.FieldByName('DATA').AsDateTime;
    end 
    else ClearFields; 
  finally 
    FreeAndNil(sdsConsulta); 
  end; 
end; 
 
function TSisUsuarioSession.Insert: ISisUsuarioSession; 
var 
  sdsInsert: TFDQuery;
  Values: string; 
begin 
  Result := Self; 
  sdsInsert := TFDQuery.Create(nil);
  try 
    sdsInsert.Connection := Connection;
    // Campos Opcionais
 
    if (Self.FExpiresIn >= 0) then
      Values := ':EXPIRES_IN';

    if (Self.FData >= 0) then
      Values := Values + ', :DATA';
 
    if not(Self.FTokenType.IsEmpty) then 
      Values := Values + ', :TOKEN_TYPE'; 
 
    if not(Self.FAccessToken.IsEmpty) then 
      Values := Values + ', :ACCESS_TOKEN'; 
 
    if (Self.FIDUsuario >= 0) then
      Values := Values + ', :ID_USUARIO'; 
 
    FSQLInsert.Append('(' + StringReplace(Values, ':', '',
      [rfReplaceAll, rfIgnoreCase]) + ')').Append(' VALUES ') 
      .Append('(' + Values + ') returning id');
 
    sdsInsert.SQL.Add(FSQLInsert.ToString);

    // Campos Opcionais

    if (Self.FExpiresIn >= 0) then
      sdsInsert.ParamByName('EXPIRES_IN').AsInteger := Self.FExpiresIn;

    if (Self.FData >= 0) then
      sdsInsert.ParamByName('DATA').AsDateTime := Self.FData;

    if not(Self.FTokenType.IsEmpty) then
      sdsInsert.ParamByName('TOKEN_TYPE').AsString := Self.FTokenType;

    if not(Self.FAccessToken.IsEmpty) then
      sdsInsert.ParamByName('ACCESS_TOKEN').AsString := Self.FAccessToken;
 
    if (Self.FIDUsuario >= 0) then 
      sdsInsert.ParamByName('ID_USUARIO').AsInteger := Self.FIDUsuario; 
 
    sdsInsert.Open;

    Self.FID := sdsInsert.FieldByName('ID').AsInteger;
  finally 
    FreeAndNil(sdsInsert); 
  end; 
end; 
 
function TSisUsuarioSession.InsertIf(const Value: Boolean): ISisUsuarioSession; 
begin 
  if Value then 
    Result := Insert 
  else Result := Self; 
end; 

end.