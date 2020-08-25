unit uSisUsuarioProvasPerguntas;

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
  /// Table: SIS_USUARIO_PROVAS_PERGUNTAS.
  /// </summary>
  ISisUsuarioProvasPerguntas = interface(IInterface)
    ['{52BFF6A7-25DF-45D0-A75C-37076DAC731E}']

    /// <summary>
    /// Field: ID_USUARIO_PROVA.
    /// </summary>
    function IDUsuarioProva(const Value: Integer): ISisUsuarioProvasPerguntas; overload;
    function IDUsuarioProva: Integer; overload;
    function ConsultaIDUsuarioProva(const Value: Integer): ISisUsuarioProvasPerguntas;

    /// <summary>
    /// Field: ID_PROVA_PERGUNTA.
    /// </summary>
    function IDProvaPergunta(const Value: Integer): ISisUsuarioProvasPerguntas; overload;
    function IDProvaPergunta: Integer; overload;
    function ConsultaIDProvaPergunta(const Value: Integer): ISisUsuarioProvasPerguntas;

    /// <summary>
    /// Field: ORDEM.
    /// </summary>
    function Ordem(const Value: Integer): ISisUsuarioProvasPerguntas; overload;
    function Ordem: Integer; overload;

    /// <summary>
    /// Field: LISTA_SIS_PROVAS_PERGUNTAS.
    /// </summary>
    function ListaUsuarioProvasPerguntas(const Value: TArray<ISisUsuarioProvasPerguntas>): ISisUsuarioProvasPerguntas; overload;
    function ListaUsuarioProvasPerguntas: TArray<ISisUsuarioProvasPerguntas>; overload;

    /// <summary>
    /// Field: ID.
    /// </summary>
    function ID(const Value: Integer): ISisUsuarioProvasPerguntas; overload;
    function ID: Integer; overload;
    function ConsultaID(const Value: Integer): ISisUsuarioProvasPerguntas;

    /// <summary>
    /// Field: ACERTOU.
    /// </summary>
    function Acertou(const Value: Boolean): ISisUsuarioProvasPerguntas; overload;
    function Acertou: Boolean; overload;

    function Find: ISisUsuarioProvasPerguntas;
    function Insert: ISisUsuarioProvasPerguntas;
    function Update: ISisUsuarioProvasPerguntas;
    function InsertIf(const Value: Boolean): ISisUsuarioProvasPerguntas;
  end;

  TSisUsuarioProvasPerguntas = class(TConexao, ISisUsuarioProvasPerguntas)
  strict private
    FID: Integer;
    FIDUsuarioProva: Integer;
    FIDProvaPergunta: Integer;
    FOrdem: Integer;
    FListaUsuarioProvasPerguntas: TArray<ISisUsuarioProvasPerguntas>;
    FSQLConsulta: TStringBuilder;
    FSQLInsert: TStringBuilder;
    FSQLUpdate: TStringBuilder;
    FAcertou: Boolean;
    procedure ClearFields;
  public
    constructor Create; overload;
    destructor Destroy; override;
    class function New: ISisUsuarioProvasPerguntas;
    function ID(const Value: Integer): ISisUsuarioProvasPerguntas; overload;
    function ID: Integer; overload;
    function ConsultaID(const Value: Integer): ISisUsuarioProvasPerguntas;
    function IDUsuarioProva(const Value: Integer): ISisUsuarioProvasPerguntas; overload;
    function IDUsuarioProva: Integer; overload;
    function ConsultaIDUsuarioProva(const Value: Integer): ISisUsuarioProvasPerguntas;
    function IDProvaPergunta(const Value: Integer): ISisUsuarioProvasPerguntas; overload;
    function IDProvaPergunta: Integer; overload;
    function ConsultaIDProvaPergunta(const Value: Integer): ISisUsuarioProvasPerguntas;
    function Ordem(const Value: Integer): ISisUsuarioProvasPerguntas; overload;
    function Ordem: Integer; overload;
    function Acertou(const Value: Boolean): ISisUsuarioProvasPerguntas; overload;
    function Acertou: Boolean; overload;
    function ListaUsuarioProvasPerguntas(const Value: TArray<ISisUsuarioProvasPerguntas>): ISisUsuarioProvasPerguntas; overload;
    function ListaUsuarioProvasPerguntas: TArray<ISisUsuarioProvasPerguntas>; overload;
    function Find: ISisUsuarioProvasPerguntas;
    function Insert: ISisUsuarioProvasPerguntas;
    function Update: ISisUsuarioProvasPerguntas;
    function InsertIf(const Value: Boolean): ISisUsuarioProvasPerguntas;
  end;

