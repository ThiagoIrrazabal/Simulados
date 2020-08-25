unit uSisUsuario;
 
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
  /// Table: SIS_USUARIO. 
  /// </summary> 
  ISisUsuario = interface(IInterface)
    ['{49B7CBC1-327A-4390-8373-F427FCE5ED44}'] 
 
    /// <summary> 
    /// Field: SENHA. 
    /// </summary> 
    function Senha(const Value: string): ISisUsuario; overload; 
    function Senha: string; overload; 
    function ConsultaSenha(const Value: string): ISisUsuario; 
 
    /// <summary> 
    /// Field: EMAIL. 
    /// </summary> 
    function Email(const Value: string): ISisUsuario; overload; 
    function Email: string; overload; 
    function ConsultaEmail(const Value: string): ISisUsuario; 

    /// <summary>
    /// Field: NOME.
    /// </summary>
    function Nome(const Value: string): ISisUsuario; overload;
    function Nome: string; overload;
    function ConsultaNome(const Value: string): ISisUsuario;

    /// <summary>
    /// Field: ADM.
    /// </summary>
    function Adm(const Value: Boolean): ISisUsuario; overload;
    function Adm: Boolean; overload;

    /// <summary>
    /// Field: COMPARTILHAR.
    /// </summary>
    function Compartilhar(const Value: Boolean): ISisUsuario; overload;
    function Compartilhar: Boolean; overload;
 
    /// <summary> 
    /// Field: ID. 
    /// </summary> 
    function ID(const Value: Integer): ISisUsuario; overload; 
    function ID: Integer; overload; 
    function ConsultaID(const Value: Integer): ISisUsuario; 
 
    function Find: ISisUsuario; 
    function Insert: ISisUsuario; 
    function InsertIf(const Value: Boolean): ISisUsuario; 
  end; 

  TSisUsuario = class(TConexao, ISisUsuario)
  strict private
  var
    FSenha: string;
    FEmail: string;
    FNome: string;
    FID: Integer;
    FADM: Boolean;
    FCompartilhar: Boolean;
    FSQLConsulta: TStringBuilder;
    FSQLInsert: TStringBuilder;
    procedure ClearFields;
  public
    constructor Create; overload;
    destructor Destroy; override;
    class function New: ISisUsuario;
    function Senha(const Value: string): ISisUsuario; overload; 
    function Senha: string; overload; 
    function ConsultaSenha(const Value: string): ISisUsuario; 
    function Email(const Value: string): ISisUsuario; overload; 
    function Email: string; overload; 
    function ConsultaEmail(const Value: string): ISisUsuario; 
    function Nome(const Value: string): ISisUsuario; overload; 
    function Nome: string; overload; 
    function ConsultaNome(const Value: string): ISisUsuario; 
    function ID(const Value: Integer): ISisUsuario; overload; 
    function ID: Integer; overload;
    function ConsultaID(const Value: Integer): ISisUsuario;
    function Adm(const Value: Boolean): ISisUsuario; overload;
    function Adm: Boolean; overload;
    function Compartilhar(const Value: Boolean): ISisUsuario; overload;
    function Compartilhar: Boolean; overload;
    function Find: ISisUsuario; 
    function Insert: ISisUsuario; 
    function InsertIf(const Value: Boolean): ISisUsuario; 
  end; 
 
implementation 

{ TSisUsuario }
 
constructor TSisUsuario.Create;
begin
  inherited Create;
  FSQLConsulta := TStringBuilder.Create;
  FSQLConsulta.Append('select * from SIS_USUARIO where 0=0 '); 

  FSQLInsert := TStringBuilder.Create; 
  FSQLInsert.Append('insert into SIS_USUARIO '); 
 
  ClearFields; 
end; 
 
destructor TSisUsuario.Destroy; 
begin 
  if Assigned(FSQLConsulta) then
    FreeAndNil(FSQLConsulta); 
 
  if Assigned(FSQLInsert) then 
    FreeAndNil(FSQLInsert);

  inherited;
end; 
 
class function TSisUsuario.New: ISisUsuario;
begin
  Result := Self.Create;
end; 
 
function TSisUsuario.Adm: Boolean;
begin
  Result := FADM;
end;

function TSisUsuario.Adm(const Value: Boolean): ISisUsuario;
begin
  Result := Self;
  FADM := Value;
end;

procedure TSisUsuario.ClearFields;
begin 
  Self.FSenha := ''; 
  Self.FEmail := ''; 
  Self.FNome := ''; 
  Self.FID := -1; 
end;
 
