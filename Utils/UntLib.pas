unit UntLib;

interface

uses

System.SysUtils,
System.Classes,
System.Types,
System.IOUtils,
System.StrUtils,
System.MaskUtils,
System.RegularExpressions,
System.UITypes,

Fmx.Forms,
Fmx.Layouts,
Fmx.MultiView,
Fmx.Types,
Fmx.StdCtrls,
Fmx.TabControl,
Fmx.ActnList;

 Type   TProcedureExcept = reference to procedure (const AException :string);

 TLibery = Class
   protected

   private
    class var
    FMainMenu    : TMultiView;
    FActiveForm  : TForm;
    FLayoutMain  : TLayout;
    FTabMain     : TTabControl;
    FActionMenu  : TActionList;
    FActMudarAba : TChangeTabAction;
    class var FNomeForm: String;

   public

   class procedure CustomThread(
    AOnStart,
    AOnProcess,
    AOnComplet   :TProc;
    AOnError     :TProcedureExcept =nil;
    Const  ADOCompleteWithError : Boolean = True
    );

   class procedure OpenForm(const AFormClass :TComponentClass; ATarget : TFmxObject=nil);
   class procedure MudarAba(ATabItem : TTabItem; Sender:TObject);


   class property MainMenu    : TMultiView  read FMainMenu   write FMainMenu;
   class property ActiveForm  : TForm       read FActiveForm write FActiveForm;
   class property LayoutMain  : TLayout     read FLayoutMain write FLayoutMain;
   class property TabMain     : TTabControl read FTabMain    write FTabMain;
   class property ActionMenu  : TActionList read FActionMenu write FActionMenu;
   class property ActMudarAba : TChangeTabAction read FActMudarAba write FActMudarAba;
   class property NomeForm    : String      read FNomeForm   write FNomeForm;

 End;

implementation



{ TLibery }

class procedure TLibery.CustomThread(AOnStart, AOnProcess, AOnComplet: TProc;
  AOnError: TProcedureExcept; const ADOCompleteWithError: Boolean);
  var
  LThread : TThread;
begin
 LThread :=
 TThread.CreateAnonymousThread(
 procedure()
 var
  LDoComplete :Boolean;
 Begin
  try
    {$Region 'Start'}
    try
     LDoComplete :=True;
     //Processo Inicial
     if Assigned(AOnStart) then
     Begin
       TThread.Synchronize(
        TThread.CurrentThread,
        procedure()
        Begin
         AOnStart;
        End
       );
     End;


    {$Region 'Process'}
     if Assigned(AOnProcess) then
      AOnProcess;
    {$EndRegion}

    except  on E: Exception do
    Begin
      LDoComplete := ADOCompleteWithError;
      //Processo de Erro
      if Assigned(AOnError) then
      Begin
        TThread.Synchronize(
         TThread.CurrentThread,
         procedure ()
         Begin
           AOnError(E.Message);
         End
        );
      End;
    End;
   End;
  finally
   {$Region 'Complete'}
    //Processo de Finalizacao
    if Assigned(AOnComplet) then
    Begin
      TThread.Synchronize(
      TThread.CurrentThread,
      procedure ()
      Begin
        AOnComplet;
      End
      );
    End;

   {$EndRegion}
   {$EndRegion}
  end;
 End

 );

 LThread.FreeOnTerminate := True;
 LThread.Start;

end;

class procedure TLibery.MudarAba(ATabItem: TTabItem; Sender: TObject);
begin
 FActMudarAba.Tab := ATabItem;
 FActMudarAba.ExecuteTarget(Sender);
end;

class procedure TLibery.OpenForm(const AFormClass: TComponentClass;
  ATarget: TFmxObject);
   var
   LLayoutBase : TComponent;
   LBotaoMenu  : TComponent;
begin
  if ATarget = nil then
    ATarget := LayoutMain;

  if Assigned(FActiveForm) then
  Begin
    if FActiveForm.ClassType= AFormClass then
    Begin
      exit
    End;

  End else
  Begin
  ActiveForm.DisposeOf;
 // ActiVeForm.Destroy;
  ActiveForm := nil;
  Application.CreateForm(AFormClass,FActiveForm);
  End;

  NomeForm :=  FActiveForm.Name;

  LLayoutBase := ActiveForm.FindComponent('lytGeral');
  LBotaoMenu  := ActiveForm.FindComponent('speBtnMenu');

  if Assigned(LLayoutBase) then
  Begin
    TLayout(ATarget).AddObject(TLayout(LLayoutBase));
  End;



end;

end.
