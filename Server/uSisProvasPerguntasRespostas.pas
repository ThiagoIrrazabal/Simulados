unit uSisProvasPerguntasRespostas;
 
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
  /// Table: SIS_PROVAS_PERGUNTAS_RESPOSTAS. 
  /// </summary> 
  ISisProvasPerguntasRespostas = interface(IInterface) 
    ['{F7504CB0-B5EB-47C0-B1AD-F0A55747134C}'] 
 
    /// <summary> 
    /// Field: CERTA. 
    /// </summary>
    function Certa(const Value: Boolean): ISisProvasPerguntasRespostas; overload;
    function Certa: Boolean; overload;
    function ConsultaCerta(const Value: Boolean): ISisProvasPerguntasRespostas;
 
    /// <summary> 
    /// Field: RESPOSTA. 
    /// </summary> 
    function Resposta(const Value: string): ISisProvasPerguntasRespostas; overload; 
    function Resposta: string; overload; 
    function ConsultaResposta(const Value: string): ISisProvasPerguntasRespostas; 
 
    /// <summary> 
    /// Field: OPCAO. 
    /// </summary> 
    function Opcao(const Value: string): ISisProvasPerguntasRespostas; overload; 
    function Opcao: string; overload; 
    function ConsultaOpcao(const Value: string): ISisProvasPerguntasRespostas; 
 
    /// <summary> 
    /// Field: ID_PERGUNTA. 
    /// </summary> 
    function IDPergunta(const Value: Integer): ISisProvasPerguntasRespostas; overload; 
    function IDPergunta: Integer; overload; 
    function ConsultaIDPergunta(const Value: Integer): ISisProvasPerguntasRespostas; 
 
    /// <summary> 
    /// Field: ID. 
    /// </summary> 
    function ID(const Value: Integer): ISisProvasPerguntasRespostas; overload; 
    function ID: Integer; overload; 
    function ConsultaID(const Value: Integer): ISisProvasPerguntasRespostas;

    /// <summary>
    /// Field: LISTA_SIS_PROVAS_PERGUNTAS_RESPOSTAS.
    /// </summary>
    function ListaSisProvasPerguntasRespostas(const Value: TArray<ISisProvasPerguntasRespostas>): ISisProvasPerguntasRespostas; overload;
    function ListaSisProvasPerguntasRespostas: TArray<ISisProvasPerguntasRespostas>; overload;
 
    function Find: ISisProvasPerguntasRespostas; 
    function Insert: ISisProvasPerguntasRespostas; 
    function InsertIf(const Value: Boolean): ISisProvasPerguntasRespostas;
    function DestroyComponents: ISisProvasPerguntasRespostas;
    function CloseConnection: ISisProvasPerguntasRespostas;
  end; 

  TSisProvasPerguntasRespostas = class(TConexao, ISisProvasPerguntasRespostas)
  strict private
    FCerta: Boolean;
    FResposta: string;
    FOpcao: string;
    FIDPergunta: Integer;
    FID: Integer;
    FListaSisProvasPerguntasRespostas: TArray<ISisProvasPerguntasRespostas>;
    FSQLConsulta: TStringBuilder;
    FSQLInsert: TStringBuilder; 
    procedure ClearFields;
  public
    constructor Create; overload;
    destructor Destroy; override;
    class function New: ISisProvasPerguntasRespostas;
    function Certa(const Value: Boolean): ISisProvasPerguntasRespostas; overload;
    function Certa: Boolean; overload;
    function ConsultaCerta(const Value: Boolean): ISisProvasPerguntasRespostas;
    function Resposta(const Value: string): ISisProvasPerguntasRespostas; overload; 
    function Resposta: string; overload; 
    function ConsultaResposta(const Value: string): ISisProvasPerguntasRespostas; 
    function Opcao(const Value: string): ISisProvasPerguntasRespostas; overload; 
    function Opcao: string; overload; 
    function ConsultaOpcao(const Value: string): ISisProvasPerguntasRespostas; 
    function IDPergunta(const Value: Integer): ISisProvasPerguntasRespostas; overload; 
    function IDPergunta: Integer; overload; 
    function ConsultaIDPergunta(const Value: Integer): ISisProvasPerguntasRespostas; 
    function ID(const Value: Integer): ISisProvasPerguntasRespostas; overload; 
    function ID: Integer; overload; 
    function ConsultaID(const Value: Integer): ISisProvasPerguntasRespostas;
    function ListaSisProvasPerguntasRespostas(const Value: TArray<ISisProvasPerguntasRespostas>): ISisProvasPerguntasRespostas; overload;
    function ListaSisProvasPerguntasRespostas: TArray<ISisProvasPerguntasRespostas>; overload;
    function Find: ISisProvasPerguntasRespostas; 
    function Insert: ISisProvasPerguntasRespostas; 
    function InsertIf(const Value: Boolean): ISisProvasPerguntasRespostas;
    function DestroyComponents: ISisProvasPerguntasRespostas;
    function CloseConnection: ISisProvasPerguntasRespostas;
  end; 
 
