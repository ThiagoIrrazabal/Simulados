unit uSisProvasPerguntas;
 
interface 
 
uses 
  Data.SqlExpr, 
  System.StrUtils, 
  System.SysUtils,
  uSisProvasPerguntasRespostas,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  uConexao;
 
type 
  /// <summary> 
  /// Table: SIS_PROVAS_PERGUNTAS. 
  /// </summary> 
  ISisProvasPerguntas = interface(IInterface) 
    ['{6AB096CC-8DB5-4E99-B93C-5851FBFE7D4B}'] 
 
    /// <summary> 
    /// Field: PERGUNTA. 
    /// </summary> 
    function Pergunta(const Value: string): ISisProvasPerguntas; overload; 
    function Pergunta: string; overload; 
    function ConsultaPergunta(const Value: string): ISisProvasPerguntas; 
 
    /// <summary> 
    /// Field: ID_PROVA. 
    /// </summary> 
    function IDProva(const Value: Integer): ISisProvasPerguntas; overload;
    function IDProva: Integer; overload; 
    function ConsultaIDProva(const Value: Integer): ISisProvasPerguntas; 
 
    /// <summary>
    /// Field: ID.
    /// </summary>
    function ID(const Value: Integer): ISisProvasPerguntas; overload; 
    function ID: Integer; overload;
    function ConsultaID(const Value: Integer): ISisProvasPerguntas;

    /// <summary>
    /// Field: ID_CATEGORIA.
    /// </summary>
    function IDCategoria(const Value: Integer): ISisProvasPerguntas; overload;
    function IDCategoria: Integer; overload;
    function ConsultaIDCategoria(const Value: Integer): ISisProvasPerguntas;

    /// <summary>
    /// Field: LISTA_SIS_PROVAS_PERGUNTAS_RESPOSTAS.
    /// </summary>
    function ListaISisProvasPerguntas(const Value: TArray<ISisProvasPerguntas>): ISisProvasPerguntas; overload;
    function ListaISisProvasPerguntas: TArray<ISisProvasPerguntas>; overload;

    /// <summary>
    /// Field: SIS_PROVAS_PERGUNTAS_RESPOSTAS.
    /// </summary>
    function ListaSisProvasPerguntasRespostas(const Value: TArray<ISisProvasPerguntasRespostas>): ISisProvasPerguntas; overload;
    function ListaSisProvasPerguntasRespostas: TArray<ISisProvasPerguntasRespostas>; overload;
    function ConsultaListaSisProvasPerguntasRespostas(const Value: Integer): ISisProvasPerguntas;

    function ConsultaOrdem(const Value: Integer): ISisProvasPerguntas;
    function Find: ISisProvasPerguntas;
    function Insert: ISisProvasPerguntas;
    function InsertIf(const Value: Boolean): ISisProvasPerguntas;
    function DestroyComponents: ISisProvasPerguntas;
    function CloseConnection: ISisProvasPerguntas;
  end; 

  TSisProvasPerguntas = class(TConexao, ISisProvasPerguntas)
  strict private
    FPergunta: string;
    FIDProva: Integer;
    FID: Integer;
    FIDCategoria: Integer;
    FOrdem: Integer;
    FListaSisProvasPerguntasRespostas: TArray<ISisProvasPerguntasRespostas>;
    FListaISisProvasPerguntas: TArray<ISisProvasPerguntas>;
    FSQLConsulta: TStringBuilder;
    FSQLInsert: TStringBuilder;
    procedure ClearFields;
  public
    constructor Create; overload;
    destructor Destroy; override;
    class function New: ISisProvasPerguntas;
    function Pergunta(const Value: string): ISisProvasPerguntas; overload;
    function Pergunta: string; overload;
    function ConsultaPergunta(const Value: string): ISisProvasPerguntas;
    function IDProva(const Value: Integer): ISisProvasPerguntas; overload;
    function IDProva: Integer; overload;
    function ConsultaIDProva(const Value: Integer): ISisProvasPerguntas;
    function ID(const Value: Integer): ISisProvasPerguntas; overload;
    function ID: Integer; overload;
    function IDCategoria(const Value: Integer): ISisProvasPerguntas; overload;
    function IDCategoria: Integer; overload;
    function ConsultaIDCategoria(const Value: Integer): ISisProvasPerguntas;
    function ConsultaID(const Value: Integer): ISisProvasPerguntas;
    function ListaISisProvasPerguntas(const Value: TArray<ISisProvasPerguntas>): ISisProvasPerguntas; overload;
    function ListaISisProvasPerguntas: TArray<ISisProvasPerguntas>; overload;
    function ListaSisProvasPerguntasRespostas(const Value: TArray<ISisProvasPerguntasRespostas>): ISisProvasPerguntas; overload;
    function ListaSisProvasPerguntasRespostas: TArray<ISisProvasPerguntasRespostas>; overload;
    function ConsultaListaSisProvasPerguntasRespostas(const Value: Integer): ISisProvasPerguntas;
    function ConsultaOrdem(const Value: Integer): ISisProvasPerguntas;
    function Find: ISisProvasPerguntas;
    function Insert: ISisProvasPerguntas;
    function InsertIf(const Value: Boolean): ISisProvasPerguntas;
    function DestroyComponents: ISisProvasPerguntas;
    function CloseConnection: ISisProvasPerguntas;
  end;
 
