unit U_FrmSplash;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects;

type
  TFrmSplash = class(TForm)
    Rectangle1: TRectangle;
    Image2: TImage;
    Image1: TImage;
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
       FInitialized : Boolean;
    procedure LoadMainForm;
  public
    { Public declarations }
  end;

var
  FrmSplash: TFrmSplash;

implementation

{$R *.fmx}

uses uFrmMain;

procedure TFrmSplash.FormShow(Sender: TObject);
begin
    Timer1.Interval := 3000;
    Timer1.Enabled := true;
    image1.Opacity := 0;
    image2.Opacity := 0;


    Image1.Align := TAlignLayout.None;
    Image1.AnimateFloat('Opacity', 1, 0.1);
    Image1.AnimateFloat('width', 237 ,3.0);
    Image1.AnimateFloat('Height', 47 ,3.0);
    Image1.AnimateFloatDelay('Position.Y', 260, 3.0, 0.3, TAnimationType.Out, TInterpolationType.Back);
    Image1.AnimateFloatDelay('Position.x', 50, 3.0, 0.3, TAnimationType.Out, TInterpolationType.Back);

    Image2.AnimateFloat('Opacity', 1, 3.0);
    Image1.AnimateFloat('Opacity', 0, 3.0);
end;

procedure TFrmSplash.LoadMainForm;
var Frm : TForm;
begin
  if NOT Assigned(FrmMain) then
        Application.CreateForm(TFrmMain, FrmMain);

        Application.MainForm := FrmMain;

        FrmMain.Show;
   self.Close;
end;

procedure TFrmSplash.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := false;
  if not FInitialized  then
  begin
    FInitialized := True;
    LoadMainForm;
  end;

end;

end.
