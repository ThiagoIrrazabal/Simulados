unit uSisUsuarioProvas;
 
interface 
 
uses 
  Data.SqlExpr, 
  System.StrUtils, 
  System.SysUtils,
  uSisUsuarioProvasPerguntas,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  uConexao;
 
type 
  /// <summary> 
  /// Table: SIS_USUARIO_PROVAS. 
  /// </summary> 
  ISisUsuarioProvas = interface(IInterface) 
    ['{52BFF6A7-25DF-45D0-A75C-37076DAC731E}'] 
 
    /// <summary> 
    /// Field: QUANTIDADE_ACERTOS. 
    /// </summary> 
    function QuantidadeAcertos(const Value: Integer): ISisUsuarioProvas; overload; 
    function QuantidadeAcertos: Integer; overload; 
    function ConsultaQuantidadeAcertos(const Value: Integer): ISisUsuarioProvas; 
 
    /// <summary> 
    /// Field: DATA_HORA_FIM. 
    /// </summary> 
    function DataHoraFim(const Value: TDateTime): ISisUsuarioProvas; overload;
    function DataHoraFim: TDateTime; overload; 
    function ConsultaDataHoraFim(const Value: TDateTime): ISisUsuarioProvas; 
 
    /// <summary> 
    /// Field: DATA_HORA_INICIO. 
    /// </summary> 
    function DataHoraInicio(const Value: TDateTime): ISisUsuarioProvas; overload; 
    function DataHoraInicio: TDateTime; overload; 
    function ConsultaDataHoraInicio(const Value: TDateTime): ISisUsuarioProvas; 
 
    /// <summary> 
    /// Field: ID_PROVA. 
    /// </summary> 
    function IDProva(const Value: Integer): ISisUsuarioProvas; overload; 
    function IDProva: Integer; overload; 
    function ConsultaIDProva(const Value: Integer): ISisUsuarioProvas; 
 
    /// <summary> 
    /// Field: ID_USUARIO. 
    /// </summary> 
    function IDUsuario(const Value: Integer): ISisUsuarioProvas; overload; 
    function IDUsuario: Integer; overload; 
    function ConsultaIDUsuario(const Value: Integer): ISisUsuarioProvas; 
 
    /// <summary> 
    /// Field: ID. 
    /// </summary> 
    function ID(const Value: Integer): ISisUsuarioProvas; overload; 
    function ID: Integer; overload; 
    function ConsultaID(const Value: Integer): ISisUsuarioProvas;

    /// <summary>
    /// Field: LISTA_SIS_USUARIOS_PROVAS.
    /// </summary>
    function ListaSisUsuarioProvas(const Value: TArray<ISisUsuarioProvas>): ISisUsuarioProvas; overload;
    function ListaSisUsuarioProvas: TArray<ISisUsuarioProvas>; overload;

    function Find: ISisUsuarioProvas; 
    function Insert: ISisUsuarioProvas;
    function Update: ISisUsuarioProvas;
    function InsertIf(const Value: Boolean): ISisUsuarioProvas;
  end; 

  TSisUsuarioProvas = class(TConexao, ISisUsuarioProvas)
  strict private
    FQuantidadeAcertos: Integer;
    FDataHoraFim: TDateTime;
    FDataHoraInicio: TDateTime;
    FIDProva: Integer;
    FIDUsuario: Integer;
    FID: Integer;
    FSQLConsulta: TStringBuilder;
    FSQLInsert: TStringBuilder;
    FSQLUpdate: TStringBuilder;
    FListaSisUsuarioProvas: TArray<ISisUsuarioProvas>;
    procedure ClearFields;
  public
    constructor Create; overload;
    destructor Destroy; override; 
    class function New: ISisUsuarioProvas;
    function QuantidadeAcertos(const Value: Integer): ISisUsuarioProvas; overload; 
    function QuantidadeAcertos: Integer; overload; 
    function ConsultaQuantidadeAcertos(const Value: Integer): ISisUsuarioProvas; 
    function DataHoraFim(const Value: TDateTime): ISisUsuarioProvas; overload; 
    function DataHoraFim: TDateTime; overload; 
    function ConsultaDataHoraFim(const Value: TDateTime): ISisUsuarioProvas; 
    function DataHoraInicio(const Value: TDateTime): ISisUsuarioProvas; overload; 
    function DataHoraInicio: TDateTime; overload; 
    function ConsultaDataHoraInicio(const Value: TDateTime): ISisUsuarioProvas; 
    function IDProva(const Value: Integer): ISisUsuarioProvas; overload; 
    function IDProva: Integer; overload; 
    function ConsultaIDProva(const Value: Integer): ISisUsuarioProvas; 
    function IDUsuario(const Value: Integer): ISisUsuarioProvas; overload; 
    function IDUsuario: Integer; overload; 
    function ConsultaIDUsuario(const Value: Integer): ISisUsuarioProvas; 
    function ID(const Value: Integer): ISisUsuarioProvas; overload; 
    function ID: Integer; overload; 
    function ConsultaID(const Value: Integer): ISisUsuarioProvas;
    function ListaSisUsuarioProvas(const Value: TArray<ISisUsuarioProvas>): ISisUsuarioProvas; overload;
    function ListaSisUsuarioProvas: TArray<ISisUsuarioProvas>; overload;
    function Find: ISisUsuarioProvas; 
    function Insert: ISisUsuarioProvas;
    function Update: ISisUsuarioProvas;
    function InsertIf(const Value: Boolean): ISisUsuarioProvas; 
  end; 
 
