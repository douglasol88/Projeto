unit uClienteDao;

interface

uses
  FireDAC.Comp.Client, uConexao, System.SysUtils;

type TClienteDao = Class
  private
    FConexao :TConexao;
  public
    constructor create;
    destructor Destroy; Override;

    function CarregarClientes: TFDQuery;
    function Incluir(ANome, AEndereco, AComplemento, ABairro, ACidade, AUF, ACodIBGE, ANro, ACep :string) : Boolean;
    function Alterar(ACodigo: integer; ANome, AEndereco, AComplemento, ABairro, ACidade, AUF, ACodIBGE, ANro, ACep :string) :Boolean;
    function Excluir(ACodigo : integer): Boolean;
End;

implementation

{ TClienteDao }

function TClienteDao.Alterar(ACodigo: integer; ANome, AEndereco, AComplemento,
  ABairro, ACidade, AUF, ACodIBGE, ANro, ACep: string): Boolean;
var
  vQry : TFDQuery;
begin
  vQry := FConexao.CriarQuery;

  try
    vQry.ExecSQL('update cliente set nome = :nome, endereco = :endereco, complemento = :complemento, bairro = :bairro, cidade = :cidade, uf = :uf, codibge = :codibge, nro = :nro, cep = :cep ' +
                 'where (codigo = :codigo)',[ANome, AEndereco, AComplemento, ABairro, ACidade, AUF, ACodIBGE, ANro, ACep, ACodigo]);
    Result := True;
  finally
    vQry.Free;
  end;

end;

function TClienteDao.CarregarClientes: TFDQuery;
var
  vQry :TFDQuery;
begin
  vQry := FConexao.CriarQuery;

  vQry.Open('select * from cliente c order by c.nome');

  Result := vQry;
end;

constructor TClienteDao.create;
begin
  if not Assigned(FConexao) then
    FConexao := TConexao.Create;
end;

destructor TClienteDao.Destroy;
begin
  if Assigned(FConexao) then
    FreeAndNil(FConexao);

  inherited;
 end;

function TClienteDao.Excluir(ACodigo: integer): Boolean;
var
  VQuery :TFDQuery;
begin
  VQuery := FConexao.CriarQuery;

  try
   Result := (VQuery.ExecSQL('delete from cliente c where c.codigo =:codigo',[ACodigo]) > 0);
  finally
    VQuery.Free;
  end;

end;

function TClienteDao.Incluir(ANome, AEndereco, AComplemento, ABairro, ACidade, AUF, ACodIBGE, ANro, ACep :string): Boolean;
var
  vQry : TFDQuery;
begin
  vQry := FConexao.CriarQuery;

  try
    vQry.ExecSQL('insert into cliente (nome, endereco, complemento, bairro, cidade, uf, codibge, nro, cep)'   +
                 'values (:nome, :endereco, :complemento, :bairro, :cidade, :uf, :codibge, :nro, :cep)',[ANome, AEndereco, AComplemento, ABairro, ACidade, AUF, ACodIBGE, ANro, ACep]);
    Result := True;
  finally
    vQry.Free;
  end;
end;

end.
