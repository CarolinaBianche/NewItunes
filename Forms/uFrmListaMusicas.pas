unit uFrmListaMusicas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmTemplate, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.Edit,
  FMX.ListBox;

type
  TFrmListaMusicas = class(TFrmTemplate)
    rctCard: TRectangle;
    lytEsqCard: TLayout;
    img_pendente: TImage;
    LinTop: TLine;
    LinRod: TLine;
    lytBoxCard: TLayout;
    lytTopCard: TLayout;
    lytNomeMusica: TLayout;
    lblRecebeMusica: TLabel;
    lblNomeMusica: TLabel;
    lytRodCard: TLayout;
    lblAlbum: TLabel;
    lblNomeAlbum: TLabel;
    lytCliente: TLayout;
    lytImgVisualizar: TLayout;
    Label2: TLabel;
    imgVisualizar: TImage;
    imgVisu: TImage;
    lblNomeArtista: TLabel;
    lblArtista: TLabel;
    rctFiltroEd: TRectangle;
    lytDireita: TLayout;
    btnLimparFiltro: TSpeedButton;
    Rectangle2: TRectangle;
    btnFecharFiltro: TSpeedButton;
    lytClient: TLayout;
    Label5: TLabel;
    lbl_nota: TLabel;
    lyt_login: TLayout;
    rec_login: TRectangle;
    edt_busca: TEdit;
    Image2: TImage;
    rect_titulo_lista: TRectangle;
    Label3: TLabel;
    Image3: TImage;
    Rectangle1: TRectangle;
    SpeedButton1: TSpeedButton;
    edt_busca_musica: TEdit;
    RadioButton1: TRadioButton;
    Layout1: TLayout;
    RadioButton2: TRadioButton;
    Lay: TLayout;
    Layout2: TLayout;
    procedure FormCreate(Sender: TObject);
    procedure speBtnMenuClick(Sender: TObject);
    procedure speBtnAtualizarClick(Sender: TObject);
    procedure btnPesquisaFiltroClick(Sender: TObject);
    procedure btnFecharFiltroClick(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure btnLimparFiltroClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
  private
    { Private declarations }
    procedure CarregaMusicas(Sender:TObject);
    procedure OnSelecionarPedido(Sender :TObject);
    procedure ValidaFiltro;
  public
    { Public declarations }

  end;

var
  FrmListaMusicas: TFrmListaMusicas;

implementation

{$R *.fmx}

uses  uDMLocal, uDmRest, uFrmMain, uLoading, UntLib, uFrmInformativo;

procedure TFrmListaMusicas.btnFecharFiltroClick(Sender: TObject);
begin
  inherited;
  edt_busca_musica.Text:='';
  rctFiltroEd.Visible:=false;
  if vertLista.Margins.Top >190 then
  vertLista.Margins.Top := vertLista.Margins.Top -168 else
  vertLista.Margins.Top := 190;
end;

procedure TFrmListaMusicas.btnLimparFiltroClick(Sender: TObject);
begin
  inherited;
 edt_busca_musica.Text := EmptyStr;
 RadioButton1.IsChecked := false;
 RadioButton2.IsChecked := false;
 ValidaFiltro;
 CarregaMusicas(sender);
 btnFecharFiltro.OnClick(Sender);
end;

procedure TFrmListaMusicas.btnPesquisaFiltroClick(Sender: TObject);
begin
  inherited;
   self.CarregaMusicas(Sender);
   self.btnFecharFiltro.OnClick(Sender);
end;

procedure TFrmListaMusicas.CarregaMusicas(Sender: TObject);
begin
TLibery.CustomThread(
    procedure()
    Begin
    //Processo de Inicio
      TThread.Synchronize(
       TThread.CurrentThread,
        procedure()
        Begin
          TLoading.Show(FrmMain,'Carregando Músicas ...');
          vertLista.Visible:=false;
          vertLista.BeginUpdate;
          DmLocal.LimparLista(Self,vertLista,rctCard.Name);
          DMLocal.QryMusicas.DisableControls;
        End

      );
    End,
    procedure()
    var
     LFrame   : TRectangle;
     LPosicao : Single;
     Qtd      : Integer;
    Begin
    //Processo Principal
      DMLocal.MontaLista(FrmMain.Campo,FrmMain.Filtro);
      DmLocal.QryMusicas.First;

      rctCard.Visible  := false;
      LPosicao         := 8;



      while not DMLocal.QryMusicas.Eof do
      Begin

        //Povoando os Cards
        lblNomeArtista.Text      := Copy(DmLocal.QryMusicasartistName.Value,1,50);

        rctCard.Tag              := DmLocal.QryMusicastrackId.AsInteger;

        lblRecebeMusica.Text     := Copy(DmLocal.QryMusicastrackName.asstring,1,50);
        lblAlbum.Text            := Copy(DmLocal.QryMusicascollectionName.AsString,1,50);

        img_pendente.Bitmap :=  imgVisu.Bitmap;

       //Clonando
        DmLocal.SetFrameClone(rctCard,LFrame,vertLista,LPosicao,OnSelecionarPedido,nil,'Mus');
        DMLocal.QryMusicas.Next;
      End;
    End,
    procedure()
    Begin
     //Processo Completo
      TLoading.Hide;
      VertLista.EndUpdate;
      VertLista.ScrollTo(0,0);
      VertLista.Visible := true;
      DmLocal.QryMusicas.EnableControls;
    End,
    procedure(const AException :string)
    Begin
      TLoading.Hide;
      FrmMain.MensagemTost('Erro no processamento da thread Carregar Itens Pedido! ' +
      AException);

    End,
    True
  );

end;

procedure TFrmListaMusicas.FormCreate(Sender: TObject);
begin
  inherited;
  lbl_titulo.Text    := 'Pesquisar Artista Favorito';
  lblInfoTexto.Text  := 'Olá';
  rctCard.Visible    := false;
  CarregaMusicas(speBtnAtualizar);
end;

procedure TFrmListaMusicas.Image2Click(Sender: TObject);
begin
  inherited;
   TLibery.CustomThread(
      procedure()
      Begin
      //Processo de Inicio
        TThread.Synchronize(
         TThread.CurrentThread,
          procedure()
          Begin
            TLoading.Show(FrmMain,'Recebendos dados musicais...');
            TLibery.ActiveForm := nil;
            FrmMain.Campo:='artistName';
            FrmMain.Filtro:= edt_busca.Text;
          End);
      End,
      procedure()
      Begin
      //Processo Principal
       sleep(1000);
       DmRest.RecebeMusicas(StringReplace(edt_busca.Text,'', EmptyStr, [rfReplaceAll]));
      End,
      procedure()
      Begin
       //Processo Completo
        TLoading.Hide;
        self.edt_busca.Text := EmptyStr;
        Self.CarregaMusicas(Sender);
      End,
      procedure(const AException :string)
      Begin
      FrmMain.MensagemTost('Erro no processamento da thread Recebe Musicas! ' +
      AException);

      End,
      True
    );
end;

procedure TFrmListaMusicas.Image3Click(Sender: TObject);
begin
  inherited;
  rctFiltroEd.Visible:=true;
  if vertLista.Margins.Top =190 then
  vertLista.Margins.Top := vertLista.Margins.Top + 168;
end;

procedure TFrmListaMusicas.OnSelecionarPedido(Sender: TObject);
begin
 {$IFDEF MSWINDOWS}
  DmLocal.QryMusicas.Locate('trackId',TRectangle(Sender).Tag);
  TLibery.CustomThread(
    procedure()
    Begin
    //Processo de Inicio
      TThread.Synchronize(
       TThread.CurrentThread,
        procedure()
        Begin
          TLoading.Show(FrmMain,'Detalhando aguarde ...');
          TLibery.ActiveForm := nil;
          DmLocal.LimparLista(Self,vertLista,rctCard.Name);
        End

      );
    End,
    procedure()
    var
     LFrame   : TRectangle;
     LPosicao,LPosicaoB : Single;
     s:string;
     Qtd      : Integer;
    Begin


    End,
    procedure()
    Begin
     //Processo Completo
      TLoading.Hide;
      FrmMain.lytNavegacao.Controls.Clear;
      TLibery.ActiveForm.DisposeOf;
      TLibery.ActiveForm:=nil;
      TLibery.OpenForm(TFrmInformativo,FrmMain.lytNavegacao);
      TLibery.MudarAba(FrmMain.tbiMain,Sender);

    End,
    procedure(const AException :string)
    Begin
      TLoading.Hide;
      FrmMain.MensagemTost('Erro no processamento da thread Detalhar Musicas! ' +
      AException);
    End,
    false
  );
 {$ENDIF}
end;

procedure TFrmListaMusicas.RadioButton1Change(Sender: TObject);
begin
  inherited;
  edt_busca_musica.TextPrompt:='Digite nome do Artista';
end;

procedure TFrmListaMusicas.RadioButton2Change(Sender: TObject);
begin
  inherited;
  edt_busca_musica.TextPrompt:='Digite nome da Coleção';
end;

procedure TFrmListaMusicas.speBtnAtualizarClick(Sender: TObject);
begin
  inherited;
  CarregaMusicas(Sender);
end;

procedure TFrmListaMusicas.speBtnMenuClick(Sender: TObject);
begin
  inherited;
  FrmMain.lytNavegacao.Controls.Clear;
  TLibery.ActiveForm.DisposeOf;
  TLibery.ActiveForm:=nil;
  TLibery.MudarAba(FrmMain.tbiPrincipal,Sender);
end;


procedure TFrmListaMusicas.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  ValidaFiltro;
  self.CarregaMusicas(Sender);
  self.btnFecharFiltro.OnClick(Sender);
end;

procedure TFrmListaMusicas.ValidaFiltro;
begin
  Frmmain.Campo  := '';
  Frmmain.Filtro := '';

  if RadioButton1.IsChecked then
  FrmMain.Campo := 'artistName' else
  if RadioButton2.IsChecked then
  FrmMain.Campo := 'collectionName' else
  FrmMain.Campo := '';

  FrmMain.Filtro := edt_busca_musica.Text;
end;

end.
