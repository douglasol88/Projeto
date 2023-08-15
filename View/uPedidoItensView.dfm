object frmPedidoVenda: TfrmPedidoVenda
  Left = 0
  Top = 0
  Caption = 'Pedido de Venda'
  ClientHeight = 438
  ClientWidth = 726
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 726
    Height = 438
    Align = alClient
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 724
      Height = 96
      Align = alTop
      TabOrder = 0
      object Label3: TLabel
        Left = 161
        Top = 50
        Width = 37
        Height = 13
        Caption = 'Cliente:'
      end
      object edtBuscaCliente: TEdit
        Left = 159
        Top = 66
        Width = 306
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
        OnKeyUp = edtBuscaClienteKeyUp
      end
      object btIncluir: TButton
        Left = 3
        Top = 3
        Width = 75
        Height = 25
        Caption = '&Novo'
        TabOrder = 1
        OnClick = btIncluirClick
      end
      object GroupBox2: TGroupBox
        Left = 4
        Top = 34
        Width = 149
        Height = 55
        Caption = 'N'#250'mero do Pedido'
        TabOrder = 2
        object lblNroPedido: TLabel
          Left = 11
          Top = 23
          Width = 98
          Height = 18
          Caption = 'lblNroPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object btnBuscaCliente: TBitBtn
        Left = 466
        Top = 65
        Width = 27
        Height = 23
        Caption = '...'
        TabOrder = 3
      end
      object edtIdCli: TEdit
        Left = 499
        Top = 65
        Width = 33
        Height = 21
        TabOrder = 4
        Visible = False
      end
    end
    object GroupBox3: TGroupBox
      Left = 1
      Top = 97
      Width = 724
      Height = 344
      Align = alTop
      TabOrder = 1
      object Label4: TLabel
        Left = 5
        Top = 8
        Width = 78
        Height = 13
        Caption = 'C'#243'digo Produto:'
      end
      object Label1: TLabel
        Left = 159
        Top = 8
        Width = 50
        Height = 13
        Caption = 'Descri'#231#227'o:'
      end
      object Label2: TLabel
        Left = 407
        Top = 8
        Width = 71
        Height = 13
        Caption = 'Pre'#231'o Unit'#225'rio:'
      end
      object Label5: TLabel
        Left = 502
        Top = 8
        Width = 60
        Height = 13
        Caption = 'Quantidade:'
      end
      object Label7: TLabel
        Left = 594
        Top = 8
        Width = 32
        Height = 13
        Caption = 'Total:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtBuscaCodProduto: TEdit
        Left = 4
        Top = 23
        Width = 109
        Height = 21
        TabOrder = 0
        OnKeyPress = edtBuscaCodProdutoKeyPress
        OnKeyUp = edtBuscaCodProdutoKeyUp
      end
      object edtDescrProduto: TEdit
        Left = 157
        Top = 23
        Width = 242
        Height = 21
        ReadOnly = True
        TabOrder = 1
      end
      object edtValorUnit: TEdit
        Left = 406
        Top = 23
        Width = 87
        Height = 21
        TabOrder = 2
        OnChange = edtValorUnitChange
        OnExit = edtValorUnitExit
        OnKeyPress = edtValorUnitKeyPress
      end
      object edtQtde: TEdit
        Left = 499
        Top = 23
        Width = 86
        Height = 21
        TabOrder = 3
        OnChange = edtQtdeChange
        OnExit = edtQtdeExit
        OnKeyPress = edtQtdeKeyPress
      end
      object DBGrid1: TDBGrid
        Left = 3
        Top = 79
        Width = 709
        Height = 183
        DataSource = DataSource1
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 4
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'PRODUTO'
            Title.Caption = 'Produto:'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Title.Caption = 'Descri'#231#227'o:'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UNITARIO'
            Title.Caption = 'Pre'#231'o Unit.:'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'QUANTIDADE'
            Title.Caption = 'Quantidade:'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TOTAL'
            Title.Caption = 'Total:'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'Tahoma'
            Title.Font.Style = [fsBold]
            Visible = True
          end>
      end
      object GroupBox4: TGroupBox
        Left = 3
        Top = 276
        Width = 158
        Height = 50
        Caption = 'SubTotal:'
        TabOrder = 5
        object lblSubTotal: TLabel
          Left = 68
          Top = 21
          Width = 35
          Height = 18
          Alignment = taRightJustify
          Caption = '0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object btnBuscaProduto: TBitBtn
        Left = 117
        Top = 21
        Width = 34
        Height = 25
        Caption = '...'
        TabOrder = 6
      end
      object btnCancelar: TButton
        Left = 565
        Top = 288
        Width = 75
        Height = 25
        Caption = '&Cancelar'
        TabOrder = 7
      end
      object btSalvar: TButton
        Left = 646
        Top = 288
        Width = 75
        Height = 25
        Caption = '&Salvar'
        TabOrder = 8
        OnClick = btSalvarClick
      end
      object edtTotalizador: TEdit
        Left = 591
        Top = 23
        Width = 121
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 9
      end
      object btnIncluir: TBitBtn
        Left = 637
        Top = 48
        Width = 75
        Height = 25
        Caption = '&Incluir'
        TabOrder = 10
        OnClick = btnIncluirClick
      end
    end
  end
  object FDMemClientes: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 584
    Top = 48
  end
  object FDMemProdutos: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 668
    Top = 49
  end
  object DataSource1: TDataSource
    DataSet = FDMemItensPedido
    Left = 633
    Top = 257
  end
  object FDMemItensPedido: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 489
    Top = 265
    object FDMemItensPedidoIDPEDIDO: TIntegerField
      FieldName = 'IDPEDIDO'
    end
    object FDMemItensPedidoCODCLIENTE: TIntegerField
      FieldName = 'CODCLIENTE'
    end
    object FDMemItensPedidoNOME: TStringField
      FieldName = 'NOME'
      Size = 40
    end
    object FDMemItensPedidoSUBTOTAL: TCurrencyField
      FieldName = 'SUBTOTAL'
    end
    object FDMemItensPedidoIDPEDITENS: TIntegerField
      FieldName = 'IDPEDITENS'
    end
    object FDMemItensPedidoPRODUTO: TStringField
      FieldName = 'PRODUTO'
      Size = 15
    end
    object FDMemItensPedidoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 40
    end
    object FDMemItensPedidoUNITARIO: TCurrencyField
      FieldName = 'UNITARIO'
    end
    object FDMemItensPedidoQUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
    end
    object FDMemItensPedidoTOTALITEM: TCurrencyField
      FieldName = 'TOTALITEM'
    end
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 345
    Top = 265
  end
end
