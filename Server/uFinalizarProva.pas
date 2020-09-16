unit uFinalizarProva;

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
  /// Table: FINALIZAR_PROVA.
  /// </summary>
  IFinalizaProva = interface(IInterface)
  ['{988C7FDA-9C1F-4195-B3BF-0792B3E816C8}']
    /// <summary>
    /// Field: ID_USUARIO_PROVA.
    /// </summary>
    function ConsultaIDUsuarioProva(const Value: Integer): IFinalizaProva;

    /// <summary>
    /// Field: ID_PROVA.
    /// </summary>
    function ConsultaIDProva(const Value: Integer): IFinalizaProva;

    /// <summary>
    /// Field: ACERTOU.
    /// </summary>
    function Acertou(const Value: Boolean): IFinalizaProva; overload;
    function Acertou: Boolean; overload;

    /// <summary>
    /// Field: ID_USUARIO_PROVA_PERGUNTA.
    /// </summary>
    function IDUsuarioProvaPergunta(const Value: Integer): IFinalizaProva; overload;
    function IDUsuarioProvaPergunta: Integer; overload;

    /// <summary>
    /// Field: LISTA_FINALIZA_PROVA.
    /// </summary>
    function Lista: TArray<IFinalizaProva>;

    function Find: IFinalizaProva;
    function DestroyComponents: IFinalizaProva;
    function CloseConnection: IFinalizaProva;
  end;

  TFinalizaProva = class(TConexao, IFinalizaProva)
  strict private
    FIDProva: Integer;
    FIDUsuarioProva: Integer;
    FAcertou: Boolean;
    FIDUsuarioProvaPergunta: Integer;
    FLista: TArray<IFinalizaProva>;
    FSQLConsulta: TStringBuilder;
    procedure ClearFields;
  public
    constructor Create; overload;
    destructor Destroy; override;
    class function New: IFinalizaProva;
    function ConsultaIDUsuarioProva(const Value: Integer): IFinalizaProva;
    function ConsultaIDProva(const Value: Integer): IFinalizaProva;
    function Acertou(const Value: Boolean): IFinalizaProva; overload;
    function Acertou: Boolean; overload;
    function IDUsuarioProvaPergunta(const Value: Integer): IFinalizaProva; overload;
    function IDUsuarioProvaPergunta: Integer; overload;
    function Lista: TArray<IFinalizaProva>;
    function Find: IFinalizaProva;
    function DestroyComponents: IFinalizaProva;
    function CloseConnection: IFinalizaProva;
  end;

implementation

{ TFinalizaProva }

constructor TFinalizaProva.Create;
begin
  inherited Create(False);
  FSQLConsulta := TStringBuilder.Create;
  FSQLConsulta.Append('with perguntas as(' + sLineBreak +
                      'select' + sLineBreak +
                        'spp.id,' + sLineBreak +
                        '(select supp.id' + sLineBreak +
                         'from sis_usuario_provas_perguntas supp' + sLineBreak +
                         'where supp.id_usuario_prova = %s and supp.id_prova_pergunta = spp.id) as id_usuario_prova_pergunta,' + sLineBreak +
                        '(select' + sLineBreak +
                          'array_agg(sppr.id) as respostas_certas' + sLineBreak +
                         'from sis_provas_perguntas_respostas sppr' + sLineBreak +
                         'where sppr.id_pergunta = spp.id' + sLineBreak +
                         'and sppr.certa),' + sLineBreak +
                        '(select' + sLineBreak +
                          'array_agg(suppr.id_prova_pergunta_resposta) as respondidas_certas' + sLineBreak +
                        'from sis_usuario_provas sup' + sLineBreak +
                        'inner join sis_usuario_provas_perguntas supp on' + sLineBreak +
                          '(supp.id_usuario_prova = sup.id and supp.id_prova_pergunta = spp.id)' + sLineBreak +
                        'inner join sis_usuario_provas_perguntas_respostas suppr on' + sLineBreak +
                          '(suppr.id_usuario_prova_pergunta = supp.id)' + sLineBreak +
                        'where' + sLineBreak +
                          '(sup.id_prova = sp.id and sup.id = %s))' + sLineBreak +
                      'from' + sLineBreak +
                        'sis_provas sp' + sLineBreak +
                        'inner join sis_provas_perguntas spp on' + sLineBreak +
                          '(spp.id_prova = sp.id)' + sLineBreak +
                      'where' + sLineBreak +
                        'sp.id = %s' + sLineBreak +
                      'order by spp.id)' + sLineBreak +
                      'select' + sLineBreak +
                        'id_usuario_prova_pergunta,' + sLineBreak +
                        'case' + sLineBreak +
                          'when respondidas_certas = respostas_certas then' + sLineBreak +
                            'true' + sLineBreak +
                          'else false' + sLineBreak +
                        'end as acertou,' + sLineBreak +
                        'count(*) over() as contador' + sLineBreak +
                      'from perguntas');
  ClearFields;
