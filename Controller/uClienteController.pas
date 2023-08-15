unit uClienteController;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, uClienteDao, uConexao;

type
  TAcao = (tacIncluir, tacAlterar, tacExcluir, tacAbortar);

type TControllerCliente = class
  private
    FClienteDao :TClienteDao;
    FCODIGO: integer;
    FNOME: string;
    FAcao: TAcao;
    FIBGE: string;
    FBAIRRO: string;
    FUF: string;
    FCOMPLEMENTO: string;
    FCIDADE: string;
    FENDERECO: string;
    FNRO: string;
    FCEP: string;
    procedure SetFCODIGO(const Value: integer);
    procedure SetNOME(const Value: string);
    procedure SetBAIRRO(const Value: string);
    procedure SetCIDADE(const Value: string);
    procedure SetCOMPLEMENTO(const Value: string);
    procedure SetENDERECO(const Value: string);
    procedure SetIBGE(const Value: string);
    procedure SetUF(const Value: string);
    procedure SetNRO(const Value: string);
    procedure SetCEP(const Value: string);

  public
    constructor Create;
    destructor Destroy; override;

    function CarregarClientes : TFDQuery;
    function Salvar : Boolean;

    property Acao : TAcao read FAcao write FAcao;
    property CODIGO: integer read FCODIGO write SetFCODIGO;
    property NOME : string read FNOME write SetNOME;
    property ENDERECO : string read FENDERECO write SetENDERECO;
    property COMPLEMENTO : string read FCOMPLEMENTO write SetCOMPLEMENTO;
    property BAIRRO : string read FBAIRRO write SetBAIRRO;
    property CIDADE : string read FCIDADE write SetCIDADE;
    property UF : string read FUF write SetUF;
    property IBGE : string read FIBGE write SetIBGE;
    property NRO : string read FNRO write SetNRO;
    property CEP : string read FCEP write SetCEP;

end;

implementation

{ TControllerCliente }

function TControllerCliente.CarregarClientes: TFDQuery;
begin
  Result := FClienteDao.CarregarClientes;
end;

constructor TControllerCliente.Create;
begin
  FClienteDao := TClienteDao.create;
end;

destructor TControllerCliente.Destroy;
begin
   FreeAndNil(FClienteDao);
  inherited;
end;

function TControllerCliente.Salvar: Boolean;
begin
  Result := False;

  case FAcao of
    tacIncluir: Result := FClienteDao.Incluir(FNOME, FENDERECO, FCOMPLEMENTO, FBAIRRO, FCIDADE, FUF, FIBGE, FNRO, FCEP);
    tacAlterar: Result := FClienteDao.Alterar(FCODIGO, FNOME, FENDERECO, FCOMPLEMENTO, FBAIRRO, FCIDADE, FUF, FIBGE, FNRO, FCEP);
    tacExcluir: Result := FClienteDao.Excluir(FCODIGO);
    tacAbortar: Result := False;
  end;
end;

procedure TControllerCliente.SetBAIRRO(const Value: string);
begin
  FBAIRRO := Value;
end;

procedure TControllerCliente.SetCEP(const Value: string);
begin
  FCEP := Value;
end;

procedure TControllerCliente.SetCIDADE(const Value: string);
begin
  FCIDADE := Value;
end;

procedure TControllerCliente.SetCOMPLEMENTO(const Value: string);
begin
  FCOMPLEMENTO := Value;
end;

procedure TControllerCliente.SetENDERECO(const Value: string);
begin
  FENDERECO := Value;
end;

procedure TControllerCliente.SetFCODIGO(const Value: integer);
begin
  FCODIGO := Value;
end;

procedure TControllerCliente.SetIBGE(const Value: string);
begin
  FIBGE := Value;
end;

procedure TControllerCliente.SetNOME(const Value: string);
begin
  FNOME := Value;
end;

procedure TControllerCliente.SetNRO(const Value: string);
begin
  FNRO := Value;
end;

procedure TControllerCliente.SetUF(const Value: string);
begin
  FUF := Value;
end;

end.
