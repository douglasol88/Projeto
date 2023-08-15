unit uCadClientesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.Client, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, System.UITypes, System.JSON,
  IPPeerClient, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  Vcl.Buttons, Vcl.Mask, REST.Types;

type
  TAcaoViewer = (Incluir, Alterar, Excluir, Abortar);

type
  TfrmClientes = class(TForm)
    Panel1: TPanel;
    FDMemTable: TFDMemTable;
    DataSource1: TDataSource;
    FDMemTableCODIGO: TIntegerField;
    FDMemTableNOME: TStringField;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    edtNome: TEdit;
    CEP: TLabel;
    mkCEP: TMaskEdit;
    btnBuscarCep: TBitBtn;
    cbUF: TComboBox;
    Label8: TLabel;
    edtEndereco: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtComplemento: TEdit;
    Label5: TLabel;
    edtNro: TEdit;
    Label6: TLabel;
    edtBairro: TEdit;
    Label7: TLabel;
    edtCidade: TEdit;
    FDMemTableENDERECO: TStringField;
    FDMemTableCOMPLEMENTO: TStringField;
    FDMemTableBAIRRO: TStringField;
    FDMemTableCIDADE: TStringField;
    FDMemTableUF: TStringField;
    FDMemTableCODIBGE: TStringField;
    FDMemTableNRO: TStringField;
    FDMemTableCEP: TStringField;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtPesqNome: TEdit;
    pnlGrid: TPanel;
    DBGrid1: TDBGrid;
    pnlButtons: TPanel;
    btnNovo: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    pnlButtonsInferior: TPanel;
    btnCancelar: TButton;
    btSalvar: TButton;
    procedure FormShow(Sender: TObject);
    procedure edtPesqNomeChange(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure btnBuscarCepClick(Sender: TObject);
    procedure mkCEPKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtNomeKeyPress(Sender: TObject; var Key: Char);
    procedure edtEnderecoKeyPress(Sender: TObject; var Key: Char);
    procedure edtNroKeyPress(Sender: TObject; var Key: Char);
    procedure edtComplementoKeyPress(Sender: TObject; var Key: Char);
    procedure edtBairroKeyPress(Sender: TObject; var Key: Char);
    procedure edtCidadeKeyPress(Sender: TObject; var Key: Char);
    procedure cbUFKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FJSON: TJSONArray;
    FIBGE: string;
    FAcaoViewer: TAcaoViewer;

    procedure LimpaCampos;
    procedure limpaCamposParaCep;
    procedure CarregarGrid;

    procedure PesquisarCliente;

    procedure SalvarOperacao;
    procedure CancelarOperacao;
    procedure SetJSON(const Value: TJSONArray);

    procedure CarregarRestClient;
    procedure BurcaCep(cep : integer);
    procedure SetIBGE(const Value: string);
    procedure CarregarEdits;
    procedure SetAcaoViewer(const Value: TAcaoViewer);

    function validaCampo : Boolean;
    function RemoveAcento(const pText: string): string;
    function SomenteNros(aValue:string):string;

    property JSON :TJSONArray read FJSON write SetJSON;
    property IBGE : string read FIBGE write SetIBGE;
    property AcaoViewer :TAcaoViewer read FAcaoViewer write SetAcaoViewer;
  public
  end;

var
  frmClientes: TfrmClientes;

implementation

uses
  uClienteController;

{$R *.dfm}

{ TClientes }

procedure TfrmClientes.btnBuscarCepClick(Sender: TObject);
var
  CEP: string;
begin
  limpaCamposParaCep;

  if mkCEP.Text <> '  .   -   ' then
  begin
    CEP := SomenteNros(mkCEP.Text);

    if length(CEP) > 0 then
    begin
      Self.CarregarRestClient;
      Self.BurcaCep(StrToInt(CEP));
    end;
  end;
end;

procedure TfrmClientes.btnCancelarClick(Sender: TObject);
begin
  Self.CancelarOperacao;
end;

procedure TfrmClientes.btnExcluirClick(Sender: TObject);
begin
  if not (FDMemTable.IsEmpty) then
  begin
    FAcaoViewer := Excluir;
    btSalvarClick(Self);
  end;
end;

procedure TfrmClientes.btSalvarClick(Sender: TObject);
begin
  Self.SalvarOperacao;
end;

procedure TfrmClientes.BurcaCep(cep : integer);
var
  i : integer;
  JSon : string;
  ArrayJSON :TJSONArray;
begin
  RESTRequest1.Resource := '/' + IntToStr(cep) + '/json';
  RESTRequest1.Method   := TRESTRequestMethod.rmGet;

  RESTRequest1.Execute;

  JSon := RESTRequest1.Response.JSONText;

  if TJSONObject.ParseJSONValue(JSon) is TJSONObject then
    ArrayJSON := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes('[' + JSon + ']'), 0) as TJSONArray
  else if TJSONObject.ParseJSONValue(JSon) is TJSONArray then
    ArrayJSON := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(JSon), 0) as TJSONArray;

  Try
    if not(ArrayJSON.Get(i).EstimatedByteSize <= 33) then
    begin
      for i := 0 to ArrayJSON.count - 1 do
      begin
        edtEndereco.Text    := ArrayJSON.Get(i).GetValue<string>('logradouro');
        cbUF.ItemIndex      := cbUF.Items.IndexOf(ArrayJSON.Get(i).GetValue<string>('uf'));
        edtComplemento.Text := ArrayJSON.Get(i).GetValue<string>('complemento');
        edtBairro.Text      := ArrayJSON.Get(i).GetValue<string>('bairro');
        edtCidade.Text      := ArrayJSON.Get(i).GetValue<string>('localidade');
        FIBGE               := ArrayJSON.Get(i).GetValue<string>('ibge');

        edtNro.SetFocus;
      end;
    end
    else
      begin
        Application.MessageBox('CEP INVÁLIDO.','ATENÇÃO',MB_ICONERROR);
        mkCEP.SetFocus;
      end;
  Finally
    if Assigned(TJSONObject.ParseJSONValue(JSon)) then
      TJSONObject.ParseJSONValue(JSon).Free;

    FreeAndNil(ArrayJSON);
  End;
