unit uFrmInformativo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmTemplate, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, Notificacao, uDMLocal, uDmRest, uLoading,FMX.DialogService,
  UntLib, FMX.Edit, System.Sensors.Components,FMX.VirtualKeyboard,FMX.Platform,
  FMX.ScrollBox, FMX.Memo, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Effects, FMX.WebBrowser,Winapi.ShellAPI;

type
  TFrmInformativo = class(TFrmTemplate)
    lblAlbum: TLabel;
    lblMusica: TLabel;
    Layout4: TLayout;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    lblArtista: TLabel;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout5: TLayout;
    Label5: TLabel;
    Layout6: TLayout;
    Layout7: TLayout;
    Layout8: TLayout;
    Label6: TLabel;
    Layout9: TLayout;
    Layout10: TLayout;
    Layout11: TLayout;
    Label7: TLabel;
    rect_sel_avaliacao: TRectangle;
    Layout12: TLayout;
    NotaQuatro: TRadioButton;
    Image3: TImage;
    Layout13: TLayout;
    NotaUM: TRadioButton;
    Image4: TImage;
    Layout14: TLayout;
    NotaTres: TRadioButton;
    Image5: TImage;
    Layout15: TLayout;
    NotaCinco: TRadioButton;
    Image6: TImage;
    Layout16: TLayout;
    NotaZero: TRadioButton;
    Image7: TImage;
    Layout17: TLayout;
    NotaDois: TRadioButton;
    Image8: TImage;
    Layout18: TLayout;
    NotaOito: TRadioButton;
    Image9: TImage;
    Layout19: TLayout;
    NotaSeis: TRadioButton;
    Image10: TImage;
    Layout20: TLayout;
    NotaSete: TRadioButton;
    Image11: TImage;
    Layout21: TLayout;
    NotaNove: TRadioButton;
    Image12: TImage;
    Rectangle5: TRectangle;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure spdBtnFinalClick(Sender: TObject);
    procedure Rectangle3Click(Sender: TObject);
    procedure Rectangle2Click(Sender: TObject);
    procedure Rectangle1Click(Sender: TObject);
    procedure speBtnMenuClick(Sender: TObject);
    procedure Rectangle4Click(Sender: TObject);
    procedure NotaZeroChange(Sender: TObject);
    procedure NotaUMChange(Sender: TObject);
    procedure NotaDoisChange(Sender: TObject);
    procedure NotaTresChange(Sender: TObject);
    procedure NotaQuatroChange(Sender: TObject);
    procedure NotaCincoChange(Sender: TObject);
    procedure NotaSeisChange(Sender: TObject);
    procedure NotaSeteChange(Sender: TObject);
    procedure NotaOitoChange(Sender: TObject);
    procedure NotaNoveChange(Sender: TObject);
    procedure Rectangle5Click(Sender: TObject);
  private
    { Private declarations }

    procedure ZeraVotacao;
    procedure AbreLink(URL:STRING);
    procedure DevolveValorEmb;
    procedure LimpaCampos;
    procedure ListarDados;
  public
    { Public declarations }
    procedure abreEntregas(Sender :TObject);

  end;

var
  FrmInformativo: TFrmInformativo;

implementation

{$R *.fmx}

uses  uFrmMain, uFrmListaMusicas;

procedure TFrmInformativo.abreEntregas(Sender: TObject);
begin
end;

procedure TFrmInformativo.AbreLink(URL: STRING);
begin
  ShellExecute(0,
               'open',
               PWideChar(URL),
               nil,
               nil,
               0);
end;

procedure TFrmInformativo.DevolveValorEmb;
begin
end;

procedure TFrmInformativo.FormCreate(Sender: TObject);
begin
  inherited;


  lbl_titulo.Text       := 'Detalhamento';

  lblInfoTexto.Text     := 'Deixe sua avalia??o...';
  lblArtista.Text       :=  DmLocal.QryMusicasartistName.AsString ;
  lblMusica.Text        :=  DmLocal.QryMusicastrackName.AsString;
  lblAlbum.Text         :=  DmLocal.QryMusicascollectionName.AsString;
  frmMain.IdMusica      :=  DmLocal.QryMusicastrackId.AsInteger;