implementation

{ TSisUsuarioProvasPerguntas }

constructor TSisUsuarioProvasPerguntas.Create;
begin
  inherited Create;
  FSQLConsulta := TStringBuilder.Create;
  FSQLConsulta.Append('select ID, ID_USUARIO_PROVA, ID_PROVA_PERGUNTA, ORDEM, ACERTOU, COUNT(*) over() from SIS_USUARIO_PROVAS_PERGUNTAS where 0=0 ');

  FSQLInsert := TStringBuilder.Create;
  FSQLInsert.Append('insert into SIS_USUARIO_PROVAS_PERGUNTAS ');

  FSQLUpdate := TStringBuilder.Create;
  FSQLUpdate.Append('update SIS_USUARIO_PROVAS_PERGUNTAS set ');

  ClearFields;
end;

destructor TSisUsuarioProvasPerguntas.Destroy;
begin
  if Assigned(FSQLConsulta) then
    FreeAndNil(FSQLConsulta);

  if Assigned(FSQLInsert) then
    FreeAndNil(FSQLInsert);

  if Assigned(FSQLUpdate) then
    FreeAndNil(FSQLUpdate);

  inherited;
end;

class function TSisUsuarioProvasPerguntas.New: ISisUsuarioProvasPerguntas;
begin
  Result := Self.Create;
end;

function TSisUsuarioProvasPerguntas.Ordem: Integer;
begin
  Result := FOrdem;
end;

function TSisUsuarioProvasPerguntas.Update: ISisUsuarioProvasPerguntas;
var
  sdsUpdate: TFDQuery;
  Values: string;
begin
  Result := Self;
  sdsUpdate := TFDQuery.Create(nil);
  try
    sdsUpdate.Connection := Connection;

    Values := Values + 'ACERTOU = :ACERTOU';

    FSQLUpdate.Append(Values)
              .Append(' where ')
              .Append('   id = :id');

    sdsUpdate.SQL.Add(FSQLUpdate.ToString);
    sdsUpdate.ParamByName('ACERTOU').AsBoolean := Self.FAcertou;
    sdsUpdate.ParamByName('ID').AsInteger := Self.FID;
    sdsUpdate.ExecSQL;
  finally
    FreeAndNil(sdsUpdate);
  end;
end;

function TSisUsuarioProvasPerguntas.Ordem(
  const Value: Integer): ISisUsuarioProvasPerguntas;
begin
  Result := Self;
  FOrdem := Value;
end;

function TSisUsuarioProvasPerguntas.Acertou: Boolean;
begin
  Result := FAcertou;
end;

function TSisUsuarioProvasPerguntas.Acertou(
  const Value: Boolean): ISisUsuarioProvasPerguntas;
begin
  Result := Self;
  FAcertou := Value;
end;

procedure TSisUsuarioProvasPerguntas.ClearFields;
begin
  Self.FID := -1;
  Self.FIDUsuarioProva := -1;
  Self.FIDProvaPergunta := -1;
end;

function TSisUsuarioProvasPerguntas.IDProvaPergunta(
  const Value: Integer): ISisUsuarioProvasPerguntas;
begin
  Result := Self;
  FIDProvaPergunta := Value;
end;

function TSisUsuarioProvasPerguntas.IDProvaPergunta: Integer;
begin
  Result := FIDProvaPergunta;
end;

function TSisUsuarioProvasPerguntas.ConsultaIDProvaPergunta(
  const Value: Integer): ISisUsuarioProvasPerguntas;
begin
  Result := Self;
  FSQLConsulta.Append(' AND ID_PROVA_PERGUNTA = ' + Value.ToString);
end;

function TSisUsuarioProvasPerguntas.IDUsuarioProva(
  const Value: Integer): ISisUsuarioProvasPerguntas;
begin
  Result := Self;
  FIDUsuarioProva := Value;
end;

function TSisUsuarioProvasPerguntas.IDUsuarioProva: Integer;
begin
  Result := FIDUsuarioProva;
end;

function TSisUsuarioProvasPerguntas.ConsultaIDUsuarioProva(
  const Value: Integer): ISisUsuarioProvasPerguntas;
begin
  Result := Self;
  if (Value > 0) then
    FSQLConsulta.Append(' AND ID_USUARIO_PROVA = ' + Value.ToString);
end;

function TSisUsuarioProvasPerguntas.ID(const Value: Integer): ISisUsuarioProvasPerguntas;
begin
  Result := Self;
  FID := Value;
