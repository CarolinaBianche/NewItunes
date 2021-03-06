object DMLocal: TDMLocal
  OldCreateOrder = False
  Height = 395
  Width = 620
  object ConexLocal: TFDConnection
    Params.Strings = (
      'Database=C:\Runtec\AppItunes\Database\itunes.db'
      'DriverID=SQLite')
    LoginPrompt = False
    BeforeConnect = ConexLocalBeforeConnect
    Left = 40
    Top = 16
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 144
    Top = 16
  end
  object QryMusicas: TFDQuery
    Connection = ConexLocal
    SQL.Strings = (
      'Select * from TBL_MUSICAS')
    Left = 40
    Top = 80
    object QryMusicaswrapperType: TStringField
      FieldName = 'wrapperType'
      Origin = 'wrapperType'
    end
    object QryMusicaskind: TStringField
      FieldName = 'kind'
      Origin = 'kind'
    end
    object QryMusicasartistId: TIntegerField
      FieldName = 'artistId'
      Origin = 'artistId'
    end
    object QryMusicascollectionId: TFloatField
      FieldName = 'collectionId'
      Origin = 'collectionId'
    end
    object QryMusicastrackId: TFloatField
      FieldName = 'trackId'
      Origin = 'trackId'
    end
    object QryMusicasartistName: TStringField
      FieldName = 'artistName'
      Origin = 'artistName'
      Size = 100
    end
    object QryMusicascollectionName: TStringField
      FieldName = 'collectionName'
      Origin = 'collectionName'
      Size = 100
    end
    object QryMusicastrackName: TStringField
      FieldName = 'trackName'
      Origin = 'trackName'
      Size = 100
    end
    object QryMusicascollectionCensoredName: TStringField
      FieldName = 'collectionCensoredName'
      Origin = 'collectionCensoredName'
      Size = 100
    end
    object QryMusicastrackCensoredName: TStringField
      FieldName = 'trackCensoredName'
      Origin = 'trackCensoredName'
      Size = 100
    end
    object QryMusicasartistViewUrl: TStringField
      FieldName = 'artistViewUrl'
      Origin = 'artistViewUrl'
      Size = 200
    end
    object QryMusicascollectionViewUrl: TStringField
      FieldName = 'collectionViewUrl'
      Origin = 'collectionViewUrl'
      Size = 200
    end
    object QryMusicastrackViewUrl: TStringField
      FieldName = 'trackViewUrl'
      Origin = 'trackViewUrl'
      Size = 200
    end
    object QryMusicasNOTA: TIntegerField
      FieldName = 'NOTA'
      Origin = 'NOTA'
    end
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 144
    Top = 96
  end
  object QryAux: TFDQuery
    Connection = ConexLocal
    Left = 32
    Top = 152
  end
end