end;

procedure TfrmClientes.btnNovoClick(Sender: TObject);
begin
  Self.LimpaCampos;
  FAcaoViewer := Incluir;
  edtNome.SetFocus;
end;

procedure TfrmClientes.btnAlterarClick(Sender: TObject);
begin
  FAcaoViewer := Alterar;
  edtNome.SetFocus;
end;

procedure TfrmClientes.CancelarOperacao;
begin
  LimpaCampos;
  FAcaoViewer := Abortar;

  Self.CarregarGrid;
  Self.CarregarEdits;
end;

procedure TfrmClientes.CarregarEdits;
begin
  if not(FDMemTable.IsEmpty) then
  begin
    LimpaCampos;

    edtNome.Text := FDMemTable.Fields[1].AsString;

    if not(FDMemTableCEP.IsNull)  then
      mkCEP.Text := FDMemTableCEP.Value;

    edtEndereco.Text    := FDMemTableENDERECO.AsString;
    edtNro.Text         := FDMemTableNRO.Value;
    edtComplemento.Text := FDMemTableCOMPLEMENTO.AsString;
    edtBairro.Text      := FDMemTableBAIRRO.AsString;
    edtCidade.Text      := FDMemTableCIDADE.AsString;
    cbUF.ItemIndex      := cbUF.Items.IndexOf(Trim(FDMemTableUF.Value));
  end;
end;

procedure TfrmClientes.CarregarGrid;
var
  vControllerCliente : TControllerCliente;
  vQuery :TFDQuery;
begin
  vControllerCliente := TControllerCliente.Create;

  try
    FDMemTable.Close;
    vQuery := vControllerCliente.CarregarClientes;

    try
      vQuery.FetchAll;

      FDMemTable.Data := vQuery.Data;
    finally
      vQuery.Close;
      vQuery.Free;
    end;
  finally
    vControllerCliente.Free
  end;
end;

procedure TfrmClientes.CarregarRestClient;
begin
  RESTClient1.ResetToDefaults;
  RESTRequest1.ResetToDefaults;
  RESTResponse1.ResetToDefaults;

  RESTClient1.BaseURL := 'https://viacep.com.br/ws';
end;

procedure TfrmClientes.cbUFKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    btSalvar.SetFocus;
end;

procedure TfrmClientes.DBGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Self.CarregarEdits;
end;

procedure TfrmClientes.DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Self.CarregarEdits;
end;

procedure TfrmClientes.edtBairroKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    edtCidade.SetFocus;
end;

procedure TfrmClientes.edtCidadeKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    cbUF.SetFocus;
end;

procedure TfrmClientes.edtComplementoKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    edtBairro.SetFocus;
end;

procedure TfrmClientes.edtEnderecoKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    edtNro.SetFocus;
end;

procedure TfrmClientes.edtNomeKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    mkCEP.SetFocus;
end;

procedure TfrmClientes.edtNroKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    edtComplemento.SetFocus;
end;

procedure TfrmClientes.edtPesqNomeChange(Sender: TObject);
begin
  Self.PesquisarCliente;
end;