end;

procedure TFrmInformativo.LimpaCampos;
begin

end;

procedure TFrmInformativo.ListarDados;
var EndComp :String;
begin

end;

procedure TFrmInformativo.NotaCincoChange(Sender: TObject);
begin
   FrmMain.Nota:= 6;
end;

procedure TFrmInformativo.NotaDoisChange(Sender: TObject);
begin
  FrmMain.Nota := 3;
end;

procedure TFrmInformativo.NotaNoveChange(Sender: TObject);
begin
  FrmMain.Nota := 10;
end;

procedure TFrmInformativo.NotaOitoChange(Sender: TObject);
begin
 FrmMain.Nota := 9;
end;

procedure TFrmInformativo.NotaQuatroChange(Sender: TObject);
begin
  FrmMain.Nota := 5;
end;

procedure TFrmInformativo.NotaSeisChange(Sender: TObject);
begin
  FrmMain.Nota := 7;
end;

procedure TFrmInformativo.NotaSeteChange(Sender: TObject);
begin
  FrmMain.Nota := 8;
end;

procedure TFrmInformativo.NotaTresChange(Sender: TObject);
begin
  FrmMain.Nota := 4;
end;

procedure TFrmInformativo.NotaUMChange(Sender: TObject);
begin
  FrmMain.Nota := 2;
end;

procedure TFrmInformativo.NotaZeroChange(Sender: TObject);
begin
  FrmMain.Nota:= 1;
end;

procedure TFrmInformativo.Rectangle1Click(Sender: TObject);
begin
   AbreLink(DmLocal.QryMusicascollectionViewUrl.AsString);
end;

procedure TFrmInformativo.Rectangle2Click(Sender: TObject);
begin

   AbreLink(DmLocal.QryMusicastrackViewUrl.AsString);
end;

procedure TFrmInformativo.Rectangle3Click(Sender: TObject);
begin

  AbreLink(DmLocal.QryMusicasartistViewUrl.AsString);
end;

procedure TFrmInformativo.Rectangle4Click(Sender: TObject);
begin

  if  DmLocal.QryMusicas.Locate('trackId',FrmMain.IdMusica,[]) then
  Begin
   rect_sel_avaliacao.Visible := true;
   //FrmMain.MensagemTost(DmLocal.QryMusicastrackId.AsInteger.ToString);
  End else
  FrmMain.MensagemTost('Op??o Indispon?vel no momento...');


end;

procedure TFrmInformativo.Rectangle5Click(Sender: TObject);
begin

 DmLocal.GravaAvaliacao(FrmMain.IdMusica);
 ZeraVotacao;
 rect_sel_avaliacao.Visible := false;
 FrmMain.MensagemTost('Avalia??o envida com sucesso!!');
end;

procedure TFrmInformativo.SpeedButton2Click(Sender: TObject);
var qtd : double;
    paletes : integer;
begin
  inherited;


end;

procedure TFrmInformativo.ZeraVotacao;
begin
  NotaZero.IsChecked   := false;
  NotaUM.IsChecked     := false;
  NotaDois.IsChecked   := false;
  NotaTres.IsChecked   := false;
  NotaQuatro.IsChecked := false;
  NotaCinco.IsChecked  := false;
  NotaSeis.IsChecked   := false;
  NotaSete.IsChecked   := false;
  NotaOito.IsChecked   := false;
  NotaNove.IsChecked   := false;
end;

procedure TFrmInformativo.spdBtnFinalClick(Sender: TObject);
var TotPL,APTO :integer;
 QdtRatItens,QtdRatEmbalagens,QtdRatPaletes:integer ;
begin
  inherited;

end;

procedure TFrmInformativo.speBtnMenuClick(Sender: TObject);
begin
  inherited;
  FrmMain.lytNavegacao.Controls.Clear;
  TLibery.ActiveForm.DisposeOf;
  TLibery.ActiveForm:=nil;
  TLibery.OpenForm(TFrmListaMusicas,FrmMain.lytNavegacao);
  TLibery.MudarAba(FrmMain.tbiMain,Sender);
end;

end.
