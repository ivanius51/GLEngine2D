unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,GLEngine, ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  CreateTex,pod:Cardinal;
  GLE:TGLEngine;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
 bmp:TBitMap;
 x,y:integer;
begin
 GLE:=TGLEngine.Create;
 GLE.VisualInit(GetDC(Panel1.Handle),Panel1.ClientWidth,Panel1.ClientHeight,0);
 CreateTex:=GLE.CreateImage(640,480);
 pod:=GLE.CreateImage(640,480);
 GLE.Resize(640,480);

 gle.BeginRenderToTex(pod,640,480);
 Gle.SetColor(1,1,1,1);
 Gle.Bar(0,0,640,480);
 Gle.SetColor(0.3,0.3,0.3,0.3);
 for x:=0 to 64 do
  for y:=0 to 48 do
   if (x+y) mod 2 = 0 then
    Gle.Bar(x*10,y*10,x*10+10,y*10+10);
 gle.EndRenderToTex;

 gle.BeginRenderToTex(CreateTex,640,480);
 Gle.BarGrad(10,10,10,470,630,470,630,10,gle.ColorGL(1,0,0,0.9),gle.ColorGL(0,1,0,0.9),gle.ColorGL(0,0,1,0.9),gle.ColorGL(1,1,1,0.9));
 gle.EndRenderToTex;

 gle.DrawImage(0,0,640,480,0,false,false,pod);
 gle.DrawImage(0,0,640,480,0,false,false,CreateTex);

 gle.SaveImageAsPNG('c:\TestBMP.png',CreateTex);
 bmp:=TBitMap.Create;
 gle.GetBMP32FromImage(CreateTex,bmp);
 image1.Picture.Assign(bmp);
 bmp.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
 Gle.BeginRender(true);
 Gle.SetColor(1,1,1,1);
 Gle.DrawImage(0,0,640,480,0,false,false,pod);
 Gle.DrawImage(0,0,640,480,0,false,false,CreateTex);
 gle.SetTextStyle('Countdown',20);
 gle.SetColor(1,1,1,1);
 gle.TextOut(20,40,'Countdown');

 gle.SetTextStyle('Times New Roman',20);
 gle.SetColor(1,1,1,1);
 gle.TextOut(20,60,'Times New Roman');
 Gle.FinishRender;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
 Gle.FreeImage(pod);
 Gle.FreeImage(CreateTex);
 Gle.Free;
end;

end.