procedure TfrmClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  RESTClient1.Free;
  RESTRequest1.Free;
  RESTResponse1.Free;

  if Assigned(FJSON) then
    FJSON.Free;
end;

procedure TfrmClientes.FormShow(Sender: TObject);
begin
  LimpaCampos;
  self.CarregarGrid;
end;

procedure TfrmClientes.SalvarOperacao;
var
  vControllerCliente :TControllerCliente;
  aMSG : string;
begin
  if Self.validaCampo then
  begin
    vControllerCliente := TControllerCliente.Create;

    try
      vControllerCliente.NOME        := edtNome.Text;
      vControllerCliente.ENDERECO    := edtEndereco.Text;
      vControllerCliente.COMPLEMENTO := edtComplemento.Text;
      vControllerCliente.BAIRRO      := edtBairro.Text;
      vControllerCliente.CIDADE      := edtCidade.Text;
      vControllerCliente.UF          := cbUF.Text;
      vControllerCliente.IBGE        := FIBGE;
      vControllerCliente.NRO         := edtNro.Text;
      vControllerCliente.CEP         := mkCEP.Text;

      case FAcaoViewer of
        Incluir:
        begin
          vControllerCliente.Acao := tacIncluir;
          aMSG := 'Cliente Cadastrado com sucesso.';
        end;
        Alterar:
        begin
          vControllerCliente.Acao   := tacAlterar;
          vControllerCliente.CODIGO := FDMemTableCODIGO.Value;
          aMSG := 'Cliente Alterado com sucesso.';
        end;
        Excluir:
        begin
          vControllerCliente.Acao   := tacExcluir;
          vControllerCliente.CODIGO := FDMemTableCODIGO.Value;

          if vControllerCliente.CODIGO > 0 then
          begin
            if Application.MessageBox('Deseja Excluir o Cliente Selecionado?','Atenção',36) = 6 then
              aMSG := 'Cliente Excluído com sucesso.'
            else
              vControllerCliente.CODIGO := 0;
          end;
        end;
        Abortar:
          vControllerCliente.Acao   := tacAbortar;
      end;

      if vControllerCliente.Salvar then
        messageDLG(aMSG,mtInformation,[mbOK],0)
      else
        messageDLG('Operação não realizada.',mtError,[mbOK],0);

      Self.CarregarGrid;
      Self.CarregarEdits;
    finally
      vControllerCliente.Free;
    end;
  end;
end;

procedure TfrmClientes.LimpaCampos;
begin
  FAcaoViewer := Abortar;
  edtPesqNome.Clear;
  edtNome.Clear;
  mkCEP.Clear;
  edtEndereco.Clear;
  edtComplemento.Clear;
  edtNro.Clear;
  edtBairro.Clear;
  edtCidade.Clear;
  cbUF.ItemIndex := -1;
end;

procedure TfrmClientes.limpaCamposParaCep;
begin
  edtPesqNome.Clear;
  edtEndereco.Clear;
  edtComplemento.Clear;
  edtNro.Clear;
  edtBairro.Clear;
  edtCidade.Clear;
  cbUF.ItemIndex := -1;
end;

procedure TfrmClientes.mkCEPKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    btnBuscarCep.SetFocus;
end;

procedure TfrmClientes.PesquisarCliente;
begin
  if edtPesqNome.Text <> '' then
  begin
    FDMemTable.FilterOptions := [foCaseInsensitive];
    FDMemTable.Filter        := 'NOME like ' + QuotedStr(edtPesqNome.Text + '%');
    FDMemTable.Filtered      := True;
  end
  else
    FDMemTable.Filtered := False;
end;

function TfrmClientes.RemoveAcento(const pText: string): string;
type
  USAscii20127 = type AnsiString(20127);
begin
  Result := string(USAscii20127(pText));
end;

procedure TfrmClientes.SetAcaoViewer(const Value: TAcaoViewer);
begin
  FAcaoViewer := Value;
end;

procedure TfrmClientes.SetIBGE(const Value: string);
begin
  FIBGE := Value;
end;

procedure TfrmClientes.SetJSON(const Value: TJSONArray);
begin
  FJSON := Value;
end;

function TfrmClientes.SomenteNros(aValue: string): string;
var
  i : integer;
  valor : string;
begin
  for i := 1 to Length(aValue) do
  begin
    if aValue[i] in ['0'..'9'] then
      valor := valor + aValue[i];
  end;

  Result := valor;
end;

function TfrmClientes.validaCampo: Boolean;
begin
  Result := True;

  if edtNome.Text = '' then
  begin
    Application.MessageBox('Obrigatório inserir um nome.','Atenção',MB_ICONERROR);
    Exit(False);
  end;
end;

end.