function TSisUsuario.Senha(const Value: string): ISisUsuario; 
begin 
  Result := Self; 
  FSenha := Value; 
end; 
 
function TSisUsuario.Senha: string; 
begin 
  Result := FSenha; 
end; 
 
function TSisUsuario.ConsultaSenha(const Value: string): ISisUsuario; 
begin 
  Result := Self; 
  FSQLConsulta.Append(' AND SENHA = ' + Value.QuotedString);
end; 
 
function TSisUsuario.Email(const Value: string): ISisUsuario; 
begin 
  Result := Self; 
  FEmail := Value; 
end; 
 
function TSisUsuario.Email: string; 
begin 
  Result := FEmail; 
end; 
 
function TSisUsuario.Compartilhar: Boolean;
begin
  Result := FCompartilhar;
end;

function TSisUsuario.Compartilhar(const Value: Boolean): ISisUsuario;
begin
  Result := Self;
  FCompartilhar := Value;
end;

function TSisUsuario.ConsultaEmail(const Value: string): ISisUsuario;
begin 
  Result := Self; 
  FSQLConsulta.Append(' AND EMAIL = ' + Value.QuotedString);
end; 
 
function TSisUsuario.Nome(const Value: string): ISisUsuario; 
begin 
  Result := Self; 
  FNome := Value; 
end; 
 
function TSisUsuario.Nome: string; 
begin 
  Result := FNome; 
end; 
 
function TSisUsuario.ConsultaNome(const Value: string): ISisUsuario; 
begin 
  Result := Self; 
  FSQLConsulta.Append(' AND NOME = ' + Value.QuotedString);
end; 
 
function TSisUsuario.ID(const Value: Integer): ISisUsuario; 
begin 
  Result := Self; 
  FID := Value; 
end; 
 
function TSisUsuario.ID: Integer; 
begin 
  Result := FID; 
end; 
 
function TSisUsuario.ConsultaID(const Value: Integer): ISisUsuario; 
begin 
  Result := Self; 
  FSQLConsulta.Append(' AND ID = ' + Value.ToString); 
end; 
 
function TSisUsuario.Find: ISisUsuario; 
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
      Self.FSenha := sdsConsulta.FieldByName('SENHA').AsString; 
      Self.FEmail := sdsConsulta.FieldByName('EMAIL').AsString; 
      Self.FNome := sdsConsulta.FieldByName('NOME').AsString; 
      Self.FID := sdsConsulta.FieldByName('ID').AsInteger;
      Self.FADM := sdsConsulta.FieldByName('ADM').AsBoolean;
      Self.FCompartilhar := sdsConsulta.FieldByName('COMPARTILHAR').AsBoolean;
    end 
    else ClearFields; 
  finally 
    FreeAndNil(sdsConsulta); 
  end; 
end; 
 
function TSisUsuario.Insert: ISisUsuario; 
var 
  sdsInsert: TFDQuery;
  Values: string; 
begin
  Result := Self; 
  sdsInsert := TFDQuery.Create(nil);
  try 
    sdsInsert.Connection := Connection;
    // Campos Opcionais
 
    if not(Self.FSenha.IsEmpty) then 
      Values := Values + ':SENHA';
 
    if not(Self.FEmail.IsEmpty) then 
      Values := Values + ', :EMAIL'; 
 
    if not(Self.FNome.IsEmpty) then 
      Values := Values + ', :NOME';

    Values := Values + ', :COMPARTILHAR';
 
    FSQLInsert.Append('(' + StringReplace(Values, ':', '',
      [rfReplaceAll, rfIgnoreCase]) + ')').Append(' VALUES ') 
      .Append('(' + Values + ') returning id');
 
    sdsInsert.SQL.Add(FSQLInsert.ToString);
 
    // Campos Opcionais
 
    if not(Self.FSenha.IsEmpty) then
      sdsInsert.ParamByName('SENHA').AsString := Self.FSenha;

    if not(Self.FEmail.IsEmpty) then
      sdsInsert.ParamByName('EMAIL').AsString := Self.FEmail;

    if not(Self.FNome.IsEmpty) then
      sdsInsert.ParamByName('NOME').AsString := Self.FNome;

    sdsInsert.ParamByName('COMPARTILHAR').AsBoolean := Self.FCompartilhar;
 
    sdsInsert.Open;

    Self.FID := sdsInsert.FieldByName('ID').AsInteger;
  finally 
    FreeAndNil(sdsInsert); 
  end; 
end; 
 
function TSisUsuario.InsertIf(const Value: Boolean): ISisUsuario; 
begin 
  if Value then 
    Result := Insert 
  else Result := Self; 
end; 

end.