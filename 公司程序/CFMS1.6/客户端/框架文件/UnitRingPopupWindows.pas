unit UnitRingPopupWindows;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, jpeg, ExtCtrls, MMSystem, StdCtrls, Menus,
  cxLookAndFeelPainters, cxButtons, dxGDIPlusClasses;

type
  TFormRingPopupWindows = class(TForm)
    ImgBackgrounds: TImage;
    LabelRemindType: TLabel;
    Btnview: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BtnviewClick(Sender: TObject);
  private
    { Private declarations }
    FIsRing: Boolean;
    FRingFileName: string;
    FRemindType: Integer; //�������� 0-�����ɵ����� 1-���Ͻ���ʱ��������

    procedure PlayRing;
    procedure StopRing;

  public
    { Public declarations }
//    property IsRing:Boolean read FIsRing write FIsRing;
//    property RingFileName: string read FRingFileName write FRingFileName;
//    property RemindType: Integer read FRemindType write FRemindType;

    constructor Create(AOwner: TComponent; aIsRing: Boolean; aRingFileName: string;
                   aRemindType: Integer);
  end;

const              
  AlarmSendRing = '�¸澯��������';
  AlarmWillOverTimeRing = '�澯����ʱ��������';
var
  FormRingPopupWindows: TFormRingPopupWindows;

implementation

uses UnitDataModuleLocal, UnitVFMSGlobal;

{$R *.dfm}

constructor TFormRingPopupWindows.Create(AOwner: TComponent;
  aIsRing: Boolean; aRingFileName: string; aRemindType: Integer);
begin
  inherited create(AOwner);
  FIsRing:= aIsRing;
  FRingFileName:= aRingFileName;
  FRemindType:= aRemindType;
  if FRemindType=1 then
    LabelRemindType.Caption:= AlarmSendRing;
  if FRemindType=2 then
    LabelRemindType.Caption:= AlarmWillOverTimeRing;
end;

procedure TFormRingPopupWindows.FormShow(Sender: TObject);
var
  a: TPoint;
begin
  ClientToScreen(a);
  a.X:= Screen.DesktopLeft + Screen.DesktopWidth;
  a.Y:= Screen.DesktopTop + Screen.DesktopHeight;
  ScreenToClient(a);
  Self.Left:= a.X - 195;
  Self.Top:= a.Y - Self.Height - 30;

  AnimateWindow(Handle, 1000, AW_ACTIVATE+AW_VER_NEGATIVE+AW_SLIDE);

  if FIsRing then
    PlayRing;
end;

procedure TFormRingPopupWindows.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  StopRing;
  ANimateWindow(Handle,800,AW_SLIDE+AW_VER_POSITIVE+AW_HIDE);
end;

procedure TFormRingPopupWindows.PlayRing;
begin
  sndPlaySound(pchar(FRingFileName), SND_NODEFAULT Or SND_ASYNC Or SND_LOOP);
end;

procedure TFormRingPopupWindows.StopRing;
var
  lSqlstr: string;
  lVariant: variant;
  lsuccess: boolean;
begin
  lVariant:= VarArrayCreate([0,0],varVariant);
  lSqlstr:= 'update alarm_ringremind_info t set t.isremind=0' + ',' +
            'UPDATETIME=sysdate' +
            ' where t.companyid='+
            '(select deptid from fms_user_info where cityid=' +
            inttostr(gPublicParam.cityid) +
            ' and userid=' + IntToStr(gPublicParam.userid) +
            ') and cityid=' +
            inttostr(gPublicParam.cityid) +
            ' and REMINDTYPE=' + IntToStr(FRemindType);
  lVariant[0]:= VarArrayOf([lSqlstr]);
  lsuccess:= DataModuleLocal.TempInterface.ExecBatchSQL(lVariant);
  sndPlaySound(nil, SND_LOOP);
end;

procedure TFormRingPopupWindows.BtnviewClick(Sender: TObject);
begin
  Close;
  UpdateWindow(Self.Handle);
end;

end.
