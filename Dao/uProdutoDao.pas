unit uProdutoDao;

interface
uses
  uConexao,FireDAC.Comp.Client,System.SysUtils, Data.DB, FireDAC.DApt;

type TProdutoDao = class
  private
    FConexao :TConexao;
    vFDC : TFDConnection;
  public
    constructor create;

    destructor Destroy;override;

    function CarregarProdutos : TFDQuery;
    function CarregarProdutosFCON : TFDMemTable;

    function Incluir(ACodigo :string; ADescricao:string; APreco:Currency; AEstoque:Real) : Boolean;
end;

implementation

{ TProdutoDao }


function TProdutoDao.CarregarProdutos: TFDQuery;
var
  vQry :TFDQuery;
begin
  vQry := FConexao.CriarQuery;

  vQry.Open('select * from produtos p order by p.descricao');

  Result := vQry;
end;

function TProdutoDao.CarregarProdutosFCON: TFDMemTable;

begin
  if not Assigned(vFDC) then
    vFDC := TFDConnection.Create(nil);

  vFDC := FConexao.GetConn;

  vFDC.ExecSQL('select * from produtos p order by p.descricao',TDataSet(Result));
end;

constructor TProdutoDao.create;
begin
  if not Assigned(FConexao) then
    FConexao := TConexao.Create;
end;

destructor TProdutoDao.Destroy;
begin
  if Assigned(vFDC) then
  begin
    if vFDC.Connected then
      vFDC.Connected := False;
  end;

  FreeAndNil(FConexao);
  inherited;
end;

function TProdutoDao.Incluir(ACodigo, ADescricao: string; APreco: Currency; AEstoque: Real): Boolean;
var
  vQry : TFDQuery;
begin
  vQry := FConexao.CriarQuery;

  try
    vQry.ExecSQL('insert into produtos (codigo, descricao, preco, estoque)' +
                 'values (:codigo, :descricao, :preco, :estoque)', [ACodigo, ADescricao, APreco, AEstoque]);
    Result := True;
  finally
    vQry.Free;
  end;
end;

end.
