unit uFrmTemplate;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, FMX.Effects;

type
  TFrmTemplate = class(TForm)
    rect_titulo: TRectangle;
    lbl_titulo: TLabel;
    speBtnMenu: TSpeedButton;
    speBtnAtualizar: TSpeedButton;
    lytGeral: TLayout;
    rect_informativo: TRectangle;
    lblInfoTexto: TLabel;
    Layout3: TLayout;
    Line1: TLine;
    vertLista: TVertScrollBox;
    lytBotoes: TLayout;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure ResizeObjects;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTemplate: TFrmTemplate;

implementation

{$R *.fmx}

{ TFrmTemplate }

procedure TFrmTemplate.FormCreate(Sender: TObject);
begin
 ResizeObjects;
end;

procedure TFrmTemplate.FormShow(Sender: TObject);
begin
 ResizeObjects;
end;

procedure TFrmTemplate.ResizeObjects;
begin
    rect_informativo.Position.X := rect_titulo.Position.X -110;


end;

end.
