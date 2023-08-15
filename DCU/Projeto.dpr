program Projeto;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uConexao in '..\Dao\uConexao.pas',
  uClienteDao in '..\Dao\uClienteDao.pas',
  uClienteController in '..\Controller\uClienteController.pas',
  uCadClientesView in '..\View\uCadClientesView.pas' {frmClientes},
  uProdutoDao in '..\Dao\uProdutoDao.pas',
  uProdutoController in '..\Controller\uProdutoController.pas',
  uCadProdutosView in '..\View\uCadProdutosView.pas' {frmCadProdutosView},
  uPedidoItensView in '..\View\uPedidoItensView.pas' {frmPedidoVenda},
  uPedidoItensController in '..\Controller\uPedidoItensController.pas',
  uPedidoItensDao in '..\Dao\uPedidoItensDao.pas',
  uAcessoView in '..\View\uAcessoView.pas' {frmAcesso};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmAcesso, frmAcesso);
  Application.Run;
end.