implementation 
 
{ TSisUsuarioProvas }
 
constructor TSisUsuarioProvas.Create;
begin 
  inherited Create(True);
  FSQLConsulta := TStringBuilder.Create;
  FSQLConsulta.Append('select ID, ID_USUARIO, ID_PROVA, DATA_HORA_INICIO, DATA_HORA_FIM, QUANTIDADE_ACERTOS, COUNT(*) over() from SIS_USUARIO_PROVAS where 0=0 ');
 
  FSQLInsert := TStringBuilder.Create;
  FSQLInsert.Append('insert into SIS_USUARIO_PROVAS ');

  FSQLUpdate := TStringBuilder.Create;
  FSQLUpdate.Append('update SIS_USUARIO_PROVAS set ');

  ClearFields; 
end; 
 
destructor TSisUsuarioProvas.Destroy; 
var
  I: Integer;
begin
  for I := 0 to Length(FListaSisUsuarioProvas) - 1 do
    FListaSisUsuarioProvas[I] := nil;

  if Assigned(FSQLConsulta) then
    FreeAndNil(FSQLConsulta);

  if Assigned(FSQLInsert) then
    FreeAndNil(FSQLInsert);

  if Assigned(FSQLUpdate) then
    FreeAndNil(FSQLUpdate);

  inherited;
end; 
 
class function TSisUsuarioProvas.New: ISisUsuarioProvas;
begin 
  Result := Self.Create;
end; 
 
procedure TSisUsuarioProvas.ClearFields;
begin 
  Self.FQuantidadeAcertos := -1; 
  Self.FDataHoraFim := 0; 
  Self.FDataHoraInicio := 0; 
  Self.FIDProva := -1; 
  Self.FIDUsuario := -1; 
  Self.FID := -1; 
end; 
 
function TSisUsuarioProvas.QuantidadeAcertos(const Value: Integer): ISisUsuarioProvas; 
begin 
  Result := Self; 
  FQuantidadeAcertos := Value; 
end; 
 
function TSisUsuarioProvas.QuantidadeAcertos: Integer; 
begin 
  Result := FQuantidadeAcertos; 
end; 
 
function TSisUsuarioProvas.Update: ISisUsuarioProvas;
var
  sdsUpdate: TFDQuery;
  Values: string;
begin
  Result := Self;
  sdsUpdate := TFDQuery.Create(nil);
  try
    sdsUpdate.Connection := Connection;

    Values := Values + 'DATA_HORA_FIM = :DATA_HORA_FIM';

    if (Self.FQuantidadeAcertos >= 0) then
      Values := Values + ', QUANTIDADE_ACERTOS = :QUANTIDADE_ACERTOS';

    FSQLUpdate.Append(Values)
              .Append(' where ')
              .Append('   id = :id');

    sdsUpdate.SQL.Add(FSQLUpdate.ToString);

    sdsUpdate.ParamByName('DATA_HORA_FIM').AsDateTime := Self.FDataHoraFim;

    if (Self.FQuantidadeAcertos >= 0) then
      sdsUpdate.ParamByName('QUANTIDADE_ACERTOS').AsInteger := Self.FQuantidadeAcertos;

    sdsUpdate.ParamByName('ID').AsInteger := Self.FID;

    sdsUpdate.ExecSQL;
  finally
    FreeAndNil(sdsUpdate);
  end;
