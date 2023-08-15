unit uPedidoItensDao;

interface
uses
  uConexao, System.SysUtils, FireDAC.Comp.Client;

type TPedidoItensDao = class
  private
    FConexao :TConexao;
  public
    constructor create;
    destructor Destroy; override;

    function GetIDPedido : integer;

    function CarregarCliente(ANomeCli : string):TFDQuery;
    function CarregarProduto(ACodProd : string):TFDQuery;
    function incluirPedidoHeader(AIdCliente : integer; ATotal : Currency): Boolean;
    function IncluirItensPedido(AIdPedido : integer; ATabItens : TFDMemTable) : Boolean;
    function CarregarPedidoCompleto(AIdPedido : integer):TFDQuery;
end;

implementation

{ TPedidoItensDao }

function TPedidoItensDao.CarregarCliente(ANomeCli : string): TFDQuery;
var
  VQry : TFDQuery;
begin
  VQry := FConexao.CriarQuery;

  VQry.Open('select c.codigo, c.nome '+
            'from cliente c          '+
            'where c.nome like :nome', [ANomeCli] );

  Result := VQry;

end;

function TPedidoItensDao.CarregarPedidoCompleto(AIdPedido: integer): TFDQuery;
  var
    vQry :TFDQuery;
begin
  vQry := FConexao.CriarQuery;

  vQry.Open('select                                       '+
            'P.id id_pedido,                              '+
            'C.codigo CodCliente,                         '+
            'C.nome,                                      '+
            'P.total subtotal,                            '+
            'pi.id IDPedItens,                            '+
            'pi.produto,                                  '+
            'pi.descricao,                                '+
            'pi.unitario,                                 '+
            'pi.quantidade,                               '+
            'pi.total totalItem                           '+
            'from pedido P                                '+
            'join pedido_itens PI on (PI.idpedido = P.id) '+
            'join cliente C on (C.codigo = P.id_cliente)  '+
            'where P.id =:id', [AIdPedido]                );

  Result := vQry;

end;

function TPedidoItensDao.CarregarProduto(ACodProd: string): TFDQuery;
var
  vQry : TFDQuery;
begin
  vQry := FConexao.CriarQuery;

  vQry.Open('select * from produtos p where p.codigo like :codigo', [ACodProd]);

  Result := vQry;
end;

constructor TPedidoItensDao.create;
begin
  if not Assigned(FConexao) then
    FConexao := TConexao.Create;
end;

destructor TPedidoItensDao.Destroy;
begin
  if Assigned(FConexao) then
    FreeAndNil(FConexao);
  inherited;
end;

function TPedidoItensDao.GetIDPedido: integer;
var
  vQry : TFDQuery;
begin
  vQry := FConexao.CriarQuery;

  try
    vQry.Open('select gen_id(RDB$3,0) from rdb$database');

    Result := vQry.Fields[0].AsInteger;
  finally
    vQry.Close;
    FreeAndNil(vQry);
  end;
end;

function TPedidoItensDao.IncluirItensPedido(AIdPedido: integer;
  ATabItens: TFDMemTable): Boolean;
var
  VQry : TFDQuery;
begin
  VQry := FConexao.CriarQuery;

  try
    if ATabItens.RecordCount > 0 then
    begin
      ATabItens.First;

      while not ATabItens.Eof do
      begin
        VQry.ExecSQL('insert into pedido_itens (idpedido, produto, descricao, unitario, quantidade, total)'+
                     'values (:idpedido, :produto, :descricao, :unitario, :quantidade, :total)', [AIdPedido,ATabItens.Fields[5].Value,ATabItens.Fields[6].Value, ATabItens.Fields[7].Value, ATabItens.Fields[8].Value, ATabItens.Fields[9].Value]);
        ATabItens.Next;
      end;

      Result := True;
    end
    else
      Result := False;
  finally
    VQry.Free;
  end;
end;

function TPedidoItensDao.incluirPedidoHeader(AIdCliente: integer;
  ATotal: Currency): Boolean;
var
  VQry : TFDQuery;
begin
  VQry := FConexao.CriarQuery;

  try
    VQry.ExecSQL('insert into pedido (id_cliente, total) '+
                 'values (:id_cliente, :total)',[AIdCliente,ATotal]   );
    Result := True;

  finally
    FreeAndNil(VQry);
  end;
end;

end.
