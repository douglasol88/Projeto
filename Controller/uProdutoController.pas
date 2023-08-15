unit uProdutoController;

interface
uses
  uProdutoDao, System.SysUtils, FireDAC.Comp.Client;

type
  TAcao = (tacIncluir, tacAlterar, tacExcluir);

type TProdutoController = class
  private
    FProdutoDao :TProdutoDao;
    FPRECO: Currency;
    FDESCRICAO: string;
    FCODIGO: string;
    FESTOQUE: Real;
    FID: integer;
    FAcao: TAcao;
    procedure SetCODIGO(const Value: string);
    procedure SetDESCRICAO(const Value: string);
    procedure SetESTOQUE(const Value: Real);
    procedure SetID(const Value: integer);
    procedure SetPRECO(const Value: Currency);
    procedure SetAcao(const Value: TAcao);

  public
    constructor Create;
    destructor Destroy; override;

    function CarregarProdutos : TFDQuery;

    function CarregarProdutoFC : TFDMemTable;

    function Salvar : Boolean;

    property Acao : TAcao read FAcao write SetAcao;
    property ID        : integer read FID write SetID;
    property CODIGO    : string read FCODIGO write SetCODIGO;
    property DESCRICAO : string read FDESCRICAO write SetDESCRICAO;
    property PRECO     : Currency read FPRECO write SetPRECO;
    property ESTOQUE   : Real read FESTOQUE write SetESTOQUE;

end;

implementation

{ TProdutoController }

function TProdutoController.CarregarProdutoFC: TFDMemTable;
begin
  Result := FProdutoDao.CarregarProdutosFCON;
end;

function TProdutoController.CarregarProdutos: TFDQuery;
begin
  Result := FProdutoDao.CarregarProdutos;
end;

constructor TProdutoController.Create;
begin
  FProdutoDao := TProdutoDao.create;
end;

destructor TProdutoController.Destroy;
begin
  FProdutoDao.Free;
  inherited;
end;

function TProdutoController.Salvar: Boolean;
begin
  Result := False;

  case FAcao of
    tacIncluir: Result := FProdutoDao.Incluir(FCODIGO, FDESCRICAO, FPRECO, FESTOQUE);
    tacAlterar: Result := False;
    tacExcluir: Result := False;
  end;
end;

procedure TProdutoController.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TProdutoController.SetCODIGO(const Value: string);
begin
  FCODIGO := Value;
end;

procedure TProdutoController.SetDESCRICAO(const Value: string);
begin
  FDESCRICAO := Value;
end;

procedure TProdutoController.SetESTOQUE(const Value: Real);
begin
  FESTOQUE := Value;
end;

procedure TProdutoController.SetID(const Value: integer);
begin
  FID := Value;
end;

procedure TProdutoController.SetPRECO(const Value: Currency);
begin
  FPRECO := Value;
end;

end.
