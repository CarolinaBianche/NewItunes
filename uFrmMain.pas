unit uFrmMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Layouts, FMX.Objects, FMX.Effects, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, UntLib, System.Actions, FMX.ActnList,
  FMX.DialogService, uLoading, Notificacao,
  System.Sensors, System.Permissions
  , System.Sensors.Components,FMX.VirtualKeyboard,FMX.Platform;

type
  TFrmMain = class(TForm)
    lytMain: TLayout;
    tbcMain: TTabControl;
    tbiLogin: TTabItem;
    tbiMain: TTabItem;
    lytNavegacao: TLayout;
    lytLogin: TLayout;
    rect_fundo_login: TRectangle;
    Image5: TImage;
    Rectangle3: TRectangle;
    lytBoxLogin: TLayout;
    tbiPrincipal: TTabItem;
    Image1: TImage;
    Rectangle1: TRectangle;
    lytPrincipal: TLayout;
    lytBoxMenu: TLayout;
    rect_fundo: TRectangle;
    lblVersao: TLabel;
    lytPerfil: TLayout;
    lblMenuMotorista: TLabel;
    lblMenudata: TLabel;
    lyt_botoes: TLayout;
    lytFoto: TLayout;
    cirFoto: TCircle;
    rectFundoBranco: TRectangle;
    lytLoginCentral: TLayout;
    btn_login: TRectangle;
    lbl_acessar: TLabel;
    ShadowEffect1: TShadowEffect;
    lyt_rodape: TLayout;
    Image4: TImage;
    actList: TActionList;
    chgTabAct: TChangeTabAction;
    lblMensagem: TLabel;
    StyleBook1: TStyleBook;
    lblTituloInicio: TLabel;
    ShadowEffect2: TShadowEffect;
    rect_desconectar: TRectangle;
    Label4: TLabel;
    rect_buscar: TRectangle;
    lbl_artista: TLabel;
    VertScrollBox1: TVertScrollBox;
    Image2: TImage;
    ShadowEffect3: TShadowEffect;
    ShadowEffect4: TShadowEffect;
    Rectangle2: TRectangle;
    Label1: TLabel;
    ShadowEffect5: TShadowEffect;
    procedure FormCreate(Sender: TObject);
    procedure FormSaveState(Sender: TObject);
    procedure LocalizadorLocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure FormShow(Sender: TObject);
    procedure EdtCpfCanFocus(Sender: TObject; var ACanFocus: Boolean);
    procedure Rectangle10Click(Sender: TObject);
    procedure rect_desconectarClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure rect_buscarClick(Sender: TObject);
    procedure btn_loginClick(Sender: TObject);
    procedure Rectangle2Click(Sender: TObject);
  private
    { Private declarations }



  public
    { Public declarations }
     Campo,Filtro:string;
     IdMusica, Nota :integer;




    procedure MensagemTost(sMensagem: String);
    function  VerificaPermissaoCamera:Boolean;

  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.fmx}

uses System.IOUtils, uDMLocal, uDmRest, uFrmListaMusicas;



procedure TFrmMain.btn_loginClick(Sender: TObject);
begin
  TLibery.MudarAba(tbiPrincipal,Sender);
end;

procedure TFrmMain.EdtCpfCanFocus(Sender: TObject; var ACanFocus: Boolean);
var
  FService: IFMXVirtualKeyboardService;
begin

end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  tbcMain.TabPosition:= TTabPosition.None;
  tbcMain.ActiveTab  := tbiLogin;

  TLibery.ActiveForm := nil;
  TLibery.LayoutMain := lytNavegacao;
  TLibery.ActionMenu := actList;
  TLibery.ActMudarAba := chgTabAct;


end;

procedure TFrmMain.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
 {$IFDEF ANDROID}
var
   FService  : IFMXVirtualKeyboardService;
   Formulario:string;
 {$ENDIF ANDROID}
begin
  {$IFDEF ANDROID}

       if (Key = vkHardwareBack) then
       begin
           TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));

           if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyboardState) then
           begin
               // Botao Back pressionado apenas fecha
           end else
           begin
               if tbcMain.ActiveTab = tbiLogin then
               begin
                   Key := 0;
                   tbcMain.ActiveTab := tbiLogin;
               end;

          end;
        end;

  {$ENDIF ANDROID}

end;

procedure TFrmMain.FormSaveState(Sender: TObject);
 var
  Dados: TBinaryWriter;
begin
 { SaveState.Stream.Clear;
  Dados := TBinaryWriter.Create(SaveState.Stream);
  try
    Dados.Write(edtCpf.Text);
  finally
    Dados.Free;
  end;}
end;

procedure TFrmMain.FormShow(Sender: TObject);
var retorno:string;
begin
   lblMenudata.Text := DateToStr(Date);
end;



procedure TFrmMain.LocalizadorLocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
Var
 NLocalizacao : TLocationCoord2D;
begin

end;


procedure TFrmMain.rect_buscarClick(Sender: TObject);
begin
  FrmMain.lytNavegacao.Controls.Clear;
  TLibery.ActiveForm.DisposeOf;
  TLibery.ActiveForm:=nil;
  TLibery.OpenForm(TFrmListaMusicas,FrmMain.lytNavegacao);
  TLibery.MudarAba(FrmMain.tbiMain,Sender);

end;

function TFrmMain.VerificaPermissaoCamera :Boolean;
begin

  Result := True;
end;


procedure TFrmMain.MensagemTost(sMensagem: String);
begin
  TThread.CreateAnonymousThread(
    procedure
    begin
      // sleep(3000); // Acesso ao banco... acesso WS...

      TThread.Synchronize(nil,
        procedure
        begin
          TLoading.Hide;

          TMensagem.ToastMessage(frmMain, sMensagem, TAlignLayout.Top);

        end);

    end).Start;
end;


procedure TFrmMain.Rectangle10Click(Sender: TObject);
begin
  TLibery.MudarAba(tbiPrincipal,Sender);
end;

procedure TFrmMain.Rectangle2Click(Sender: TObject);
begin
 Application.Terminate;
end;

procedure TFrmMain.rect_desconectarClick(Sender: TObject);
begin
  TLibery.MudarAba(tbiLogin,Sender);
end;

end.
