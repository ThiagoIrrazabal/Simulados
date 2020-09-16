unit uSisUsuarioProvasPerguntasBookMarks;

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
  /// Table: SIS_USUARIO_PROVAS_PERGUNTAS_BOOKMARKS.
  /// </summary>
  ISisUsuarioProvasPerguntasBookMarks = interface(IInterface)
    ['{52BFF6A7-25DF-45D0-A75C-37076DAC731E}']

    /// <summary>
    /// Field: ID_USUARIO_PROVA_PERGUNTA.
    /// </summary>
    function IDUsuarioProvaPergunta(const Value: Integer): ISisUsuarioProvasPerguntasBookMarks; overload;
    function IDUsuarioProvaPergunta: Integer; overload;
    function ConsultaIDUsuarioProvaPergunta(const Value: Integer): ISisUsuarioProvasPerguntasBookMarks;

    /// <summary>
    /// Field: BOOK_MARK.
    /// </summary>
    function BookMark(const Value: Integer): ISisUsuarioProvasPerguntasBookMarks; overload;
    function BookMark: Integer; overload;

    /// <summary>
    /// Field: ID.
    /// </summary>
    function ID(const Value: Integer): ISisUsuarioProvasPerguntasBookMarks; overload;
    function ID: Integer; overload;
    function ConsultaID(const Value: Integer): ISisUsuarioProvasPerguntasBookMarks;

    function Find: ISisUsuarioProvasPerguntasBookMarks;
    function Insert: ISisUsuarioProvasPerguntasBookMarks;
    function InsertIf(const Value: Boolean): ISisUsuarioProvasPerguntasBookMarks;
  end;

  TSisUsuarioProvasPerguntasBookMarks = class(TConexao, ISisUsuarioProvasPerguntasBookMarks)
  strict private
    FID: Integer;
    FIDUsuarioProvaPergunta: Integer;
    FBookMark: Integer;
    FSQLConsulta: TStringBuilder;
    FSQLInsert: TStringBuilder;
    procedure ClearFields;
  public
    constructor Create; overload;
    destructor Destroy; override;
    class function New: ISisUsuarioProvasPerguntasBookMarks;
    function ID(const Value: Integer): ISisUsuarioProvasPerguntasBookMarks; overload;
    function ID: Integer; overload;
    function ConsultaID(const Value: Integer): ISisUsuarioProvasPerguntasBookMarks;
    function IDUsuarioProvaPergunta(const Value: Integer): ISisUsuarioProvasPerguntasBookMarks; overload;
    function IDUsuarioProvaPergunta: Integer; overload;
    function ConsultaIDUsuarioProvaPergunta(const Value: Integer): ISisUsuarioProvasPerguntasBookMarks;
    function BookMark(const Value: Integer): ISisUsuarioProvasPerguntasBookMarks; overload;
    function BookMark: Integer; overload;
    function Find: ISisUsuarioProvasPerguntasBookMarks;
    function Insert: ISisUsuarioProvasPerguntasBookMarks;
    function InsertIf(const Value: Boolean): ISisUsuarioProvasPerguntasBookMarks;
  end;

implementation

{ TSisUsuarioProvasPerguntasBookMarks }

constructor TSisUsuarioProvasPerguntasBookMarks.Create;
begin
  inherited Create(True);
  FSQLConsulta := TStringBuilder.Create;
  FSQLConsulta.Append('select * from SIS_USUARIO_PROVAS_PERGUNTAS_BOOKMARKS where 0=0 ');

  FSQLInsert := TStringBuilder.Create;
  FSQLInsert.Append('insert into SIS_USUARIO_PROVAS_PERGUNTAS_BOOKMARKS ');

  ClearFields;
end;

destructor TSisUsuarioProvasPerguntasBookMarks.Destroy;
begin
  if Assigned(FSQLConsulta) then
    FreeAndNil(FSQLConsulta);

  if Assigned(FSQLInsert) then
    FreeAndNil(FSQLInsert);

  inherited;
end;

class function TSisUsuarioProvasPerguntasBookMarks.New: ISisUsuarioProvasPerguntasBookMarks;
begin
  Result := Self.Create;
end;

procedure TSisUsuarioProvasPerguntasBookMarks.ClearFields;
begin
  Self.FID := -1;
  Self.FIDUsuarioProvaPergunta := -1;
  Self.FBookMark := -1;
end;

function TSisUsuarioProvasPerguntasBookMarks.BookMark(
  const Value: Integer): ISisUsuarioProvasPerguntasBookMarks;
begin
  Result := Self;
  FBookMark := Value;
end;

function TSisUsuarioProvasPerguntasBookMarks.BookMark: Integer;
begin
  Result := FBookMark;
end;

function TSisUsuarioProvasPerguntasBookMarks.IDUsuarioProvaPergunta(
  const Value: Integer): ISisUsuarioProvasPerguntasBookMarks;
begin
  Result := Self;
  FIDUsuarioProvaPergunta := Value;
end;

function TSisUsuarioProvasPerguntasBookMarks.IDUsuarioProvaPergunta: Integer;
begin
  Result := FIDUsuarioProvaPergunta;
end;

function TSisUsuarioProvasPerguntasBookMarks.ConsultaIDUsuarioProvaPergunta(
  const Value: Integer): ISisUsuarioProvasPerguntasBookMarks;
begin
  Result := Self;
  FSQLConsulta.Append(' AND ID_USUARIO_PROVA_PERGUNTA = ' + Value.ToString);
end;

function TSisUsuarioProvasPerguntasBookMarks.ID(const Value: Integer): ISisUsuarioProvasPerguntasBookMarks;
begin
  Result := Self;
  FID := Value;
end;

function TSisUsuarioProvasPerguntasBookMarks.ID: Integer;
begin
  Result := FID;
end;

function TSisUsuarioProvasPerguntasBookMarks.ConsultaID(const Value: Integer): ISisUsuarioProvasPerguntasBookMarks;
begin
  Result := Self;
  FSQLConsulta.Append(' AND ID = ' + Value.ToString);
end;

function TSisUsuarioProvasPerguntasBookMarks.Find: ISisUsuarioProvasPerguntasBookMarks;
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
      Self.FBookMark := sdsConsulta.FieldByName('BOOK_MARK').AsInteger;
    end
    else ClearFields;
  finally
    FreeAndNil(sdsConsulta);
  end;
end;

function TSisUsuarioProvasPerguntasBookMarks.Insert: ISisUsuarioProvasPerguntasBookMarks;
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
    Values := Values + ', :BOOK_MARK';

    FSQLInsert.Append('(' + StringReplace(Values, ':', '',
      [rfReplaceAll, rfIgnoreCase]) + ')').Append(' VALUES ')
      .Append('(' + Values + ') returning ID');

    sdsInsert.SQL.Add(FSQLInsert.ToString);

    // Chaves Primárias - Campos Obrigatórios
    sdsInsert.ParamByName('ID_USUARIO_PROVA_PERGUNTA').AsInteger := Self.FIDUsuarioProvaPergunta;
    sdsInsert.ParamByName('BOOK_MARK').AsInteger := Self.FBookMark;

    sdsInsert.Open;
    Self.FID := sdsInsert.FieldByName('ID').AsInteger;
  finally
    FreeAndNil(sdsInsert);
  end;
end;

function TSisUsuarioProvasPerguntasBookMarks.InsertIf(const Value: Boolean): ISisUsuarioProvasPerguntasBookMarks;
begin
  if Value then
    Result := Insert
  else Result := Self;
end;

end.

