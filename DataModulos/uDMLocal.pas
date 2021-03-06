unit uDMLocal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmTemplate, FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, FMX.Effects,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,System.IOUtils,FMX.Edit,System.MaskUtils, UntLib,System.Json,IniFiles, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TDMLocal = class(TDataModule)
    ConexLocal: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    QryMusicas: TFDQuery;
    QryMusicaswrapperType: TStringField;
    QryMusicaskind: TStringField;
    QryMusicasartistId: TIntegerField;
    QryMusicascollectionId: TFloatField;
    QryMusicastrackId: TFloatField;
    QryMusicasartistName: TStringField;
    QryMusicascollectionName: TStringField;
    QryMusicastrackName: TStringField;
    QryMusicascollectionCensoredName: TStringField;
    QryMusicastrackCensoredName: TStringField;
    QryMusicasartistViewUrl: TStringField;
    QryMusicascollectionViewUrl: TStringField;
    QryMusicastrackViewUrl: TStringField;
    QryMusicasNOTA: TIntegerField;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    QryAux: TFDQuery;
    procedure ConexLocalBeforeConnect(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure MaskText(const AEdit :TEdit ; const Mask:string);
    function  LimpaString(sString, sSujeiras : String) : String;

    // Ligado a montagem do Frame
    procedure SetFrameClone(ARectBase : TRectangle; var AClone: TRectangle; AScroll:TVertScrollBox;
     var APosition : Single; MClick:TNotifyEvent; MTap:TTapEvent;Tipo:string);overload;
    procedure LimparLista(Sender :TObject;AVertScroll : TVertScrollBox; ARectBase:String);

    //Buscas Realizadas no Banco Local
     procedure AlimentaAPI;

     function  ExisteMusica(Artista,Musica:String):Boolean;
     procedure MontaLista(Campo,Filtro:string);
     procedure GravaAvaliacao(ID:integer);


  end;

var
  DMLocal: TDMLocal;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses  uFrmMain,System.StrUtils, System.NetEncoding,
  System.JSON.Types,
  System.JSON.Writers, uDmRest, AnonThread, Constantes;

{$R *.dfm}

{ TDMLocal }

procedure TDMLocal.AlimentaApi;
var ini :TIniFile;
begin
  {$IFDEF ANDROID}
  ini := TIniFile.Create (GetHomePath + PathDelim + 'config.ini');
  C_BASEURL := ini.ReadString('API','caminho','');
  ini.DisposeOf;
  {$ELSE}
   C_BASEURL :='https://itunes.apple.com/search?';
  {$ENDIF}
end;



procedure TDMLocal.ConexLocalBeforeConnect(Sender: TObject);
var caminho : string;
begin
  {$IFDEF MSWINDOWS}
   ConexLocal.Params.values['OpenMode'] := 'ReadWrite';
   caminho := ExtractFilePath(GetCurrentDir)+'AppItunes\Database\itunes.db';
   ConexLocal.Params.values['Database'] := caminho;
  {$ELSE}
   ConexLocal.Params.values['OpenMode'] := 'ReadWrite';
   ConexLocal.Params.values['Database'] := TPath.Combine(TPath.GetDocumentsPath,'itunes.db');
  {$ENDIF}
end;

function TDMLocal.ExisteMusica(Artista, Musica:string): Boolean;
begin
  QryMusicas.Active := false;
  QryMusicas.SQL.Clear;
  QryMusicas.SQL.Add('SELECT * FROM TBL_MUSICAS');
  QryMusicas.SQL.Add('WHERE artistName=:Art AND trackName=:Tra');
  QryMusicas.ParamByName('Art').AsString := Artista;
  QryMusicas.ParamByName('Tra').AsString := Musica;

  QryMusicas.Active := true;

  if QryMusicas.IsEmpty then
  result := false else
  result := true;

end;

procedure TDMLocal.GravaAvaliacao(ID: integer);
begin
  QryAux.Active := false;
  QryAux.SQL.Clear;
  QryAux.SQL.Add('Update TBL_MUSICAS');
  QryAux.SQL.Add('set NOTA=:NOT');
  QryAux.SQL.Add('Where trackId=:Id');
  QryAux.ParamByName('id').AsInteger := ID;
  QryAux.ParamByName('Not').AsInteger := FrmMain.Nota;
  QryAux.ExecSQL;
  QryAux.Active := false;
end;

procedure TDMLocal.LimparLista(Sender: TObject; AVertScroll: TVertScrollBox;
  ARectBase: String);
  var
   I      : integer;
   IFrame : TRectangle;
begin
  AVertScroll.BeginUpdate;
  for I := Pred(AVertScroll.Content.ChildrenCount) downto 0 do
  Begin
   if (AVertScroll.Content.Children[I] is TRectangle) then
    Begin
     if not (TRectangle(AVertScroll.Content.Children[I]).Name = ARectBase)  then
     Begin
      IFrame := AVertScroll.Content.Children[I] as TRectangle;
      IFrame.DisposeOf;
      IFrame := nil;
     End;
    End;

  End;
  AVertScroll.EndUpdate;


end;



function TDMLocal.LimpaString(sString, sSujeiras: String): String;
var sStrLimpa   : String;
    iTamanho    : Integer;
begin
   sStrLimpa    := '';

   for iTamanho := 1 to Length(sString) do
      if Pos(Copy(sString, iTamanho, 1), sSujeiras) <= 0 then
         sStrLimpa  := sStrLimpa + Copy(sString, iTamanho, 1);

   Result       := sStrLimpa;
end;


procedure TDMLocal.MaskText(const AEdit: TEdit; const Mask: string);
var LAux :string;
begin
 if AEdit.MaxLength <> Mask.Length then
  AEdit.MaxLength := Mask.Length;

  LAux := AEdit.Text.Replace('.','',[rfReplaceAll]);
  LAux := LAux.Replace('-','',[rfReplaceAll]);
  LAux := LAux.Replace('(','',[rfReplaceAll]);
  LAux := LAux.Replace(')','',[rfReplaceAll]);
  LAux := LAux.Replace('/','',[rfReplaceAll]);
  LAux := FormatMaskText(Mask+';0;_',LAux).Trim;

  for var I :Integer := Laux.Length-1 downto 0 do
  if not CharInSet(Laux.Chars[I], ['0'..'9']) then
   Delete(LAux, I+1,1)
   else
   break;

  TEdit(AEdit).Text:= LAux;
  TEdit(AEdit).GoToTextEnd;
end;



procedure TDMLocal.MontaLista(Campo,Filtro:String);
begin
  QryMusicas.Active := false;

  QryMusicas.SQL.Clear;
  QryMusicas.SQL.Add('SELECT * FROM TBL_MUSICAS');


  if (Campo<>'') and (Filtro<>'')  then
  Begin
   QryMusicas.SQL.Add('WHERE '+CAMPO+' Like ''%'+FILTRO+'%''');
  End;


  QryMusicas.SQL.Add('ORDER BY artistId,collectionId');

  QryMusicas.Active := true;
end;

procedure TDMLocal.SetFrameClone(ARectBase: TRectangle; var AClone: TRectangle;
  AScroll: TVertScrollBox; var APosition: Single; MClick:TNotifyEvent; MTap:TTapEvent;Tipo:string);
begin
  AClone                 := TRectangle(ARectBase.Clone(AScroll));
  AClone.Parent          := AScroll;
  AClone.Name            := Tipo + ARectBase.Tag.ToString;
  AClone.Position.Y      := APosition;
  AClone.Position.X      := 4;
  AClone.Height          := ARectBase.Height;
  {$IFDEF MSWINDOWS}
   AClone.Width          := AScroll.Width - 24;
  {$ELSE}
   AClone.Width          := AScroll.Width - 8;
  {$ENDIF}
  ARectBase.Opacity      := 1;
  AClone.Visible         := True;
  APosition              := APosition + ARectBase.Height + 4;
  AClone.OnClick         := MClick;
  AClone.OnTap           := MTap;
end;





end.
