unit uSisUsuarioProvasPerguntasRespostas;

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
  /// Table: SIS_USUARIO_PROVAS_PERGUNTAS_RESPOSTAS.
  /// </summary>
  ISisUsuarioProvasPerguntasRespostas = interface(IInterface)
    ['{52BFF6A7-25DF-45D0-A75C-37076DAC731E}']

    /// <summary>
    /// Field: ID_USUARIO_PROVA_PERGUNTA.
    /// </summary>
    function IDUsuarioProvaPergunta(const Value: Integer): ISisUsuarioProvasPerguntasRespostas; overload;
    function IDUsuarioProvaPergunta: Integer; overload;
    function ConsultaIDUsuarioProvaPergunta(const Value: Integer): ISisUsuarioProvasPerguntasRespostas;

    /// <summary>
    /// Field: ID_PROVA_PERGUNTA_RESPOSTA.
    /// </summary>
    function IDProvaPerguntaResposta(const Value: Integer): ISisUsuarioProvasPerguntasRespostas; overload;
    function IDProvaPerguntaResposta: Integer; overload;
    function ConsultaIDProvaPerguntaResposta(const Value: Integer): ISisUsuarioProvasPerguntasRespostas;

    /// <summary>
    /// Field: LISTA_SIS_PROVAS_PERGUNTAS_RESPOSTAS.
    /// </summary>
    function ListaUsuarioProvasPerguntasRespostas(const Value: TArray<ISisUsuarioProvasPerguntasRespostas>): ISisUsuarioProvasPerguntasRespostas; overload;
    function ListaUsuarioProvasPerguntasRespostas: TArray<ISisUsuarioProvasPerguntasRespostas>; overload;

    /// <summary>
    /// Field: ID.
    /// </summary>
    function ID(const Value: Integer): ISisUsuarioProvasPerguntasRespostas; overload;
    function ID: Integer; overload;
    function ConsultaID(const Value: Integer): ISisUsuarioProvasPerguntasRespostas;

    function Find: ISisUsuarioProvasPerguntasRespostas;
    function Insert: ISisUsuarioProvasPerguntasRespostas;
    function InsertIf(const Value: Boolean): ISisUsuarioProvasPerguntasRespostas;
  end;

  TSisUsuarioProvasPerguntasRespostas = class(TConexao, ISisUsuarioProvasPerguntasRespostas)
  strict private
    FID: Integer;
    FIDUsuarioProvaPergunta: Integer;
    FIDProvaPerguntaResposta: Integer;
    FListaUsuarioProvasPerguntasRespostas: TArray<ISisUsuarioProvasPerguntasRespostas>;
    FSQLConsulta: TStringBuilder;
    FSQLInsert: TStringBuilder;
    procedure ClearFields;
  public
    constructor Create; overload;
    destructor Destroy; override;
    class function New: ISisUsuarioProvasPerguntasRespostas;
    function ID(const Value: Integer): ISisUsuarioProvasPerguntasRespostas; overload;
    function ID: Integer; overload;
    function ConsultaID(const Value: Integer): ISisUsuarioProvasPerguntasRespostas;
    function IDUsuarioProvaPergunta(const Value: Integer): ISisUsuarioProvasPerguntasRespostas; overload;
    function IDUsuarioProvaPergunta: Integer; overload;
    function ConsultaIDUsuarioProvaPergunta(const Value: Integer): ISisUsuarioProvasPerguntasRespostas;
    function IDProvaPerguntaResposta(const Value: Integer): ISisUsuarioProvasPerguntasRespostas; overload;
    function IDProvaPerguntaResposta: Integer; overload;
    function ConsultaIDProvaPerguntaResposta(const Value: Integer): ISisUsuarioProvasPerguntasRespostas;
    function ListaUsuarioProvasPerguntasRespostas(const Value: TArray<ISisUsuarioProvasPerguntasRespostas>): ISisUsuarioProvasPerguntasRespostas; overload;
    function ListaUsuarioProvasPerguntasRespostas: TArray<ISisUsuarioProvasPerguntasRespostas>; overload;
    function Find: ISisUsuarioProvasPerguntasRespostas;
    function Insert: ISisUsuarioProvasPerguntasRespostas;
    function InsertIf(const Value: Boolean): ISisUsuarioProvasPerguntasRespostas;
  end;

implementation

{ TSisUsuarioProvasPerguntasRespostas }

constructor TSisUsuarioProvasPerguntasRespostas.Create;
begin
  inherited Create(True);
  FSQLConsulta := TStringBuilder.Create;
  FSQLConsulta.Append('select * from SIS_USUARIO_PROVAS_PERGUNTAS_RESPOSTAS where 0=0 ');

  FSQLInsert := TStringBuilder.Create;
  FSQLInsert.Append('insert into SIS_USUARIO_PROVAS_PERGUNTAS_RESPOSTAS ');

  ClearFields;
end;

destructor TSisUsuarioProvasPerguntasRespostas.Destroy;
begin
  if Assigned(FSQLConsulta) then
    FreeAndNil(FSQLConsulta);

  if Assigned(FSQLInsert) then
    FreeAndNil(FSQLInsert);

  inherited;
end;

class function TSisUsuarioProvasPerguntasRespostas.New: ISisUsuarioProvasPerguntasRespostas;
begin
  Result := Self.Create;
end;

procedure TSisUsuarioProvasPerguntasRespostas.ClearFields;
begin
  Self.FID := -1;
  Self.FIDUsuarioProvaPergunta := -1;
  Self.FIDProvaPerguntaResposta := -1;
end;