end;

function TSisUsuarioProvas.ConsultaQuantidadeAcertos(const Value: Integer): ISisUsuarioProvas;
begin 
  Result := Self; 
  FSQLConsulta.Append(' AND QUANTIDADE_ACERTOS = ' + Value.ToString); 
end; 
 
function TSisUsuarioProvas.DataHoraFim(const Value: TDateTime): ISisUsuarioProvas; 
begin 
  Result := Self; 
  FDataHoraFim := Value; 
end; 
 
function TSisUsuarioProvas.DataHoraFim: TDateTime; 
begin 
  Result := FDataHoraFim; 
end; 
 
function TSisUsuarioProvas.ConsultaDataHoraFim(const Value: TDateTime): ISisUsuarioProvas; 
begin 
  Result := Self; 
  FSQLConsulta.Append(' AND DATA_HORA_FIM = ' + FormatDateTime('dd.mm.yyyy', Value).QuotedString);
end; 
 
function TSisUsuarioProvas.DataHoraInicio(const Value: TDateTime): ISisUsuarioProvas; 
begin 
  Result := Self; 
  FDataHoraInicio := Value; 
end; 
 
function TSisUsuarioProvas.DataHoraInicio: TDateTime; 
begin 
  Result := FDataHoraInicio; 
end; 
 
function TSisUsuarioProvas.ConsultaDataHoraInicio(const Value: TDateTime): ISisUsuarioProvas; 
begin 
  Result := Self; 
  FSQLConsulta.Append(' AND DATA_HORA_INICIO = ' + FormatDateTime('dd.mm.yyyy', Value).QuotedString);
end; 
 
function TSisUsuarioProvas.IDProva(const Value: Integer): ISisUsuarioProvas; 
begin 
  Result := Self; 
  FIDProva := Value; 
end; 
 
function TSisUsuarioProvas.IDProva: Integer; 
begin 
  Result := FIDProva; 
end; 
 
function TSisUsuarioProvas.ConsultaIDProva(const Value: Integer): ISisUsuarioProvas; 
begin 
  Result := Self; 
  FSQLConsulta.Append(' AND ID_PROVA = ' + Value.ToString); 
end; 
 
function TSisUsuarioProvas.IDUsuario(const Value: Integer): ISisUsuarioProvas; 
begin 
  Result := Self; 
  FIDUsuario := Value; 
end; 
 
function TSisUsuarioProvas.IDUsuario: Integer; 
begin 
  Result := FIDUsuario; 
end; 
 
function TSisUsuarioProvas.ConsultaIDUsuario(const Value: Integer): ISisUsuarioProvas; 
begin 
  Result := Self; 
  FSQLConsulta.Append(' AND ID_USUARIO = ' + Value.ToString); 
end; 
 
function TSisUsuarioProvas.ID(const Value: Integer): ISisUsuarioProvas; 
begin 
  Result := Self; 
  FID := Value; 
end; 
 
function TSisUsuarioProvas.ID: Integer; 
begin 
  Result := FID; 
end; 
 
function TSisUsuarioProvas.ConsultaID(const Value: Integer): ISisUsuarioProvas; 
begin 
  Result := Self; 
  FSQLConsulta.Append(' AND ID = ' + Value.ToString); 
end; 
 
