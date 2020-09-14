unit uRequisicoes;

interface

uses
  REST.Types,
  REST.Client,
  Data.Bind.Components,
  Data.Bind.ObjectScope;

type
  IRequisicoes = Interface(IInterface)
    ['{4D326DD3-B311-4E73-906E-7BA3F2E23686}']
    function EndPoint(const Value: string): IRequisicoes; overload;
    function EndPoint: string; overload;
    function AcessToken(const Value: string): IRequisicoes; overload;
    function AcessToken: string; overload;
    function Body(const Value: UTF8String): IRequisicoes; overload;
    function Body: UTF8String; overload;
    function Get: IRequisicoes;
    function Post: IRequisicoes;
    function JSONResponse: string;
    function ResponseCode: Integer;
  End;

  TRequisicoes = class(TInterfacedObject, IRequisicoes)
  strict private
  var
    FEndPoint: string;
    FAcessToken: string;
    FBody: UTF8String;
    FRestClient: TRESTClient;
    FRestResponse: TRESTResponse;
    FRestRequest: TRESTRequest;
  private
    function IncludeTrailingHTTPDelimiter(const Value: string): string;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IRequisicoes;
    function EndPoint(const Value: string): IRequisicoes; overload;
    function EndPoint: string; overload;
    function AcessToken(const Value: string): IRequisicoes; overload;
    function AcessToken: string; overload;
    function Body(const Value: UTF8String): IRequisicoes; overload;
    function Body: UTF8String; overload;
    function Get: IRequisicoes;
    function Post: IRequisicoes;
    function JSONResponse: string;
    function ResponseCode: Integer;
  end;

implementation

uses
  SysUtils;

{ TRequisicoes }

function TRequisicoes.AcessToken: string;
begin
  Result := FAcessToken;
end;

function TRequisicoes.Body: UTF8String;
begin
  Result := FBody;
end;

function TRequisicoes.Body(const Value: UTF8String): IRequisicoes;
begin
  Result := Self;
  FBody := Value;
end;

constructor TRequisicoes.Create;
begin
  FRestClient := TRESTClient.Create(nil);
  FRestResponse := TRESTResponse.Create(nil);
  FRestRequest := TRESTRequest.Create(nil);
  FRestRequest.Client := FRestClient;
  FRestRequest.Response := FRestResponse;
  FRestRequest.Method := TRESTRequestMethod.rmPOST;
  FRestRequest.Timeout := 99999999;
  FRestClient.BaseURL := 'http://ec2-3-133-8-186.us-east-2.compute.amazonaws.com:211/';
//  FRestClient.BaseURL := 'http://localhost:211/';
  FRESTClient.ContentType := 'application/json';
end;

destructor TRequisicoes.Destroy;
begin
  FreeAndNil(FRESTClient);
  FreeAndNil(FRESTRequest);
  FreeAndNil(FRESTResponse);
  inherited;
end;

function TRequisicoes.AcessToken(const Value: string): IRequisicoes;
begin
  Result := Self;
  FAcessToken := Value;
end;

function TRequisicoes.EndPoint: string;
begin
  Result := FEndPoint;
end;

function TRequisicoes.IncludeTrailingHTTPDelimiter(const Value: string): string;
begin
  Result := Value;
  if (Result[Length(Result) - 1] <> '/') then
    Result := Result + '/';
end;

function TRequisicoes.EndPoint(const Value: string): IRequisicoes;
begin
  Result := Self;
  FEndPoint := Value;
end;

function TRequisicoes.Get: IRequisicoes;
var
  Parameter: TRESTRequestParameter;
begin
  Result := Self;
  FRestClient.BaseURL := IncludeTrailingHTTPDelimiter(FRestClient.BaseURL) + FEndPoint;
  FRESTRequest.Method := TRESTRequestMethod.rmGET;
  if (FAcessToken <> EmptyStr) then
  begin
    FRESTRequest.Params.Clear;
    //Authorization:
    Parameter := TRESTRequestParameter(FRESTRequest.Params.Add);
    Parameter.Kind := TRESTRequestParameterKind.pkHTTPHEADER;
    Parameter.ContentType := ctNone;
    Parameter.Name := 'Authorization';
    Parameter.Value := 'Bearer ' + FAcessToken;
    Parameter.Options := [poDoNotEncode];
  end;
  FRESTRequest.Execute;
end;

function TRequisicoes.JSONResponse: string;
begin
  if (Pos('{"result":[', FRestResponse.JSONValue.ToString) > 0) then
  begin
    Result := FRestResponse.JSONValue.ToString.Replace('{"result":[', '', []);
    Result := Copy(Result, 1, Length(Result) - 2);
  end;
end;

class function TRequisicoes.New: IRequisicoes;
begin
  Result := Self.Create;
end;

function TRequisicoes.Post: IRequisicoes;
var
  Parameter: TRESTRequestParameter;
begin
  Result := Self;
  FRestClient.BaseURL := IncludeTrailingHTTPDelimiter(FRestClient.BaseURL) + FEndPoint;
  FRESTRequest.Method := TRESTRequestMethod.rmPOST;
  if (FAcessToken <> EmptyStr) then
  begin
    FRESTRequest.Params.Clear;
    //Authorization:
    Parameter := TRESTRequestParameter(FRESTRequest.Params.Add);
    Parameter.Kind := TRESTRequestParameterKind.pkHTTPHEADER;
    Parameter.ContentType := ctNone;
    Parameter.Name := 'Authorization';
    Parameter.Value := 'Bearer ' + FAcessToken;
    Parameter.Options := [poDoNotEncode];
  end;

  if (UnicodeString(FBody) <> EmptyStr) then
  begin
    FRESTRequest.AddBody(UnicodeString(FBody), ContentTypeFromString(CONTENTTYPE_APPLICATION_JSON));
  end;

  FRESTRequest.Execute;
end;

function TRequisicoes.ResponseCode: Integer;
begin
  Result := FRestResponse.StatusCode;
end;

end.