function TSisUsuarioProvasPerguntasRespostas.IDProvaPerguntaResposta(
  const Value: Integer): ISisUsuarioProvasPerguntasRespostas;
begin
  Result := Self;
  FIDProvaPerguntaResposta := Value;
end;

function TSisUsuarioProvasPerguntasRespostas.IDProvaPerguntaResposta: Integer;
begin
  Result := FIDProvaPerguntaResposta;
end;

function TSisUsuarioProvasPerguntasRespostas.IDUsuarioProvaPergunta(
  const Value: Integer): ISisUsuarioProvasPerguntasRespostas;
begin
  Result := Self;
  FIDUsuarioProvaPergunta := Value;
end;

function TSisUsuarioProvasPerguntasRespostas.IDUsuarioProvaPergunta: Integer;
begin
  Result := FIDUsuarioProvaPergunta;
end;

function TSisUsuarioProvasPerguntasRespostas.ConsultaIDUsuarioProvaPergunta(
  const Value: Integer): ISisUsuarioProvasPerguntasRespostas;
begin
  Result := Self;
  FSQLConsulta.Append(' AND ID_USUARIO_PROVA_PERGUNTA = ' + Value.ToString);
end;

function TSisUsuarioProvasPerguntasRespostas.ID(const Value: Integer): ISisUsuarioProvasPerguntasRespostas;
begin
  Result := Self;
  FID := Value;
end;

function TSisUsuarioProvasPerguntasRespostas.ID: Integer;
begin
  Result := FID;
end;

function TSisUsuarioProvasPerguntasRespostas.ConsultaID(const Value: Integer): ISisUsuarioProvasPerguntasRespostas;
begin
  Result := Self;
  FSQLConsulta.Append(' AND ID = ' + Value.ToString);
end;

function TSisUsuarioProvasPerguntasRespostas.ConsultaIDProvaPerguntaResposta(
  const Value: Integer): ISisUsuarioProvasPerguntasRespostas;
begin
  Result := Self;
  FSQLConsulta.Append(' AND ID_PROVA_PERGUNTA_RESPOSTA = ' + Value.ToString);
end;

function TSisUsuarioProvasPerguntasRespostas.Find: ISisUsuarioProvasPerguntasRespostas;
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
      Self.FID := sdsConsulta.FieldByName('ID').AsInteger;
      Self.FIDUsuarioProvaPergunta := sdsConsulta.FieldByName('ID_USUARIO_PROVA_PERGUNTA').AsInteger;
      Self.FIDProvaPerguntaResposta := sdsConsulta.FieldByName('ID_PROVA_PERGUNTA_RESPOSTA').AsInteger;

      SetLength(FListaUsuarioProvasPerguntasRespostas, sdsConsulta.RecordCount);
      sdsConsulta.First;
      while not(sdsConsulta.Eof) do
      begin
        FListaUsuarioProvasPerguntasRespostas[sdsConsulta.RecNo - 1] :=
          TSisUsuarioProvasPerguntasRespostas.New
                                             .ID(sdsConsulta.FieldByName('ID').AsInteger)
                                             .IDUsuarioProvaPergunta(sdsConsulta.FieldByName('ID_USUARIO_PROVA_PERGUNTA').AsInteger)
                                             .IDProvaPerguntaResposta(sdsConsulta.FieldByName('ID_PROVA_PERGUNTA_RESPOSTA').AsInteger);
        sdsConsulta.Next;
      end;
    end
    else ClearFields;
  finally
    FreeAndNil(sdsConsulta);
  end;
end;

function TSisUsuarioProvasPerguntasRespostas.Insert: ISisUsuarioProvasPerguntasRespostas;
var
  sdsInsert: TFDQuery;
  Values: string;
begin
  Result := Self;
  sdsInsert := TFDQuery.Create(nil);
  try
    sdsInsert.Connection := Connection;

    // Chaves Primárias - Campos Obrigatórios
    Values := ':ID_USUARIO_PROVA_PERGUNTA';
    Values := Values + ', :ID_PROVA_PERGUNTA_RESPOSTA';

    FSQLInsert.Append('(' + StringReplace(Values, ':', '',
      [rfReplaceAll, rfIgnoreCase]) + ')').Append(' VALUES ')
      .Append('(' + Values + ') returning ID');

    sdsInsert.SQL.Add(FSQLInsert.ToString);

    // Chaves Primárias - Campos Obrigatórios
    sdsInsert.ParamByName('ID_USUARIO_PROVA_PERGUNTA').AsInteger := Self.FIDUsuarioProvaPergunta;
    sdsInsert.ParamByName('ID_PROVA_PERGUNTA_RESPOSTA').AsInteger := Self.FIDProvaPerguntaResposta;

    sdsInsert.Open;
    Self.FID := sdsInsert.FieldByName('ID').AsInteger;
  finally
    FreeAndNil(sdsInsert);
  end;
end;

function TSisUsuarioProvasPerguntasRespostas.InsertIf(const Value: Boolean): ISisUsuarioProvasPerguntasRespostas;
begin
  if Value then
    Result := Insert
  else Result := Self;
end;

function TSisUsuarioProvasPerguntasRespostas.ListaUsuarioProvasPerguntasRespostas(
  const Value: TArray<ISisUsuarioProvasPerguntasRespostas>): ISisUsuarioProvasPerguntasRespostas;
begin
  Result := Self;
  FListaUsuarioProvasPerguntasRespostas := Value;
end;

function TSisUsuarioProvasPerguntasRespostas.ListaUsuarioProvasPerguntasRespostas: TArray<ISisUsuarioProvasPerguntasRespostas>;
begin
  Result := FListaUsuarioProvasPerguntasRespostas;
end;

end.