end;

destructor TFinalizaProva.Destroy;
begin
  Self.DestroyComponents;
  inherited;
end;

function TFinalizaProva.DestroyComponents: IFinalizaProva;
begin
  Result := Self;

  if Assigned(FSQLConsulta) then
    FreeAndNil(FSQLConsulta);
end;

class function TFinalizaProva.New: IFinalizaProva;
begin
  Result := Self.Create;
end;

function TFinalizaProva.Acertou: Boolean;
begin
  Result := FAcertou;
end;

function TFinalizaProva.Acertou(const Value: Boolean): IFinalizaProva;
begin
  Result := Self;
  FAcertou := Value;
end;

procedure TFinalizaProva.ClearFields;
begin
  Self.FIDUsuarioProva := -1;
  Self.FIDProva := -1;
  Self.FAcertou := False;
  Self.FIDUsuarioProvaPergunta := -1;
end;

function TFinalizaProva.CloseConnection: IFinalizaProva;
begin
  Result := Self;
  if Assigned(Connection) then
    Connection.Close;
end;

function TFinalizaProva.ConsultaIDUsuarioProva(const Value: Integer): IFinalizaProva;
begin
  Result := Self;
  Self.FIDUsuarioProva := Value;
end;

function TFinalizaProva.ConsultaIDProva(const Value: Integer): IFinalizaProva;
begin
  Result := Self;
  Self.FIDProva := Value;
end;

function TFinalizaProva.Find: IFinalizaProva;
var
  sdsConsulta: TFDQuery;
begin
  Result := Self;
  sdsConsulta := TFDQuery.Create(nil);
  try
    Connection.Connected := True;
    sdsConsulta.Connection := Connection;
    sdsConsulta.SQL.Add(Format(FSQLConsulta.ToString, [Self.FIDUsuarioProva.ToString, Self.FIDUsuarioProva.ToString, Self.FIDProva.ToString]));
    sdsConsulta.Open;
    SetLength(FLista, sdsConsulta.FieldByName('CONTADOR').AsInteger);
    if not(sdsConsulta.IsEmpty) then
    begin
      Self.FAcertou := sdsConsulta.FieldByName('ACERTOU').AsBoolean;
      Self.FIDUsuarioProvaPergunta := sdsConsulta.FieldByName('ID_USUARIO_PROVA_PERGUNTA').AsInteger;

      sdsConsulta.First;
      while not(sdsConsulta.Eof) do
      begin
        FLista[sdsConsulta.RecNo - 1] :=
          TFinalizaProva.New
                        .Acertou(sdsConsulta.FieldByName('ACERTOU').AsBoolean)
                        .IDUsuarioProvaPergunta(sdsConsulta.FieldByName('ID_USUARIO_PROVA_PERGUNTA').AsInteger);

        sdsConsulta.Next;
      end;
    end
    else ClearFields;
  finally
    FreeAndNil(sdsConsulta);
  end;
end;

function TFinalizaProva.IDUsuarioProvaPergunta(
  const Value: Integer): IFinalizaProva;
begin
  Result := Self;
  FIDUsuarioProvaPergunta := Value;
end;

function TFinalizaProva.IDUsuarioProvaPergunta: Integer;
begin
  Result := FIDUsuarioProvaPergunta;
end;

function TFinalizaProva.Lista: TArray<IFinalizaProva>;
begin
  Result := FLista;
end;

end.
