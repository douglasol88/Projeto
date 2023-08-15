unit uPedidoItensController;

interface

uses uPedidoItensDao,
  System.SysUtils,
  FireDAC.Comp.Client;

type
  TAcao = (tacIncluir, tacAlterar, tacExcluir);

type
  TPedidoItensController = class
  private
    FTotal: currency;
    FIDPedido: integer;
    FIDCliente: integer;
    FAcao: TAcao;
    FPedidoItensDao: TPedidoItensDao;
    FTabItensPedido: TFDMemTable;
    procedure SetIDCliente(const Value: integer);
    procedure SetIDPedido(const Value: integer);
    procedure SetTotal(const Value: currency);
    procedure SetAcao(const Value: TAcao);
    procedure SetTabItensPedido(const Value: TFDMemTable);

  public
    constructor create;
    destructor Destroy; override;

    function GetIDPedido: integer;
    function BuscarCliente(AClienteNome: string): TFDQuery;
    function BuscarProduto(ACodProduto: string): TFDQuery;
    function CarregarPedidoFinalizado(AIdPedido: integer): TFDQuery;

    function SalvarPedidoHeader: Boolean;

    function SalvarItensPedido: Boolean;

    // function SalvarItensPedido

    property Acao: TAcao read FAcao write SetAcao;
    property IDPedido: integer read FIDPedido write SetIDPedido;
    property IDCliente: integer read FIDCliente write SetIDCliente;
    property Total: currency read FTotal write SetTotal;
    property TabItensPedido: TFDMemTable read FTabItensPedido
      write SetTabItensPedido;

  end;

implementation

{ TPedidoItensController }

function TPedidoItensController.BuscarCliente(AClienteNome: string): TFDQuery;
var
  vQry: TFDQuery;
begin
  vQry := FPedidoItensDao.CarregarCliente(AClienteNome);
  Result := vQry;
end;

function TPedidoItensController.BuscarProduto(ACodProduto: string): TFDQuery;
begin
  Result := FPedidoItensDao.CarregarProduto(ACodProduto);
end;

function TPedidoItensController.CarregarPedidoFinalizado(AIdPedido: integer): TFDQuery;
var
  VQry : TFDQuery;
begin
  VQry := FPedidoItensDao.CarregarPedidoCompleto(AIdPedido);

  Result := VQry
end;

constructor TPedidoItensController.create;
begin
  FPedidoItensDao := TPedidoItensDao.create;
end;

destructor TPedidoItensController.Destroy;
begin
  FPedidoItensDao.Free;
  inherited;
end;

function TPedidoItensController.GetIDPedido: integer;
begin
  Result := FPedidoItensDao.GetIDPedido;
end;

function TPedidoItensController.SalvarItensPedido: Boolean;
begin
  Result := False;

  case FAcao of
    tacIncluir:
      Result := FPedidoItensDao.IncluirItensPedido(FIDPedido, FTabItensPedido);
    tacAlterar:
      Result := False;
    tacExcluir:
      Result := False;
  end;
end;

function TPedidoItensController.SalvarPedidoHeader: Boolean;
begin
  Result := False;

  case FAcao of
    tacIncluir:
      Result := FPedidoItensDao.incluirPedidoHeader(FIDCliente, FTotal);
    tacAlterar:
      Result := False;
    tacExcluir:
      Result := False;
  end;
end;

procedure TPedidoItensController.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TPedidoItensController.SetTabItensPedido(const Value: TFDMemTable);
begin
  FTabItensPedido := Value;
end;

procedure TPedidoItensController.SetIDCliente(const Value: integer);
begin
  FIDCliente := Value;
end;

procedure TPedidoItensController.SetIDPedido(const Value: integer);
begin
  FIDPedido := Value;
end;

procedure TPedidoItensController.SetTotal(const Value: currency);
begin
  FTotal := Value;
end;

end.
