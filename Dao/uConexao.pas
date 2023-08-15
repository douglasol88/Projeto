unit uConexao;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.FB, System.SysUtils, FireDAC.DApt, FireDAC.VCLUI.Wait, Data.SqlExpr;

type TConexao = class
  private
    Fconn  : TFDConnection;
    procedure ConfigurarConexao;
  public
    constructor Create;
    destructor Destroy; override;

    function GetConn :TFDConnection;
    function CriarQuery : TFDQuery;
end;

const
  PATH_BANCO : string = 'C:\Projeto\DB\PROJETO.FDB';

implementation

{ TConexao }

procedure TConexao.ConfigurarConexao;
begin
  FConn.Params.DriverID := 'FB';
  FConn.Params.Database := PATH_BANCO;
  FConn.Params.UserName := 'SYSDBA';
  FConn.Params.Password := 'masterkey';
  FConn.LoginPrompt     := False;

end;

constructor TConexao.Create;
begin
  Fconn := TFDConnection.Create(nil);

  Self.ConfigurarConexao;
end;

function TConexao.CriarQuery: TFDQuery;
var
  vQry : TFDQuery;
begin
  vQry := TFDQuery.Create(nil);
  vQry.Connection := FConn;
  Result := vQry;
end;

destructor TConexao.Destroy;
begin
  FreeAndNil(FConn);
  inherited;
end;

function TConexao.GetConn: TFDConnection;
begin
  Result := Fconn;
end;

end.
