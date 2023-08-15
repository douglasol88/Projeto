object frmCadProdutosView: TfrmCadProdutosView
  Left = 0
  Top = 0
  Caption = 'Cadastro de Produtos'
  ClientHeight = 509
  ClientWidth = 764
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
    Width = 764
    Height = 509
    Align = alClient
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 0
      Top = 233
      Width = 637
      Height = 121
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'CODIGO'
          Title.Caption = 'C'#243'digo:'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Title.Caption = 'Descri'#231#227'o:'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRECO'
          Title.Caption = 'Pre'#231'o:'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ESTOQUE'
          Title.Caption = 'Estoque:'
          Visible = True
        end>
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 57
      Width = 762
      Height = 112
      Align = alTop
      TabOrder = 1
      object Label1: TLabel
        Left = 5
        Top = 4
        Width = 37
        Height = 13
        Caption = 'C'#243'digo:'
      end
      object Label3: TLabel
        Left = 5
        Top = 50
        Width = 31
        Height = 13
        Caption = 'Pre'#231'o:'
      end
      object Label2: TLabel
        Left = 160
        Top = 4
        Width = 50
        Height = 13
        Caption = 'Descri'#231#227'o:'
      end
      object edtCodigo: TEdit
        Left = 5
        Top = 20
        Width = 132
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
      end
      object edtPreco: TEdit
        Left = 5
        Top = 67
        Width = 121
        Height = 21
        TabOrder = 1
      end
      object edtDescricao: TEdit
        Left = 160
        Top = 20
        Width = 297
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 2
      end
      object GroupBox2: TGroupBox
        Left = 160
        Top = 46
        Width = 153
        Height = 55
        Caption = 'Estoque'
        TabOrder = 3
        object edtEstoque: TEdit
          Left = 16
          Top = 20
          Width = 121
          Height = 21
          TabOrder = 0
        end
      end
      object btSalvar: TButton
        Left = 382
        Top = 64
        Width = 75
        Height = 25
        Caption = 'Salvar'
        TabOrder = 4
        OnClick = btSalvarClick
      end
    end
    object GroupBox3: TGroupBox
      Left = 1
      Top = 1
      Width = 762
      Height = 56
      Align = alTop
      Caption = 'Pesquisar'
      TabOrder = 2
      object sbtPesquisar: TSpeedButton
        Left = 543
        Top = 16
        Width = 25
        Height = 25
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000020000000E0B14308329448DFB1D2F58A5000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000020000000E0D1937883C6DB2FF5BB1F9FF325196F4000000000000
          00000000000100000004000000090000000D0000000F0000000F0000000C0000
          00070000000E0F1D3C864A7CBCFF73C4FFFF467CC3FF17254485000000000000
          0002000000081C130F465A3B31BC7C5043F87F5244FF7B4E42FA57382FC11E14
          1059112142875686C2FF88D0FFFF5186C7FF142343880000000F000000010302
          02104A332C91946B5DFDC6ACA1FFE4D1C6FFEDDDD2FFE2D0C5FFC0A599FF855C
          50FF6E6B7EFF98D4F8FF5B8ECBFF152545840000000D00000002000000076046
          3DA6B39288FFE9DAD0FFDAC0A1FFCBA87AFFC49B66FFCCAA7EFFDCC2A5FFE5D2
          C6FF9A766AFF736A77FF162747850000000E00000002000000002A201D4AAE88
          7CFFEFE6DFFFCDA67CFFCDA26BFFE3C28CFFEDD5A2FFE7CD9EFFD3B182FFD0AE
          88FFE7D5CAFF885F53FF25181464000000070000000000000000755B53ACDFCE
          C9FFDDC1A8FFC99865FFE8BE83FFE9C388FFEDCA97FFEFD3A7FFF2D9B0FFD5B1
          87FFDBBEA6FFC5ACA2FF5A3D33C10000000C0000000000000000A9877CE9F8F4
          F2FFC79873FFDEAB77FFEFCDABFFF0D0B1FFEDC9A1FFECC69AFFEFCFA9FFE9C9
          A4FFC89B77FFE6D6CEFF7C5448F10000000F0000000000000000C09C90FFFDFD
          FCFFBE875FFFEDCFB9FFF5DFD2FFF2D6C1FFF1CFB4FFEDC6A4FFECC19BFFEFC8
          A6FFC08B67FFF1E6DFFF8B6154FF0000000F0000000000000000AF9186E6F9F5
          F4FFC69474FFE8CDC3FFF9E8E4FFF6DED2FFF3D4C2FFF0CBB2FFEBB78EFFE5B7
          92FFC59172FFEBDFD9FF866055EE0000000D0000000000000000876F68B0E7D9
          D4FFE2C6B7FFC89072FFFAEFF2FFF9E7E4FFF6DDD3FFF1C8B2FFEBAF88FFC98E
          6CFFDCBBAAFFD3C0B7FF6B4F46BC00000009000000000000000026201E36CCAF
          A7FAFBF8F7FFCF9F88FFC78E72FFE9CDC6FFEDC7B5FFDD9F79FFC88865FFCE9D
          84FFF5EFEBFFB39387FF2A201D52000000040000000000000000000000036454
          4F84D9C2BAFFFDFBFAFFE2C6B8FFCB977EFFC08163FFCB977DFFE0C4B4FFFAF6
          F5FFC9B0A7FF6B564EA700000009000000010000000000000000000000000202
          020762534D81CEB2A9FAEADDD8FFF9F5F4FFFFFFFFFFF9F5F4FFE9DCD7FFC8AC
          A2FC62504B900404031000000002000000000000000000000000000000000000
          000000000003241F1D3486726BADB69B91E6CCADA1FFB99C92E988736CB22822
          1F3E000000060000000100000000000000000000000000000000}
        OnClick = sbtPesquisarClick
      end
      object edtPesquisa: TEdit
        Left = 201
        Top = 19
        Width = 337
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
        OnChange = edtPesquisaChange
        OnKeyPress = edtPesquisaKeyPress
      end
      object rbtCodigo: TRadioButton
        Left = 13
        Top = 21
        Width = 84
        Height = 17
        Caption = 'Por C'#243'digo'
        TabOrder = 1
        OnClick = rbtCodigoClick
      end
      object rbtDescricao: TRadioButton
        Left = 103
        Top = 22
        Width = 92
        Height = 17
        Caption = 'Por Descri'#231#227'o'
        TabOrder = 2
        OnClick = rbtDescricaoClick
      end
    end
  end
  object FDMemTable1: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 2147483647
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 224
    Top = 288
    object FDMemTable1ID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object FDMemTable1CODIGO: TStringField
      FieldName = 'CODIGO'
      Required = True
      Size = 15
    end
    object FDMemTable1DESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 40
    end
    object FDMemTable1PRECO: TBCDField
      FieldName = 'PRECO'
      DisplayFormat = '#,##0.00'
      Precision = 18
      Size = 2
    end
    object FDMemTable1ESTOQUE: TSingleField
      FieldName = 'ESTOQUE'
      DisplayFormat = '#,####0.0000'
    end
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 296
    Top = 290
  end
end
