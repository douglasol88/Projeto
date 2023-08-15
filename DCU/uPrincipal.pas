unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Clientes1: TMenuItem;
    Produtos1: TMenuItem;
    Venda1: TMenuItem;
    PedidodeVenda1: TMenuItem;
    Sair1: TMenuItem;
    procedure Clientes1Click(Sender: TObject);
    procedure Produtos1Click(Sender: TObject);
    procedure PedidodeVenda1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  uCadClientesView, uCadProdutosView, uPedidoItensView;

{$R *.dfm}

procedure TfrmPrincipal.Clientes1Click(Sender: TObject);
begin
  frmClientes := TfrmClientes.Create(Self);
  try
    frmClientes.ShowModal;
  finally
    FreeAndNil(frmClientes);
  end;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(frmPrincipal);
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.PedidodeVenda1Click(Sender: TObject);
begin
  frmPedidoVenda := TfrmPedidoVenda.Create(Self);

  try
    frmPedidoVenda.ShowModal;
  finally
    FreeAndNil(frmPedidoVenda);
  end;
end;

procedure TfrmPrincipal.Produtos1Click(Sender: TObject);
begin
  frmCadProdutosView := TfrmCadProdutosView.Create(Self);
  try
    frmCadProdutosView.ShowModal;
  finally
    FreeAndNil(frmCadProdutosView);
  end;
end;

procedure TfrmPrincipal.Sair1Click(Sender: TObject);
begin
  Close;
end;

end.
