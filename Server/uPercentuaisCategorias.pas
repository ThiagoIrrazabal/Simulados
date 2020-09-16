unit uPercentuaisCategorias;

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
  /// Table: PERCENTUAIS_CATEGORIAS.
  /// </summary>
  IPercentuaisCategorias = interface(IInterface)
  ['{988C7FDA-9C1F-4195-B3BF-0792B3E816C8}']
    /// <summary>
    /// Field: ID_USUARIO_PROVA.
    /// </summary>
    function ConsultaIDUsuarioProva(const Value: Integer): IPercentuaisCategorias;

    /// <summary>
    /// Field: ID_PROVA.
    /// </summary>
    function ConsultaIDProva(const Value: Integer): IPercentuaisCategorias;

    /// <summary>
    /// Field: DESCRICAO.
    /// </summary>
    function Descricao(const Value: string): IPercentuaisCategorias; overload;
    function Descricao: string; overload;

    /// <summary>
    /// Field: PERCENTUAL.
    /// </summary>
    function Percentual(const Value: Integer): IPercentuaisCategorias; overload;
    function Percentual: Integer; overload;

    /// <summary>
    /// Field: LISTA_PERCENTUAIS_CATEGORIAS.
    /// </summary>
    function Lista: TArray<IPercentuaisCategorias>;

    function Find: IPercentuaisCategorias;
    function DestroyComponents: IPercentuaisCategorias;
    function CloseConnection: IPercentuaisCategorias;
  end;

  TPercentuaisCategorias = class(TConexao, IPercentuaisCategorias)
  strict private
    FIDProva: Integer;
    FIDUsuarioProva: Integer;
    FDescricao: string;
    FPercentual: Integer;
    FLista: TArray<IPercentuaisCategorias>;
    FSQLConsulta: TStringBuilder;
    procedure ClearFields;
  public
    constructor Create; overload;
    destructor Destroy; override;
    class function New: IPercentuaisCategorias;
    function ConsultaIDUsuarioProva(const Value: Integer): IPercentuaisCategorias;
    function ConsultaIDProva(const Value: Integer): IPercentuaisCategorias;
    function Descricao(const Value: string): IPercentuaisCategorias; overload;
    function Descricao: string; overload;
    function Percentual(const Value: Integer): IPercentuaisCategorias; overload;
    function Percentual: Integer; overload;
    function Lista: TArray<IPercentuaisCategorias>;
    function Find: IPercentuaisCategorias;
    function DestroyComponents: IPercentuaisCategorias;
    function CloseConnection: IPercentuaisCategorias;
  end;

implementation

{ TPercentuaisCategorias }

constructor TPercentuaisCategorias.Create;
begin
  inherited Create(False);
  FSQLConsulta := TStringBuilder.Create;
  FSQLConsulta.Append('with categorias as(' + sLineBreak +
                      'select' + sLineBreak +
                        'sc.id,' + sLineBreak +
                        'sc.descricao,' + sLineBreak +
                        'array_agg(spp.id) as id_perguntas,' + sLineBreak +
                        'count(spp.*) as quantidade' + sLineBreak +
                      'from sis_categorias sc' + sLineBreak +
                      'inner join sis_provas_perguntas spp on' + sLineBreak +
                        '(spp.id_categoria = sc.id)' + sLineBreak +
                      'where spp.id_prova = %s' + sLineBreak +
                      'group by sc.id, sc.descricao)' + sLineBreak +
                      'select' + sLineBreak +
                        'count(*) over() as contador,' + sLineBreak +
                        'descricao,' + sLineBreak +
                        '((select' + sLineBreak +
                          'count(supp.*)' + sLineBreak +
                         'from sis_usuario_provas_perguntas supp' + sLineBreak +
                         'where supp.id_usuario_prova = %s' + sLineBreak +
                         'and supp.id_prova_pergunta = any(cat.id_perguntas)' + sLineBreak +
                         'and supp.acertou) * 100 / quantidade) as percentual' + sLineBreak +
                      'from categorias cat');
  ClearFields;
end;

function TPercentuaisCategorias.Descricao(
  const Value: string): IPercentuaisCategorias;
begin
  Result := Self;
  FDescricao := Value;
end;

function TPercentuaisCategorias.Descricao: string;
begin
  Result := FDescricao;
end;

destructor TPercentuaisCategorias.Destroy;
begin
  Self.DestroyComponents;
  inherited;
end;

function TPercentuaisCategorias.DestroyComponents: IPercentuaisCategorias;
begin
  Result := Self;

  if Assigned(FSQLConsulta) then
    FreeAndNil(FSQLConsulta);
end;

class function TPercentuaisCategorias.New: IPercentuaisCategorias;
begin
  Result := Self.Create;
end;

function TPercentuaisCategorias.Percentual(
  const Value: Integer): IPercentuaisCategorias;
begin
  Result := Self;
  FPercentual := Value;
end;

function TPercentuaisCategorias.Percentual: Integer;
begin
  Result := FPercentual;
end;

procedure TPercentuaisCategorias.ClearFields;
begin
  Self.FIDUsuarioProva := -1;
  Self.FIDProva := -1;
  Self.FDescricao := EmptyStr;
  Self.FPercentual := -1;
end;

function TPercentuaisCategorias.CloseConnection: IPercentuaisCategorias;
begin
  Result := Self;
  if Assigned(Connection) then
    Connection.Close;
end;

function TPercentuaisCategorias.ConsultaIDUsuarioProva(const Value: Integer): IPercentuaisCategorias;
begin
  Result := Self;
  Self.FIDUsuarioProva := Value;
end;

function TPercentuaisCategorias.ConsultaIDProva(const Value: Integer): IPercentuaisCategorias;
begin
  Result := Self;
  Self.FIDProva := Value;
end;

function TPercentuaisCategorias.Find: IPercentuaisCategorias;
var
  sdsConsulta: TFDQuery;
begin
  Result := Self;
  sdsConsulta := TFDQuery.Create(nil);
  try
    Connection.Connected := True;
    sdsConsulta.Connection := Connection;
    sdsConsulta.SQL.Add(Format(FSQLConsulta.ToString, [Self.FIDProva.ToString, Self.FIDUsuarioProva.ToString]));
    sdsConsulta.Open;
    SetLength(FLista, sdsConsulta.FieldByName('CONTADOR').AsInteger);
    if not(sdsConsulta.IsEmpty) then
    begin
      Self.FDescricao := sdsConsulta.FieldByName('DESCRICAO').AsString;
      Self.FPercentual := sdsConsulta.FieldByName('PERCENTUAL').AsInteger;

      sdsConsulta.First;
      while not(sdsConsulta.Eof) do
      begin
        FLista[sdsConsulta.RecNo - 1] :=
          TPercentuaisCategorias.New
                        .Descricao(sdsConsulta.FieldByName('DESCRICAO').AsString)
                        .Percentual(sdsConsulta.FieldByName('PERCENTUAL').AsInteger);

        sdsConsulta.Next;
      end;
    end
    else ClearFields;
  finally
    FreeAndNil(sdsConsulta);
  end;
end;

function TPercentuaisCategorias.Lista: TArray<IPercentuaisCategorias>;
begin
  Result := FLista;
end;

end.