end;

function TSisUsuarioProvasPerguntas.ID: Integer;
begin
  Result := FID;
end;

function TSisUsuarioProvasPerguntas.ConsultaID(const Value: Integer): ISisUsuarioProvasPerguntas;
begin
  Result := Self;
  FSQLConsulta.Append(' AND ID = ' + Value.ToString);
end;

function TSisUsuarioProvasPerguntas.Find: ISisUsuarioProvasPerguntas;
var
  sdsConsulta: TFDQuery;
begin
  Result := Self;
  sdsConsulta := TFDQuery.Create(nil);
  try
    sdsConsulta.Connection := Connection;
    sdsConsulta.SQL.Add(FSQLConsulta.ToString + ' order by ID desc');
    sdsConsulta.Open;
    if not(sdsConsulta.IsEmpty) then
    begin
      Self.FID := sdsConsulta.FieldByName('ID').AsInteger;
      Self.FIDUsuarioProva := sdsConsulta.FieldByName('ID_USUARIO_PROVA').AsInteger;
      Self.FIDProvaPergunta := sdsConsulta.FieldByName('ID_PROVA_PERGUNTA').AsInteger;
      Self.FOrdem := sdsConsulta.FieldByName('ORDEM').AsInteger;
      Self.FAcertou := sdsConsulta.FieldByName('ACERTOU').AsBoolean;

      SetLength(FListaUsuarioProvasPerguntas, sdsConsulta.FieldByName('COUNT').AsInteger);
      sdsConsulta.First;
      while not(sdsConsulta.Eof) do
      begin
        FListaUsuarioProvasPerguntas[sdsConsulta.RecNo - 1] :=
          TSisUsuarioProvasPerguntas.New
                                    .ID(sdsConsulta.FieldByName('ID').AsInteger)
                                    .IDUsuarioProva(sdsConsulta.FieldByName('ID_USUARIO_PROVA').AsInteger)
                                    .IDProvaPergunta(sdsConsulta.FieldByName('ID_PROVA_PERGUNTA').AsInteger)
                                    .Ordem(sdsConsulta.FieldByName('ORDEM').AsInteger)
                                    .Acertou(sdsConsulta.FieldByName('ACERTOU').AsBoolean);
        sdsConsulta.Next;
      end;
    end
    else ClearFields;
  finally
    FreeAndNil(sdsConsulta);
  end;
end;

function TSisUsuarioProvasPerguntas.Insert: ISisUsuarioProvasPerguntas;
var
  sdsInsert: TFDQuery;
  Values: string;
begin
  Result := Self;
  sdsInsert := TFDQuery.Create(nil);
  try
    sdsInsert.Connection := Connection;

    // Chaves Primárias - Campos Obrigatórios
    Values := ':ID_USUARIO_PROVA';
    Values := Values + ', :ID_PROVA_PERGUNTA';
    Values := Values + ', :ORDEM';

    FSQLInsert.Append('(' + StringReplace(Values, ':', '',
      [rfReplaceAll, rfIgnoreCase]) + ')').Append(' VALUES ')
      .Append('(' + Values + ') returning ID');

    sdsInsert.SQL.Add(FSQLInsert.ToString);

    // Chaves Primárias - Campos Obrigatórios
    sdsInsert.ParamByName('ID_USUARIO_PROVA').AsInteger := Self.FIDUsuarioProva;
    sdsInsert.ParamByName('ID_PROVA_PERGUNTA').AsInteger := Self.FIDProvaPergunta;
    sdsInsert.ParamByName('ORDEM').AsInteger := Self.FOrdem;

    sdsInsert.Open;
    Self.FID := sdsInsert.FieldByName('ID').AsInteger;
  finally
    FreeAndNil(sdsInsert);
  end;
end;

function TSisUsuarioProvasPerguntas.InsertIf(const Value: Boolean): ISisUsuarioProvasPerguntas;
begin
  if Value then
    Result := Insert
  else Result := Self;
end;

function TSisUsuarioProvasPerguntas.ListaUsuarioProvasPerguntas: TArray<ISisUsuarioProvasPerguntas>;
begin
  Result := FListaUsuarioProvasPerguntas;
end;

function TSisUsuarioProvasPerguntas.ListaUsuarioProvasPerguntas(
  const Value: TArray<ISisUsuarioProvasPerguntas>): ISisUsuarioProvasPerguntas;
begin
  Result := Self;
  FListaUsuarioProvasPerguntas := Value;
end;

end.
