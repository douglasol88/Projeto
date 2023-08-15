unit uPedidoItensView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,System.UITypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmPedidoVenda = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    edtBuscaCliente: TEdit;
    btIncluir: TButton;
    GroupBox2: TGroupBox;
    lblNroPedido: TLabel;
    btnBuscaCliente: TBitBtn;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    edtBuscaCodProduto: TEdit;
    Label1: TLabel;
    edtDescrProduto: TEdit;
    Label2: TLabel;
    Label5: TLabel;
    edtValorUnit: TEdit;
    edtQtde: TEdit;
    DBGrid1: TDBGrid;
    GroupBox4: TGroupBox;
    lblSubTotal: TLabel;
    btnBuscaProduto: TBitBtn;
    btnCancelar: TButton;
    btSalvar: TButton;
    edtIdCli: TEdit;
    FDMemClientes: TFDMemTable;
    FDMemProdutos: TFDMemTable;
    DataSource1: TDataSource;
    edtTotalizador: TEdit;
    Label7: TLabel;
    btnIncluir: TBitBtn;
    FDMemItensPedido: TFDMemTable;
    FDMemItensPedidoIDPEDIDO: TIntegerField;
    FDMemItensPedidoCODCLIENTE: TIntegerField;
    FDMemItensPedidoNOME: TStringField;
    FDMemItensPedidoSUBTOTAL: TCurrencyField;
    FDMemItensPedidoIDPEDITENS: TIntegerField;
    FDMemItensPedidoPRODUTO: TStringField;
    FDMemItensPedidoDESCRICAO: TStringField;
    FDMemItensPedidoUNITARIO: TCurrencyField;
    FDMemItensPedidoQUANTIDADE: TFloatField;
    FDMemItensPedidoTOTALITEM: TCurrencyField;
    FDMemTable1: TFDMemTable;
    procedure btIncluirClick(Sender: TObject);
    procedure edtBuscaClienteKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure edtBuscaCodProdutoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBuscaCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorUnitChange(Sender: TObject);
    procedure edtQtdeChange(Sender: TObject);
    procedure edtValorUnitKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorUnitExit(Sender: TObject);
    procedure edtQtdeKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtdeExit(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
  private
    FIDProduto: integer;
    FNVPedido: Boolean;

    procedure BuscarIDPedido;
    procedure BuscarCliente(AClienteNome: string);
    procedure BuscarProduto(AProdCodigo: string);
    procedure CalcularCampos;

    procedure AtivaCampos;
    procedure DesativaCampos;
    procedure SetIDProduto(const Value: integer);

    procedure SetNVPedido(const Value: Boolean);
    procedure IncluirItensPedido(AIdPedido : integer; ATableItens :TFDMemTable);
    procedure IncluirItensTemp;
    procedure CarregarItensPedido(AIdPedido : integer);


    function IncPedidoHeader(AIdCliente: integer; ATotal: Currency): Boolean;

    property NVPedido: Boolean read FNVPedido write SetNVPedido;
  public
    property IDProduto: integer read FIDProduto write SetIDProduto;
  end;

var
  frmPedidoVenda: TfrmPedidoVenda;
  SubTotal : Currency;
implementation

uses uPedidoItensController;

{$R *.dfm}

procedure TfrmPedidoVenda.AtivaCampos;
begin
  edtBuscaCliente.Enabled := True;
  edtBuscaCodProduto.Enabled := True;
  edtDescrProduto.Enabled := True;
  edtValorUnit.Enabled := True;
  edtQtde.Enabled := True;
  btIncluir.Enabled := True;
  edtBuscaCliente.SetFocus;

end;

procedure TfrmPedidoVenda.btIncluirClick(Sender: TObject);
begin
  FNVPedido := True;
  self.BuscarIDPedido;
  self.AtivaCampos;

end;

procedure TfrmPedidoVenda.btnIncluirClick(Sender: TObject);
begin
  self.IncluirItensTemp;
end;

procedure TfrmPedidoVenda.btSalvarClick(Sender: TObject);
begin
 if IncPedidoHeader(StrToInt(edtIdCli.Text),SubTotal) then
 begin
   self.BuscarIDPedido;
   Self.IncluirItensPedido(StrToInt(lblNroPedido.Caption), FDMemItensPedido);

   Self.CarregarItensPedido(StrToInt(lblNroPedido.Caption));
 end
 else
   messageDLG('Não foi Possivel salvar o cabeçalho do pedido.', mtError, [mbOK], 0);
end;

procedure TfrmPedidoVenda.BuscarCliente(AClienteNome: string);
var
  vControllerPedidoItens: TPedidoItensController;
  vQuery: TFDQuery;

begin
  vControllerPedidoItens := TPedidoItensController.create;

  try
    FDMemClientes.Close;
    vQuery := vControllerPedidoItens.BuscarCliente(AClienteNome + '%');
    try
      vQuery.FetchAll;
      FDMemClientes.Data := vQuery.Data;

    finally
      vQuery.Close;
      FreeAndNil(vQuery);
    end;
  finally
    vControllerPedidoItens.Free;
  end;
end;

procedure TfrmPedidoVenda.BuscarIDPedido;
var
  vControllerPedidoItens: TPedidoItensController;
begin
  vControllerPedidoItens := TPedidoItensController.create;

  try
    case NVPedido of
      True : lblNroPedido.Caption := IntToStr(vControllerPedidoItens.GetIDPedido + 1);
      False: lblNroPedido.Caption := IntToStr(vControllerPedidoItens.GetIDPedido);
    end;

    NVPedido := False;

  finally
    FreeAndNil(vControllerPedidoItens);
  end;
end;

procedure TfrmPedidoVenda.BuscarProduto(AProdCodigo: string);
var
  vControllerPedidoItens: TPedidoItensController;
  vQuery: TFDQuery;

begin
  vControllerPedidoItens := TPedidoItensController.create;

  try
    FDMemProdutos.Close;
    vQuery := vControllerPedidoItens.BuscarProduto(AProdCodigo + '%');
    try
      vQuery.FetchAll;
      FDMemProdutos.Data := vQuery.Data;
    finally
      vQuery.Close;
      FreeAndNil(vQuery);
    end;
  finally
    vControllerPedidoItens.Free;
  end;

end;

procedure TfrmPedidoVenda.CalcularCampos;
var
  vPrcUnit, Total: Currency;
  vQtd: Real;

begin
  if (edtValorUnit.Text <> '') and (edtQtde.Text <> '') then
  begin
    vPrcUnit := StrToCurr(edtValorUnit.Text);
    vQtd := StrToFloat(edtQtde.Text);

    if vPrcUnit <= 0 then
    begin
      Application.MessageBox('Preço unitário não permitido.', 'Atenção',
        MB_ICONERROR);
      Exit;
    end;

    if vQtd <= 0 then
    begin
      Application.MessageBox('Quantidade não permitida.', 'Atenção',
        MB_ICONERROR);
      Exit;
    end;

    Total := (vQtd * vPrcUnit);

    edtTotalizador.Text := FormatCurr('##0.00', Total);
  end;
end;

procedure TfrmPedidoVenda.CarregarItensPedido(AIdPedido: integer);
var
  vControllerPedidoItens: TPedidoItensController;
  vQuery: TFDQuery;
begin
  vControllerPedidoItens := TPedidoItensController.create;

  try
//    FDMemItensPedido.Edit;
//    FDMemItensPedido.EmptyDataSet;
   // FDMemItensPedido.ClearFields;


//    FDMemItensPedido.Close;

    FDMemTable1.Close;

    vQuery := vControllerPedidoItens.CarregarPedidoFinalizado(AIdPedido);

    try
      vQuery.FetchAll;
//      FDMemItensPedido.Data := vQuery.Data;

      FDMemTable1.Data := vQuery.Data;

    finally
      vQuery.Close;
      FreeAndNil(vQuery);
    end;

  finally
    vControllerPedidoItens.Free;
  end;

end;

procedure TfrmPedidoVenda.DesativaCampos;
begin
  SubTotal                   := 0;
  lblNroPedido.Caption       := '0';
  edtBuscaCliente.Enabled    := False;
  edtBuscaCodProduto.Enabled := False;
  edtDescrProduto.Enabled    := False;
  edtValorUnit.Enabled       := False;
  edtQtde.Enabled            := False;
  // btIncluir.Enabled       := False;
end;

procedure TfrmPedidoVenda.edtBuscaClienteKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Texto: string;
  p: integer;
begin
  with edtBuscaCliente do
  begin
    if Key = 13 then
    begin
      SelStart := length(Text);
      // SelectNext(TWinControl(Sender), true, true);//Passa o foco para o próximo componente segundo o taborder
      edtBuscaCodProduto.SetFocus;
    end
    else if Key = 27 then
    begin
      edtBuscaCliente.Clear;
      edtIdCli.Clear;
    end
    else
    begin
      if not(Key = 08) or (Key = 46) then // Se Não for BackSpace ou Delete
      begin
        p := SelStart;
        Texto := copy(Text, 0, p);

        self.BuscarCliente(Texto);

        if FDMemClientes.RecordCount > 0 then
        begin
          FDMemClientes.First;
          edtIdCli.Text := IntToStr(FDMemClientes.Fields[0].AsInteger);
          Text := FDMemClientes.Fields[1].AsString;
          // o text do edit em questão recebe o complemento do texto digitado.
          SelStart := p;
          SelLength := length(Text) - SelStart;
        end
        else
          edtIdCli.Clear;
      end
      else if (Key = 08) or (Key = 46) then
        edtIdCli.Clear;
    end;
  end;
end;

procedure TfrmPedidoVenda.edtBuscaCodProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    if not(FDMemProdutos.Fields[4].AsFloat > 0) then
    begin
      Application.MessageBox('Produto não possui saldo suficiente.', 'Atenção', MB_ICONERROR);
      edtBuscaCodProduto.Clear;
      edtDescrProduto.Clear;
      edtValorUnit.Clear;
      edtQtde.Clear;
      edtTotalizador.Clear;
      edtBuscaCodProduto.SetFocus;
      Exit;
    end
    else
      edtValorUnit.SetFocus;
  end;
end;

procedure TfrmPedidoVenda.edtBuscaCodProdutoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  Texto: string;
  p: integer;
begin
  with edtBuscaCodProduto do
  begin
    if Key = 13 then
    begin
      SelStart := length(Text);

      // SelectNext(TWinControl(Sender), true, true);//Passa o foco para o próximo componente segundo o taborder
    end
    else if Key = 27 then
    begin
      edtBuscaCodProduto.Clear;
      edtDescrProduto.Clear;
      edtValorUnit.Clear;
      edtQtde.Clear;
      edtTotalizador.Clear;
    end
    else
    begin
      if not(Key = 08) or (Key = 46) then // Se Não for BackSpace ou Delete
      begin
        p := SelStart;
        Texto := copy(Text, 0, p);

        self.BuscarProduto(Texto);

        if FDMemProdutos.RecordCount > 0 then
        begin
          FDMemProdutos.First;
          Text := FDMemProdutos.Fields[1].AsString;
          // o text do edit em questão recebe o complemento do texto digitado.

          edtDescrProduto.Text := FDMemProdutos.Fields[2].AsString;
          edtValorUnit.Text := FormatCurr('0.00',
            FDMemProdutos.Fields[3].AsCurrency);
          edtQtde.Text := FormatFloat('####0.000', 1);
          IDProduto := FDMemProdutos.Fields[0].AsInteger;

          SelStart := p;
          SelLength := length(Text) - SelStart;
        end
        else
        begin
          edtDescrProduto.Clear;
          edtValorUnit.Clear;
          edtQtde.Clear;
          edtTotalizador.Clear;
        end;
      end
      else if (Key = 08) or (Key = 46) then
      begin
        edtBuscaCodProduto.Clear;
        edtDescrProduto.Clear;
        edtValorUnit.Clear;
        edtQtde.Clear;
        edtTotalizador.Clear;
      end;
    end;
  end;
end;

procedure TfrmPedidoVenda.edtQtdeChange(Sender: TObject);
begin
  if edtQtde.Text <> '' then
    self.CalcularCampos;
end;

procedure TfrmPedidoVenda.edtQtdeExit(Sender: TObject);
begin
  if edtQtde.Text <> '' then
    edtQtde.Text := FormatFloat('0.000', StrToFloat(Trim(edtQtde.Text)));
end;

procedure TfrmPedidoVenda.edtQtdeKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0' .. '9', ',', #13, #08, #09]) then
    Key := #0;

  if Key = #13 then
    btnIncluir.SetFocus;
end;

procedure TfrmPedidoVenda.edtValorUnitChange(Sender: TObject);
begin
  if edtValorUnit.Text <> '' then
    self.CalcularCampos;
end;

procedure TfrmPedidoVenda.edtValorUnitExit(Sender: TObject);
begin
  if edtValorUnit.Text <> '' then
    edtValorUnit.Text := FormatCurr('0.00', StrToCurr(Trim(edtValorUnit.Text)));
end;

procedure TfrmPedidoVenda.edtValorUnitKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0' .. '9', ',', #13, #08, #09]) then
    Key := #0;

  if Key = #13 then
    edtQtde.SetFocus;
end;

procedure TfrmPedidoVenda.FormCreate(Sender: TObject);
begin
  // if not Assigned(FDMemProdutos) then
  // FDMemProdutos.CreateDataSet;

  DesativaCampos;

end;

procedure TfrmPedidoVenda.IncluirItensPedido(AIdPedido: integer; ATableItens: TFDMemTable);
var
  vPedidoItensController: TPedidoItensController;
begin
  vPedidoItensController := TPedidoItensController.create;

  try
    vPedidoItensController.Acao           := tacIncluir;
    vPedidoItensController.IDPedido       := AIdPedido;
    vPedidoItensController.TabItensPedido := ATableItens;

    if not vPedidoItensController.SalvarItensPedido then
    begin
      messageDLG('Não foi Possivel salvar os itens do Pedido.', mtError, [mbOK], 0);
      Exit;
    end;
  finally
    vPedidoItensController.Free;
  end;

end;

procedure TfrmPedidoVenda.IncluirItensTemp;
begin
  // with FDMemItensPedido.FieldDefs do
  // begin
  // with AddFieldDef do
  // begin
  // Name     := 'Produto';
  // DataType := ftString;
  // end;
  // end;
  try
    try
      FDMemItensPedido.Open;
      FDMemItensPedido.Append;
      // FDMemItensPedido.Fields[0].AsString   := frmPedidoVenda.edtBuscaCodProduto.Text;
      FDMemItensPedidoIDPEDIDO.AsInteger   := 0;
      FDMemItensPedidoCODCLIENTE.AsInteger := StrToInt(Trim(edtIdCli.Text));
      FDMemItensPedidoNOME.AsString        := edtBuscaCliente.Text;
     // FDMemItensPedidoSUBTOTAL.Value       := StrToCurr(lblSubTotal.Caption);

      FDMemItensPedidoSUBTOTAL.Clear;
      FDMemItensPedidoPRODUTO.AsString   := edtBuscaCodProduto.Text;
      FDMemItensPedidoDESCRICAO.AsString := frmPedidoVenda.edtDescrProduto.Text;
      FDMemItensPedidoUNITARIO.Value     := StrToCurr(edtValorUnit.Text);
      FDMemItensPedidoQUANTIDADE.Value   := StrToFloat(edtQtde.Text);
      FDMemItensPedidoTOTALITEM.Value    := StrToCurr(edtTotalizador.Text);
      FDMemItensPedido.Post;

    except on E: Exception do
    begin
      raise Exception.Create('Ocorreu um erro ao inserir o item:' + #13 +  E.message);
      Exit;
    end;

    end;
  finally
    SubTotal := SubTotal + StrToFloat(edtTotalizador.Text);
    lblSubTotal.Caption := FormatCurr('##0.00', SubTotal);

    edtBuscaCodProduto.Clear;
    edtDescrProduto.Clear;
    edtValorUnit.Clear;
    edtQtde.Clear;
    edtTotalizador.Clear;
    edtBuscaCodProduto.SetFocus;
  end;
end;

function TfrmPedidoVenda.IncPedidoHeader(AIdCliente: integer;
  ATotal: Currency): Boolean;
var
  vPedidoItensController: TPedidoItensController;
begin
  vPedidoItensController := TPedidoItensController.create;

  try
    vPedidoItensController.Acao := tacIncluir;
    vPedidoItensController.IDCliente := StrToInt(frmPedidoVenda.edtIdCli.Text);
    vPedidoItensController.Total := SubTotal;

    Result := vPedidoItensController.SalvarPedidoHeader;
  finally
    vPedidoItensController.Free;
  end;
end;

procedure TfrmPedidoVenda.SetIDProduto(const Value: integer);
begin
  FIDProduto := Value;
end;

procedure TfrmPedidoVenda.SetNVPedido(const Value: Boolean);
begin
  FNVPedido := Value;
end;

end.
