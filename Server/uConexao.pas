unit uConexao;

interface

uses
  Data.SqlExpr,
  System.SysUtils,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.PG,
  FireDAC.Phys.PGDef,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  IConexao = interface(IInterface)
    ['{33E169A8-7072-4ACE-BB3F-4A9D2CE65DE4}']
    procedure CreateConnection(const Conectar: Boolean);
  end;

  TConexao = class(TInterfacedObject, IConexao)
  strict private
  var
    FConnection: TFDConnection;
    FPhysDriverLink1: TFDPhysPgDriverLink;
    FTransaction: TFDTransaction;
  public
    constructor Create(const Conectar: Boolean);
    destructor Destroy; override;
    procedure CreateConnection(const Conectar: Boolean);
    property Connection: TFDConnection read FConnection write FConnection;
  end;

implementation

{ TConexao }

constructor TConexao.Create(const Conectar: Boolean);
begin
  inherited Create;
  CreateConnection(Conectar);
end;

procedure TConexao.CreateConnection(const Conectar: Boolean);
begin
  FPhysDriverLink1 := TFDPhysPgDriverLink.Create(nil);
  FPhysDriverLink1.VendorLib := 'libpq.dll';
  FPhysDriverLink1.DriverID := 'PG';
  FConnection := TFDConnection.Create(nil);
  FTransaction := TFDTransaction.Create(nil);

  FConnection.LoginPrompt := False;

  FConnection.Transaction := FTransaction;
  FConnection.UpdateTransaction := FTransaction;

  FConnection.Params.Values['DriverID'] := 'PG';
  FConnection.Params.Values['Database'] := 'simulados';
  FConnection.Params.Values['Password'] := 'aquasoft2020';
  FConnection.Params.Values['Port'] := '5432';
  FConnection.Params.Values['Server'] := 'localhost';
  FConnection.Params.Values['User_Name'] := 'postgres';

  FConnection.Connected := Conectar;
end;

destructor TConexao.Destroy;
begin
  if Assigned(FTransaction) then
  begin
    if FTransaction.Active then
      FTransaction.Rollback;

    FreeAndNil(FTransaction);
  end;

  if Assigned(FPhysDriverLink1) then
    FreeAndNil(FPhysDriverLink1);

  if Assigned(FConnection) then
  begin
    FConnection.Close;
    FreeAndNil(FConnection);
  end;
  inherited;
end;

end.
