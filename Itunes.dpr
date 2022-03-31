program Itunes;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Types,
  uFrmMain in 'uFrmMain.pas' {FrmMain},
  UntLib in 'Utils\UntLib.pas',
  uFrmTemplate in 'uFrmTemplate.pas' {FrmTemplate},
  uLoading in 'Utils\uLoading.pas',
  uDmRest in 'DataModulos\uDmRest.pas' {DmRest: TDataModule},
  uDMLocal in 'DataModulos\uDMLocal.pas' {DMLocal: TDataModule},
  Notificacao in 'Utils\Notificacao.pas',
  U_FrmSplash in 'Forms\U_FrmSplash.pas' {FrmSplash},
  uFrmListaMusicas in 'Forms\uFrmListaMusicas.pas' {FrmListaMusicas},
  uFrmInformativo in 'Forms\uFrmInformativo.pas' {FrmInformativo},
  AnonThread in 'Utils\AnonThread.pas',
  Constantes in 'Utils\Constantes.pas';

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF ANDROID}
    VKAutoShowMode := TVKAutoShowMode.Never;
  {$ENDIF}
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TDmRest, DmRest);
  Application.CreateForm(TDMLocal, DMLocal);
  Application.CreateForm(TFrmSplash, FrmSplash);
  Application.Run;
end.