implementation 
 
{ TSisProvasPerguntasRespostas }
 
constructor TSisProvasPerguntasRespostas.Create;
begin 
  inherited Create(True);
  FSQLConsulta := TStringBuilder.Create;
  FSQLConsulta.Append('select * from SIS_PROVAS_PERGUNTAS_RESPOSTAS where 0=0 '); 
 
  FSQLInsert := TStringBuilder.Create; 
  FSQLInsert.Append('insert into SIS_PROVAS_PERGUNTAS_RESPOSTAS '); 
 
  ClearFields; 
end; 
 
destructor TSisProvasPerguntasRespostas.Destroy;
begin
  Self.DestroyComponents;
  inherited;
end; 
 
function TSisProvasPerguntasRespostas.DestroyComponents: ISisProvasPerguntasRespostas;
begin
  Result := Self;
  if Assigned(FSQLConsulta) then
    FreeAndNil(FSQLConsulta);

  if Assigned(FSQLInsert) then
    FreeAndNil(FSQLInsert);
end;

class function TSisProvasPerguntasRespostas.New: ISisProvasPerguntasRespostas;
begin
  Result := Self.Create;
end; 
 
procedure TSisProvasPerguntasRespostas.ClearFields;
begin 
  Self.FCerta := False;
  Self.FResposta := ''; 
  Self.FOpcao := ''; 
  Self.FIDPergunta := -1; 
  Self.FID := -1; 
end; 
 
function TSisProvasPerguntasRespostas.CloseConnection: ISisProvasPerguntasRespostas;
begin
  Result := Self;
  if Assigned(Connection) then
    Connection.Close;
end;

function TSisProvasPerguntasRespostas.Certa(const Value: Boolean): ISisProvasPerguntasRespostas;
begin 
  Result := Self; 
  FCerta := Value; 
end; 
 
function TSisProvasPerguntasRespostas.Certa: Boolean;
begin 
  Result := FCerta; 
end; 
 
function TSisProvasPerguntasRespostas.ConsultaCerta(const Value: Boolean): ISisProvasPerguntasRespostas;
begin 
  Result := Self; 
  FSQLConsulta.Append(' AND CERTA = ' + BoolToStr(Value));
end; 
 
function TSisProvasPerguntasRespostas.Resposta(const Value: string): ISisProvasPerguntasRespostas; 
begin 
  Result := Self; 
  FResposta := Value; 
end; 
 
function TSisProvasPerguntasRespostas.Resposta: string; 
begin 
  Result := FResposta; 
end; 
 
function TSisProvasPerguntasRespostas.ConsultaResposta(const Value: string): ISisProvasPerguntasRespostas; 
begin 
  Result := Self; 
  FSQLConsulta.Append(' AND RESPOSTA = ' + Value.QuotedString);
end;
 
function TSisProvasPerguntasRespostas.Opcao(const Value: string): ISisProvasPerguntasRespostas; 
begin 
  Result := Self; 
  FOpcao := Value; 
end; 
 
function TSisProvasPerguntasRespostas.Opcao: string; 
begin 
  Result := FOpcao; 
end; 
 
function TSisProvasPerguntasRespostas.ConsultaOpcao(const Value: string): ISisProvasPerguntasRespostas; 
begin 
  Result := Self; 
  FSQLConsulta.Append(' AND OPCAO = ' + Value.QuotedString);
end; 
 
function TSisProvasPerguntasRespostas.IDPergunta(const Value: Integer): ISisProvasPerguntasRespostas; 
begin 
  Result := Self; 
  FIDPergunta := Value; 
end; 
 
function TSisProvasPerguntasRespostas.IDPergunta: Integer; 
begin 
  Result := FIDPergunta; 
end; 
 
function TSisProvasPerguntasRespostas.ConsultaIDPergunta(const Value: Integer): ISisProvasPerguntasRespostas; 
begin 
  Result := Self; 
  FSQLConsulta.Append(' AND ID_PERGUNTA = ' + Value.ToString); 
end; 
 
function TSisProvasPerguntasRespostas.ID(const Value: Integer): ISisProvasPerguntasRespostas; 
begin 
  Result := Self; 
  FID := Value; 
end; 
 
function TSisProvasPerguntasRespostas.ID: Integer; 
begin 
  Result := FID; 
end; 
 
