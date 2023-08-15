unit uCadProdutosView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.StorageBin, System.UITypes,
  uProdutoController, Vcl.Buttons;

type
  TfrmCadProdutosView = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    FDMemTable1: TFDMemTable;
    DataSource1: TDataSource;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edtCodigo: TEdit;
    Label3: TLabel;
    edtPreco: TEdit;
    edtDescricao: TEdit;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    edtEstoque: TEdit;
    btSalvar: TButton;
    FDMemTable1ID: TIntegerField;
    FDMemTable1CODIGO: TStringField;
    FDMemTable1DESCRICAO: TStringField;
    FDMemTable1PRECO: TBCDField;
    FDMemTable1ESTOQUE: TSingleField;
    GroupBox3: TGroupBox;
    edtPesquisa: TEdit;
    rbtCodigo: TRadioButton;
    rbtDescricao: TRadioButton;
    sbtPesquisar: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure rbtCodigoClick(Sender: TObject);
    procedure rbtDescricaoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbtPesquisarClick(Sender: TObject);
    procedure edtPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure edtPesquisaChange(Sender: TObject);
  private
    procedure CarregarGrid;
    procedure IncluirProduto;
    procedure PesquisarProduto;
    function validaCampo : Boolean;

  public
    { Public declarations }
  end;

var
  frmCadProdutosView: TfrmCadProdutosView;
  vProdutoController : TProdutoController;

implementation


{$R *.dfm}

{ TfrmCadProdutosView }

procedure TfrmCadProdutosView.btSalvarClick(Sender: TObject);
begin
  self.IncluirProduto;
end;

procedure TfrmCadProdutosView.CarregarGrid;
var
  vQuery : TFDQuery;
  vCon   : TFDMemTable;
begin
  if not Assigned(vProdutoController) then
    vProdutoController := TProdutoController.Create;

  try
    FDMemTable1.Close;
//    vQuery := vProdutoController.CarregarProdutos;

    FDMemTable1  := vProdutoController.CarregarProdutoFC;

    DataSource1.DataSet := FDMemTable1;

//    try
//      vQuery.FetchAll;
//      FDMemTable1.Data := vQuery.Data;
//    finally
//      vQuery.Close;
//      FreeAndNil(vQuery);
//    end;

  finally
//    FreeAndNil(vProdutoController);
  end;
end;

procedure TfrmCadProdutosView.edtPesquisaChange(Sender: TObject);
begin
  if edtPesquisa.Text = EmptyStr then
  begin
    sbtPesquisarClick(Sender);
  end;
end;

procedure TfrmCadProdutosView.edtPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key = #13) then
  begin
    sbtPesquisarClick(Sender);
  end;
end;

procedure TfrmCadProdutosView.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FDMemTable1.Close;

  if Assigned(vProdutoController) then
    FreeAndNil(vProdutoController);
end;

procedure TfrmCadProdutosView.FormShow(Sender: TObject);
begin
  Self.CarregarGrid;
  rbtCodigo.Checked := True;
end;

procedure TfrmCadProdutosView.IncluirProduto;
begin
  if Self.validaCampo then
  begin
    if not Assigned(vProdutoController) then
      vProdutoController := TProdutoController.Create;
    try
      vProdutoController.Acao      := tacIncluir;
      vProdutoController.CODIGO    := edtCodigo.Text;
      vProdutoController.DESCRICAO := edtDescricao.Text;

      vProdutoController.PRECO     := StrToCurr(FormatCurr('#,##0.00', StrToCurr(edtPreco.Text)));
      vProdutoController.ESTOQUE   := StrToFloat(FormatFloat('#,####0.0000', StrToFloat(edtEstoque.Text)));

      if vProdutoController.Salvar then
        messageDLG('Produto Cadastrado com sucesso.',mtInformation,[mbOK],0)
      else
        messageDLG('Não foi Possivel cadastrar o Produto.',mtError,[mbOK],0);

      Self.CarregarGrid;
    finally
//      vProdutoController.Free;
    end;
  end;
end;

procedure TfrmCadProdutosView.PesquisarProduto;
begin
  if edtPesquisa.Text <> '' then
  begin
    FDMemTable1.FilterOptions := [foCaseInsensitive];

    if rbtCodigo.Checked then
    begin
      FDMemTable1.Filter        := 'CODIGO like ' + QuotedStr(edtPesquisa.Text + '%');
      FDMemTable1.Filtered      := True;

      if not (FDMemTable1.RecordCount > 0) then
      begin
        FDMemTable1.Filter        := 'CODIGO like ' + QuotedStr('%' + edtPesquisa.Text + '%');
        FDMemTable1.Filtered      := True;
      end;
    end
    else if rbtDescricao.Checked then
    begin
      FDMemTable1.Filter        := 'DESCRICAO like ' + QuotedStr(edtPesquisa.Text + '%');
      FDMemTable1.Filtered      := True;

      if not (FDMemTable1.RecordCount > 0) then
      begin
        FDMemTable1.Filter        := 'DESCRICAO like ' + QuotedStr('%' + edtPesquisa.Text + '%');
        FDMemTable1.Filtered      := True;
      end;
    end;
  end
  else
    FDMemTable1.Filtered      := False;
end;

procedure TfrmCadProdutosView.rbtCodigoClick(Sender: TObject);
begin
  edtPesquisa.Clear;
end;

procedure TfrmCadProdutosView.rbtDescricaoClick(Sender: TObject);
begin
  edtPesquisa.Clear;
end;

procedure TfrmCadProdutosView.sbtPesquisarClick(Sender: TObject);
begin
  Self.PesquisarProduto;
end;

function TfrmCadProdutosView.validaCampo: Boolean;
begin
  Result := True;

  if edtCodigo.Text = '' then
  begin
    Application.MessageBox('Obrigatório Inserir um Código.','Atenção',MB_ICONWARNING);
    Exit(False);
  end;

  if edtDescricao.Text = '' then
  begin
    Application.MessageBox('Obrigatório Inserir a descrição do produto.','Atenção',MB_ICONWARNING);
    exit(False);
  end;
end;

end.