implementation 
 
{ TSisProvasPerguntas }
 
constructor TSisProvasPerguntas.Create;
begin 
  inherited Create(True);
  FSQLConsulta := TStringBuilder.Create; 
  FSQLConsulta.Append('select ID, ID_PROVA, ID_CATEGORIA, PERGUNTA, COUNT(*) over() from SIS_PROVAS_PERGUNTAS where 0=0 ');
 
  FSQLInsert := TStringBuilder.Create; 
  FSQLInsert.Append('insert into SIS_PROVAS_PERGUNTAS '); 
 
  ClearFields;
  FOrdem := 0;
end; 
 
destructor TSisProvasPerguntas.Destroy; 
begin 
  Self.DestroyComponents;
  inherited; 
end; 
 
function TSisProvasPerguntas.DestroyComponents: ISisProvasPerguntas;
begin
  Result := Self;
  if Assigned(FSQLConsulta) then
    FreeAndNil(FSQLConsulta);

  if Assigned(FSQLInsert) then
    FreeAndNil(FSQLInsert);
end;

class function TSisProvasPerguntas.New: ISisProvasPerguntas;
begin 
  Result := Self.Create;
end; 
 
procedure TSisProvasPerguntas.ClearFields;
begin 
  Self.FPergunta := ''; 
  Self.FIDProva := -1; 
  Self.FID := -1; 
end; 
 
function TSisProvasPerguntas.Pergunta(const Value: string): ISisProvasPerguntas; 
begin 
  Result := Self; 
  FPergunta := Value; 
end; 
 
function TSisProvasPerguntas.Pergunta: string; 
begin 
  Result := FPergunta; 
end; 

function TSisProvasPerguntas.ListaSisProvasPerguntasRespostas(
  const Value: TArray<ISisProvasPerguntasRespostas>): ISisProvasPerguntas;
begin
  Result := Self;
  FListaSisProvasPerguntasRespostas := Value;
end;

function TSisProvasPerguntas.ListaSisProvasPerguntasRespostas: TArray<ISisProvasPerguntasRespostas>;
begin
  Result := FListaSisProvasPerguntasRespostas;
end;

function TSisProvasPerguntas.ConsultaPergunta(const Value: string): ISisProvasPerguntas;
begin 
  Result := Self; 
  FSQLConsulta.Append(' AND PERGUNTA = ' + Value.QuotedString);
end; 
 
function TSisProvasPerguntas.ConsultaListaSisProvasPerguntasRespostas(const Value: Integer): ISisProvasPerguntas;
begin
  Result := Self;
  ListaSisProvasPerguntasRespostas(TSisProvasPerguntasRespostas.New
                                                               .ConsultaIDPergunta(Value)
                                                               .Find
                                                               .CloseConnection
                                                               .ListaSisProvasPerguntasRespostas);
end;

function TSisProvasPerguntas.ConsultaOrdem(
  const Value: Integer): ISisProvasPerguntas;
begin
  Result := Self;
  FOrdem := Value;
end;

function TSisProvasPerguntas.IDProva(const Value: Integer): ISisProvasPerguntas;
begin
  Result := Self;
  FIDProva := Value;
end;

function TSisProvasPerguntas.IDProva: Integer;
begin
  Result := FIDProva;
end;

function TSisProvasPerguntas.ConsultaIDProva(const Value: Integer): ISisProvasPerguntas;
begin
  Result := Self;
  FSQLConsulta.Append(' AND ID_PROVA = ' + Value.ToString);
end; 
 
function TSisProvasPerguntas.ID(const Value: Integer): ISisProvasPerguntas; 
begin 
  Result := Self; 
  FID := Value; 
end; 
 
function TSisProvasPerguntas.ID: Integer; 
begin 
  Result := FID; 
end; 
 
