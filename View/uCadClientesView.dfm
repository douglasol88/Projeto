object frmClientes: TfrmClientes
  Left = 0
  Top = 0
  Caption = 'Clientes'
  ClientHeight = 508
  ClientWidth = 880
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 880
    Height = 508
    Align = alClient
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 1
      Top = 346
      Width = 878
      Height = 127
      Align = alTop
      Caption = 'Detalhes:'
      TabOrder = 0
      object Label2: TLabel
        Left = 5
        Top = 25
        Width = 31
        Height = 13
        Caption = 'Nome:'
      end
      object CEP: TLabel
        Left = 243
        Top = 25
        Width = 19
        Height = 13
        Caption = 'CEP'
      end
      object Label8: TLabel
        Left = 801
        Top = 82
        Width = 17
        Height = 13
        Caption = 'UF:'
      end
      object Label3: TLabel
        Left = 373
        Top = 24
        Width = 49
        Height = 13
        Caption = 'Endere'#231'o:'
      end
      object Label4: TLabel
        Left = 5
        Top = 82
        Width = 69
        Height = 13
        Caption = 'Complemento:'
      end
      object Label5: TLabel
        Left = 743
        Top = 24
        Width = 41
        Height = 13
        Caption = 'N'#250'mero:'
      end
      object Label6: TLabel
        Left = 243
        Top = 82
        Width = 32
        Height = 13
        Caption = 'Bairro:'
      end
      object Label7: TLabel
        Left = 520
        Top = 82
        Width = 37
        Height = 13
        Caption = 'Cidade:'
      end
      object edtNome: TEdit
        Left = 3
        Top = 40
        Width = 232
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 40
        TabOrder = 0
        OnKeyPress = edtNomeKeyPress
      end
      object mkCEP: TMaskEdit
        Left = 241
        Top = 40
        Width = 95
        Height = 21
        EditMask = '99.999-999'
        MaxLength = 10
        TabOrder = 1
        Text = '  .   -   '
        OnKeyPress = mkCEPKeyPress
      end
      object btnBuscarCep: TBitBtn
        Left = 342
        Top = 38
        Width = 25
        Height = 25
        Hint = 'Buscar CEP'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000004A220966AC5116F07B380FAB0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00004D230A69B85617FFBB5617FFAE4F16F30000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000004D24
          0A69BC5819FFBB5718FFB95318FC401D08570000000000000000000000000000
          000000000000281406368A4315B7B3571AF0B35818F0854012B466300E89BD59
          19FFBC5919FFBA5719FC401E0857000000000000000000000000000000000000
          00005A2D0F78C05F1FFFC06021FFCD8250FFCD824FFFBE5D1FFFBE5A1BFFBD5A
          19FFBB5819FC401E095700000000000000000000000000000000000000003018
          083FC0601FFCCD804CFFF7EAE2FFFFFFFFFFFFFFFFFFF7EAE2FFCA7A46FFBC5A
          1BFF622F0D84000000000000000000000000000000000000000000000000944B
          18C3C36929FFF6E9E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E8DFFFC063
          23FF854012B4000000000000000000000000000000000000000000000000B75D
          20F0D18958FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF84
          54FFAD541AEA000000000000000000000000000000000000000000000000B85E
          20F0D18A59FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD085
          55FFAE541AEA000000000000000000000000000000000000000000000000964D
          1BC3C5692BFFF7EBE2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E8DFFFC164
          26FF854214B40000000000000000000000000000000000000000000000003019
          093FC36525FFCF844FFFF7EBE2FFFFFFFFFFFFFFFFFFF7EBE2FFCD804CFFBF5E
          1FFF361B08480000000000000000000000000000000000000000000000000000
          00005E31127BC36625FFC46726FFCF8551FFCF8350FFC46523FFC16020FF5D2E
          0F7B000000000000000000000000000000000000000000000000000000000000
          0000000000003019093F874518B1AD591EE4AD591EE4864517B13018083F0000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = btnBuscarCepClick
      end
      object cbUF: TComboBox
        Left = 798
        Top = 97
        Width = 40
        Height = 21
        TabOrder = 3
        OnKeyPress = cbUFKeyPress
        Items.Strings = (
          'AC'
          'AL'
          'AP'
          'AM'
          'BA'
          'CE'
          'DF'
          'ES'
          'GO'
          'MA'
          'MT'
          'MS'
          'MG'
          'PA'
          'PB'
          'PR'
          'PE'
          'PI'
          'RJ'
          'RN'
          'RS'
          'RO'
          'RR'
          'SC'
          'SP'
          'SE'
          'TO')
      end
      object edtEndereco: TEdit
        Left = 373
        Top = 40
        Width = 345
        Height = 21
        TabOrder = 4
        OnKeyPress = edtEnderecoKeyPress
      end
      object edtComplemento: TEdit
        Left = 3
        Top = 97
        Width = 232
        Height = 21
        TabOrder = 5
        OnKeyPress = edtComplementoKeyPress
      end
      object edtNro: TEdit
        Left = 741
        Top = 40
        Width = 97
        Height = 21
        TabOrder = 6
        OnKeyPress = edtNroKeyPress
      end
      object edtBairro: TEdit
        Left = 241
        Top = 97
        Width = 242
        Height = 21
        TabOrder = 7
        OnKeyPress = edtBairroKeyPress
      end
      object edtCidade: TEdit
        Left = 518
        Top = 97
        Width = 240
        Height = 21
        TabOrder = 8
        OnKeyPress = edtCidadeKeyPress
      end
    end
    object pnlCabecalho: TPanel
      Left = 1
      Top = 1
      Width = 878
      Height = 56
      Align = alTop
      TabOrder = 1
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 80
        Height = 13
        Caption = 'Pesquisar Nome:'
      end
      object edtPesqNome: TEdit
        Left = 6
        Top = 24
        Width = 332
        Height = 21
        TabOrder = 0
        OnChange = edtPesqNomeChange
      end
    end
    object pnlGrid: TPanel
      Left = 1
      Top = 57
      Width = 878
      Height = 259
      Align = alTop
      TabOrder = 2
      object DBGrid1: TDBGrid
        Left = 1
        Top = 1
        Width = 876
        Height = 257
        Align = alClient
        DataSource = DataSource1
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnKeyUp = DBGrid1KeyUp
        OnMouseUp = DBGrid1MouseUp
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIGO'
            Title.Caption = 'C'#243'digo:'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOME'
            Title.Caption = 'Nome:'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ENDERECO'
            Title.Caption = 'Endere'#231'o:'
            Width = 235
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COMPLEMENTO'
            Title.Caption = 'Complemento:'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NRO'
            Title.Caption = 'N'#250'mero:'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'BAIRRO'
            Title.Caption = 'Bairro:'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CIDADE'
            Title.Caption = 'Cidade:'
            Width = 183
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UF'
            Title.Caption = 'UF:'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CEP'
            Title.Caption = 'CEP:'
            Visible = True
          end>
      end
    end
    object pnlButtons: TPanel
      Left = 1
      Top = 316
      Width = 878
      Height = 30
      Align = alTop
      TabOrder = 3
      object btnNovo: TButton
        Left = 802
        Top = 1
        Width = 75
        Height = 28
        Align = alRight
        Caption = '&Novo'
        TabOrder = 0
        OnClick = btnNovoClick
      end
      object btnAlterar: TButton
        Left = 652
        Top = 1
        Width = 75
        Height = 28
        Align = alRight
        Caption = '&Alterar'
        TabOrder = 1
        OnClick = btnAlterarClick
      end
      object btnExcluir: TButton
        Left = 727
        Top = 1
        Width = 75
        Height = 28
        Align = alRight
        Caption = '&Excluir'
        TabOrder = 2
        OnClick = btnExcluirClick
      end
    end
    object pnlButtonsInferior: TPanel
      Left = 1
      Top = 473
      Width = 878
      Height = 30
      Align = alTop
      TabOrder = 4
      object btnCancelar: TButton
        Left = 1
        Top = 1
        Width = 75
        Height = 28
        Align = alLeft
        Caption = '&Cancelar'
        TabOrder = 0
        OnClick = btnCancelarClick
      end
      object btSalvar: TButton
        Left = 802
        Top = 1
        Width = 75
        Height = 28
        Align = alRight
        Caption = '&Salvar'
        TabOrder = 1
        OnClick = btSalvarClick
      end
    end
  end
  object FDMemTable: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 144
    Top = 112
    object FDMemTableCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object FDMemTableNOME: TStringField
      FieldName = 'NOME'
      Size = 40
    end
    object FDMemTableENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 80
    end
    object FDMemTableCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Size = 50
    end
    object FDMemTableBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 40
    end
    object FDMemTableCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 40
    end
    object FDMemTableUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object FDMemTableCODIBGE: TStringField
      FieldName = 'CODIBGE'
      Size = 10
    end
    object FDMemTableNRO: TStringField
      FieldName = 'NRO'
      Size = 10
    end
    object FDMemTableCEP: TStringField
      FieldName = 'CEP'
      Size = 10
    end
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable
    Left = 232
    Top = 112
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'https://viacep.com.br/ws'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 664
    Top = 11
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 744
    Top = 13
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'text/html'
    Left = 824
    Top = 14
  end
end
