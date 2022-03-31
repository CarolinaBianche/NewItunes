unit uFrmArrumacao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmTemplate, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.Edit,
  FMX.Effects;

type
  TFrmArrumacao = class(TFrmTemplate)
    rctCard3: TRectangle;
    rctTopCard3: TRectangle;
    spdBtnFinal: TSpeedButton;
    rect_andar: TRectangle;
    Label9: TLabel;
    ShadowEffect12: TShadowEffect;
    edtAndar: TEdit;
    btn_limpa_andar: TSpeedButton;
    rect_apto: TRectangle;
    Label10: TLabel;
    ShadowEffect13: TShadowEffect;
    edtApto: TEdit;
    btn_limpa_apto: TSpeedButton;
    rect_galpao: TRectangle;
    Label17: TLabel;
    ShadowEffect9: TShadowEffect;
    edtGalpao: TEdit;
    btn_limpa_galpao: TSpeedButton;
    rect_numero: TRectangle;
    Label8: TLabel;
    ShadowEffect11: TShadowEffect;
    edtNumero: TEdit;
    btn_limpa_num: TSpeedButton;
    rect_rua: TRectangle;
    Label7: TLabel;
    ShadowEffect10: TShadowEffect;
    edtRua: TEdit;
    btn_limpa_rua: TSpeedButton;
    rect_qtd_movimento: TRectangle;
    lbl_qtd_movimento: TLabel;
    ShadowEffect1: TShadowEffect;
    edt_qtd_movimento: TEdit;
    btn_limpa_qtd: TSpeedButton;
    lyt_codigo_barras: TLayout;
    rect_cod_barras: TRectangle;
    edt_codbarras: TEdit;
    btnLancar: TSpeedButton;
    Layout1: TLayout;
    Path1: TPath;
    procedure btn_limpa_qtdClick(Sender: TObject);
    procedure btn_limpa_galpaoClick(Sender: TObject);
    procedure btn_limpa_ruaClick(Sender: TObject);
    procedure btn_limpa_numClick(Sender: TObject);
    procedure btn_limpa_andarClick(Sender: TObject);
    procedure btn_limpa_aptoClick(Sender: TObject);
    procedure speBtnMenuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmArrumacao: TFrmArrumacao;

implementation

{$R *.fmx}

uses Constantes, uFrmMain, uListview, uLoading, UntLib;

procedure TFrmArrumacao.btn_limpa_andarClick(Sender: TObject);
begin
  inherited;
 edtAndar.Text := EmptyStr;
end;

procedure TFrmArrumacao.btn_limpa_aptoClick(Sender: TObject);
begin
  inherited;
 edtApto.Text := EmptyStr;
end;

procedure TFrmArrumacao.btn_limpa_galpaoClick(Sender: TObject);
begin
  inherited;
  edtGalpao.Text := EmptyStr;
end;

procedure TFrmArrumacao.btn_limpa_numClick(Sender: TObject);
begin
  inherited;
 edtNumero.Text:= EmptyStr;
end;

procedure TFrmArrumacao.btn_limpa_qtdClick(Sender: TObject);
begin
  inherited;
  edt_qtd_movimento.Text := EmptyStr;
end;

procedure TFrmArrumacao.btn_limpa_ruaClick(Sender: TObject);
begin
  inherited;
 edtRua.Text := EmptyStr;
end;

procedure TFrmArrumacao.speBtnMenuClick(Sender: TObject);
begin
  inherited;
   FrmMain.lytNavegacao.Controls.Clear;
   TLibery.ActiveForm.DisposeOf;
   TLibery.ActiveForm:=nil;
   TLibery.MudarAba(FrmMain.tbiMain,Sender);
end;

end.