function TSisProvasPerguntas.IDCategoria: Integer;
begin
  Result := FIDCategoria;
end;

function TSisProvasPerguntas.IDCategoria(
  const Value: Integer): ISisProvasPerguntas;
begin
  Result := Self;
  FIDCategoria := Value;
end;

function TSisProvasPerguntas.CloseConnection: ISisProvasPerguntas;
begin
  Result := Self;
  if Assigned(Connection) then
    Connection.Close;
end;

function TSisProvasPerguntas.ConsultaID(const Value: Integer): ISisProvasPerguntas;
begin 
  Result := Self;
  FSQLConsulta.Append(' AND ID = ' + Value.ToString); 
end; 
 
function TSisProvasPerguntas.ConsultaIDCategoria(
  const Value: Integer): ISisProvasPerguntas;
begin
  Result := Self;
  FSQLConsulta.Append(' AND ID_CATEGORIA = ' + Value.ToString);
end;

function TSisProvasPerguntas.Find: ISisProvasPerguntas;
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
      Self.FPergunta := sdsConsulta.FieldByName('PERGUNTA').AsString;
      Self.FIDProva := sdsConsulta.FieldByName('ID_PROVA').AsInteger;
      Self.FID := sdsConsulta.FieldByName('ID').AsInteger;
      Self.FIDCategoria := sdsConsulta.FieldByName('ID_CATEGORIA').AsInteger;

      SetLength(FListaISisProvasPerguntas, sdsConsulta.FieldByName('COUNT').AsInteger);
      sdsConsulta.First;
      while not(sdsConsulta.Eof) do
      begin
        if (FOrdem > 0) then
        begin
          if (sdsConsulta.RecNo = FOrdem) then
          begin
            Self.FPergunta := sdsConsulta.FieldByName('PERGUNTA').AsString;
            Self.FIDProva := sdsConsulta.FieldByName('ID_PROVA').AsInteger;
            Self.FID := sdsConsulta.FieldByName('ID').AsInteger;
            Self.FIDCategoria := sdsConsulta.FieldByName('ID_CATEGORIA').AsInteger;
            ConsultaListaSisProvasPerguntasRespostas(sdsConsulta.FieldByName('ID').AsInteger);
            Break;
          end;
        end
        else
        begin
          FListaISisProvasPerguntas[sdsConsulta.RecNo - 1] :=
            TSisProvasPerguntas.New
                               .Pergunta(sdsConsulta.FieldByName('PERGUNTA').AsString)
                               .IDProva(sdsConsulta.FieldByName('ID_PROVA').AsInteger)
                               .ID(sdsConsulta.FieldByName('ID').AsInteger)
                               .ConsultaListaSisProvasPerguntasRespostas(sdsConsulta.FieldByName('ID').AsInteger);
        end;
        sdsConsulta.Next;
      end;
    end
    else ClearFields; 
  finally 
    FreeAndNil(sdsConsulta);
  end; 
end; 
 
function TSisProvasPerguntas.Insert: ISisProvasPerguntas; 
var 
  sdsInsert: TFDQuery;
  Values: string; 
begin 
  Result := Self; 
  sdsInsert := TFDQuery.Create(nil);
  try 
    sdsInsert.Connection := Connection;

    Values := Values + ':PERGUNTA';

    Values := Values + ', :ID_PROVA';

    FSQLInsert.Append('(' + StringReplace(Values, ':', '',
      [rfReplaceAll, rfIgnoreCase]) + ')').Append(' VALUES ')
      .Append('(' + Values + ') returning ID');

    sdsInsert.SQL.Add(FSQLInsert.ToString);

    sdsInsert.ParamByName('PERGUNTA').AsString := Self.FPergunta;

    sdsInsert.ParamByName('ID_PROVA').AsInteger := Self.FIDProva;
 
    sdsInsert.Open;
    Self.FID := sdsInsert.FieldByName('ID').AsInteger;
  finally 
    FreeAndNil(sdsInsert); 
  end; 
end; 
 
function TSisProvasPerguntas.InsertIf(const Value: Boolean): ISisProvasPerguntas; 
begin 
  if Value then 
    Result := Insert 
  else Result := Self; 
end; 

function TSisProvasPerguntas.ListaISisProvasPerguntas: TArray<ISisProvasPerguntas>;
begin
  Result := FListaISisProvasPerguntas;
end;

function TSisProvasPerguntas.ListaISisProvasPerguntas(
  const Value: TArray<ISisProvasPerguntas>): ISisProvasPerguntas;
begin
  Result := Self;
  FListaISisProvasPerguntas := Value;
end;

end.