function TSisProvasPerguntasRespostas.ConsultaID(const Value: Integer): ISisProvasPerguntasRespostas; 
begin 
  Result := Self; 
  FSQLConsulta.Append(' AND ID = ' + Value.ToString); 
end; 
 
function TSisProvasPerguntasRespostas.Find: ISisProvasPerguntasRespostas; 
var 
  sdsConsulta: TFDQuery;
begin 
  Result := Self; 
  sdsConsulta := TFDQuery.Create(nil);
  try 
    sdsConsulta.Connection := Connection;
    sdsConsulta.SQL.Add(FSQLConsulta.ToString + ' ORDER BY OPCAO ASC');
    sdsConsulta.Open; 
    if not(sdsConsulta.IsEmpty) then 
    begin 
      Self.FCerta := sdsConsulta.FieldByName('CERTA').AsBoolean;
      Self.FResposta := sdsConsulta.FieldByName('RESPOSTA').AsString;
      Self.FOpcao := sdsConsulta.FieldByName('OPCAO').AsString;
      Self.FIDPergunta := sdsConsulta.FieldByName('ID_PERGUNTA').AsInteger;
      Self.FID := sdsConsulta.FieldByName('ID').AsInteger;

      SetLength(FListaSisProvasPerguntasRespostas, sdsConsulta.RecordCount);
      sdsConsulta.First;
      while not(sdsConsulta.Eof) do
      begin
        FListaSisProvasPerguntasRespostas[sdsConsulta.RecNo - 1] :=
          TSisProvasPerguntasRespostas.New
                                      .ID(sdsConsulta.FieldByName('ID').AsInteger)
                                      .IDPergunta(sdsConsulta.FieldByName('ID_PERGUNTA').AsInteger)
                                      .Resposta(sdsConsulta.FieldByName('RESPOSTA').AsString)
                                      .Opcao(sdsConsulta.FieldByName('OPCAO').AsString)
                                      .Certa(sdsConsulta.FieldByName('CERTA').AsBoolean)
                                      .CloseConnection;
        sdsConsulta.Next;
      end;
    end 
    else ClearFields; 
  finally 
    FreeAndNil(sdsConsulta); 
  end; 
end; 
 
function TSisProvasPerguntasRespostas.Insert: ISisProvasPerguntasRespostas; 
var 
  sdsInsert: TFDQuery;
  Values: string; 
begin 
  Result := Self; 
  sdsInsert := TFDQuery.Create(nil);
  try 
    sdsInsert.Connection := Connection;
    // Campos Opcionais
 
    Values := Values + ':CERTA';
 
    if not(Self.FResposta.IsEmpty) then 
      Values := Values + ', :RESPOSTA'; 
 
    if not(Self.FOpcao.IsEmpty) then 
      Values := Values + ', :OPCAO'; 
 
    if (Self.FIDPergunta >= 0) then
      Values := Values + ', :ID_PERGUNTA'; 
 
    FSQLInsert.Append('(' + StringReplace(Values, ':', '',
      [rfReplaceAll, rfIgnoreCase]) + ')').Append(' VALUES ') 
      .Append('(' + Values + ') returning ID');
 
    sdsInsert.SQL.Add(FSQLInsert.ToString);
 
    // Campos Opcionais
 
    sdsInsert.ParamByName('CERTA').AsBoolean := Self.FCerta;

    if not(Self.FResposta.IsEmpty) then
      sdsInsert.ParamByName('RESPOSTA').AsString := Self.FResposta;

    if not(Self.FOpcao.IsEmpty) then
      sdsInsert.ParamByName('OPCAO').AsString := Self.FOpcao; 
 
    if (Self.FIDPergunta >= 0) then 
      sdsInsert.ParamByName('ID_PERGUNTA').AsInteger := Self.FIDPergunta; 

    sdsInsert.Open;
    Self.FID := sdsInsert.FieldByName('ID').AsInteger;
  finally 
    FreeAndNil(sdsInsert); 
  end; 
end; 
 
function TSisProvasPerguntasRespostas.InsertIf(const Value: Boolean): ISisProvasPerguntasRespostas; 
begin 
  if Value then 
    Result := Insert 
  else Result := Self; 
end; 

function TSisProvasPerguntasRespostas.ListaSisProvasPerguntasRespostas: TArray<ISisProvasPerguntasRespostas>;
begin
  Result := FListaSisProvasPerguntasRespostas;
end;

function TSisProvasPerguntasRespostas.ListaSisProvasPerguntasRespostas(
  const Value: TArray<ISisProvasPerguntasRespostas>): ISisProvasPerguntasRespostas;
begin
  Result := Self;
  FListaSisProvasPerguntasRespostas := Value;
end;

end.