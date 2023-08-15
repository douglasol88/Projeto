unit uAcessoView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.Mask;

type
  TfrmAcesso = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    edt_login: TEdit;
    Label2: TLabel;
    mk_senha: TMaskEdit;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    BitBtn1: TBitBtn;
    btnOk: TBitBtn;
    procedure mk_senhaKeyPress(Sender: TObject; var Key: Char);
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
  private
    function ValidarAcesso(ALogin, ASenha : string): Boolean;
  public
    { Public declarations }
  end;

var
  frmAcesso: TfrmAcesso;

implementation

uses
  uPrincipal;

{$R *.dfm}

procedure TfrmAcesso.BitBtn1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmAcesso.btnOkClick(Sender: TObject);
begin
  if not (ValidarAcesso(edt_login.Text,mk_senha.Text)) then
    raise Exception.Create('Usuário incorreto')
  else
  begin
    frmPrincipal := TfrmPrincipal.Create(Self);

    try
      frmPrincipal.Show;
    finally
      frmAcesso.Visible := False;
    end;
  end;
end;

procedure TfrmAcesso.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ProgressBar1.Position := 0;
end;

procedure TfrmAcesso.mk_senhaKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    btnOk.SetFocus;
end;

function TfrmAcesso.ValidarAcesso(ALogin, ASenha: string): Boolean;
var
  i : integer;
begin
  Result := False;

  if (ALogin = 'Usuario') and (ASenha = '1010') then
  begin
    ProgressBar1.Max := 12000;

    while Timer1.Interval < 12000 do
    begin
      ProgressBar1.Position := Timer1.Interval;
      Timer1.Interval := Timer1.Interval + 1;
      Application.ProcessMessages;
    end;

    Result := True;
  end;

end;

initialization
  ReportMemoryLeaksOnShutdown := True; // Verifica se não faltou dar Free em algum objeto

end.