function TSisUsuarioProvas.Find: ISisUsuarioProvas; 
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
      Self.FQuantidadeAcertos := sdsConsulta.FieldByName('QUANTIDADE_ACERTOS').AsInteger;
      Self.FDataHoraFim := sdsConsulta.FieldByName('DATA_HORA_FIM').AsDateTime;
      Self.FDataHoraInicio := sdsConsulta.FieldByName('DATA_HORA_INICIO').AsDateTime;
      Self.FIDProva := sdsConsulta.FieldByName('ID_PROVA').AsInteger; 
      Self.FIDUsuario := sdsConsulta.FieldByName('ID_USUARIO').AsInteger; 
      Self.FID := sdsConsulta.FieldByName('ID').AsInteger;

      SetLength(FListaSisUsuarioProvas, sdsConsulta.FieldByName('COUNT').AsInteger);
      sdsConsulta.First;
      while not(sdsConsulta.Eof) do
      begin
        FListaSisUsuarioProvas[sdsConsulta.RecNo - 1] :=
          TSisUsuarioProvas.New
                           .ID(sdsConsulta.FieldByName('ID').AsInteger)
                           .IDProva(sdsConsulta.FieldByName('ID_PROVA').AsInteger)
                           .IDUsuario(sdsConsulta.FieldByName('ID_USUARIO').AsInteger)
                           .DataHoraInicio(sdsConsulta.FieldByName('DATA_HORA_INICIO').AsDateTime)
                           .DataHoraFim(sdsConsulta.FieldByName('DATA_HORA_FIM').AsDateTime)
                           .QuantidadeAcertos(sdsConsulta.FieldByName('QUANTIDADE_ACERTOS').AsInteger);
        sdsConsulta.Next;
      end;
    end 
    else ClearFields; 
  finally 
    FreeAndNil(sdsConsulta); 
  end; 
end; 
 
function TSisUsuarioProvas.Insert: ISisUsuarioProvas; 
var
  sdsInsert: TFDQuery;
  Values: string; 
begin 
  Result := Self;
  sdsInsert := TFDQuery.Create(nil);
  try 
    sdsInsert.Connection := Connection;

    // Chaves Primárias - Campos Obrigatórios
    Values := ':ID_PROVA';

    // Campos Opcionais
    if (Self.FQuantidadeAcertos >= 0) then
      Values := Values + ', :QUANTIDADE_ACERTOS'; 
 
    if (Self.FDataHoraFim > 0) then
      Values := Values + ', :DATA_HORA_FIM'; 
 
    if (Self.FDataHoraInicio > 0) then
      Values := Values + ', :DATA_HORA_INICIO'; 
 
    if (Self.FIDUsuario >= 0) then
      Values := Values + ', :ID_USUARIO'; 
 
    FSQLInsert.Append('(' + StringReplace(Values, ':', '',
      [rfReplaceAll, rfIgnoreCase]) + ')').Append(' VALUES ') 
      .Append('(' + Values + ') returning ID');
 
    sdsInsert.SQL.Add(FSQLInsert.ToString);
 
    // Chaves Primárias - Campos Obrigatórios
    sdsInsert.ParamByName('ID_PROVA').AsInteger := Self.FIDProva;

    // Campos Opcionais
    if (Self.FQuantidadeAcertos >= 0) then
      sdsInsert.ParamByName('QUANTIDADE_ACERTOS').AsInteger := Self.FQuantidadeAcertos; 
 
    if (Self.FDataHoraFim > 0) then 
      sdsInsert.ParamByName('DATA_HORA_FIM').AsDateTime := Self.FDataHoraFim; 
 
    if (Self.FDataHoraInicio > 0) then 
      sdsInsert.ParamByName('DATA_HORA_INICIO').AsDateTime := Self.FDataHoraInicio; 
 
    if (Self.FIDUsuario >= 0) then
      sdsInsert.ParamByName('ID_USUARIO').AsInteger := Self.FIDUsuario; 
 
    sdsInsert.Open;
    Self.FID := sdsInsert.FieldByName('ID').AsInteger;
  finally 
    FreeAndNil(sdsInsert); 
  end; 
end; 
 
function TSisUsuarioProvas.InsertIf(const Value: Boolean): ISisUsuarioProvas; 
begin 
  if Value then 
    Result := Insert 
  else Result := Self; 
end; 

function TSisUsuarioProvas.ListaSisUsuarioProvas: TArray<ISisUsuarioProvas>;
begin
  Result := FListaSisUsuarioProvas;
end;

function TSisUsuarioProvas.ListaSisUsuarioProvas(
  const Value: TArray<ISisUsuarioProvas>): ISisUsuarioProvas;
begin
  Result := Self;
  FListaSisUsuarioProvas := Value;
end;

end.