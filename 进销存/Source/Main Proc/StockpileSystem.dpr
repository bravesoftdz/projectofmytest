program StockpileSystem;

uses
  Forms,
  Windows,
  UnitSystemServer,
  UnitMain in 'UnitMain.pas' {FormMain},
  UnitResource in '..\Common\UnitResource.pas',
  UnitLogIn in '..\Login\UnitLogIn.pas' {FormLogIn},
  UnitPublicResourceManager in '..\Common\UnitPublicResourceManager.pas',
  UnitDataModule in '..\Common\UnitDataModule.pas' {DM: TDataModule},
  UnitAbout in 'View\UnitAbout.pas' {FormAbout},
  UnitUserManager in '..\Common\UnitUserManager.pas',
  UnitDepotInfoMgr in 'BasicInfoMgr\UnitDepotInfoMgr.pas' {FormDepotInfoMgr},
  UnitPublic in '..\Common\UnitPublic.pas',
  UnitAssociatorTypeMgr in 'BasicInfoMgr\UnitAssociatorTypeMgr.pas' {FormAssociatorTypeMgr},
  UnitProviderMgr in 'BasicInfoMgr\UnitProviderMgr.pas' {FormProviderMgr},
  UnitCustomerMgr in 'BasicInfoMgr\UnitCustomerMgr.pas' {FormCustomerMgr},
  UnitGoodsMgr in 'BasicInfoMgr\UnitGoodsMgr.pas' {FormGoodsMgr},
  UnitInDepotTypeMgr in 'BasicInfoMgr\UnitInDepotTypeMgr.pas' {FormInDepotTypeMgr},
  UnitOutDepotTypeMgr in 'BasicInfoMgr\UnitOutDepotTypeMgr.pas' {FormOutDepotTypeMgr},
  UnitEditUser in 'UserManage\UnitEditUser.pas' {FormEditUser},
  UnitUserManage in 'UserManage\UnitUserManage.pas' {FormUserManage},
  UnitChangePWD in 'UserManage\UnitChangePWD.pas' {FormChangePWD},
  UnitLockSystem in 'View\UnitLockSystem.pas' {FormLockSystem},
  UnitInDepotMgr in 'RepertoryManage\UnitInDepotMgr.pas' {FormInDepotMgr},
  UnitOutDepotMgr in 'RepertoryManage\UnitOutDepotMgr.pas' {FormOutDepotMgr},
  UnitInDepotStat in 'RepertoryManage\UnitInDepotStat.pas' {FormInDepotStat},
  UnitInDepotChangeStat in 'RepertoryManage\UnitInDepotChangeStat.pas' {FormInDepotChangeStat},
  UnitGoodsTypeMgr in 'BasicInfoMgr\UnitGoodsTypeMgr.pas' {FormGoodsTypeMgr},
  UnitGoodsSearch in 'RepertoryManage\UnitGoodsSearch.pas' {FormGoodsSearch},
  UnitCustomerSearch in 'RepertoryManage\UnitCustomerSearch.pas' {FormCustomerSearch},
  UnitRepertoryManager in '..\Common\UnitRepertoryManager.pas',
  UnitRepertoryStat in 'RepertoryManage\UnitRepertoryStat.pas' {FormRepertoryStat},
  UnitOutDepotStat in 'RepertoryManage\UnitOutDepotStat.pas' {FormOutDepotStat},
  UnitBalanceAnalyse in 'RepertoryManage\UnitBalanceAnalyse.pas' {FormBalanceAnalyse},
  UnitSalaryMgr in 'UserManage\UnitSalaryMgr.pas' {FormSalaryMgr},
  UnitAttendanceMgr in 'UserManage\UnitAttendanceMgr.pas' {FormAttendanceMgr},
  UnitRingPopupWindows in 'View\UnitRingPopupWindows.pas' {FormRingPopupWindows};

{$R *.res}
var
  sTitle: string;
  Exist: DWORD;
begin
  Application.Initialize;
  TSystemServer.getInstance.StartUp;
  try
    FormMain.CreateODBC;
    sTitle:= sSystemTitle;
    CreateMuteX(nil,True,PChar(sTitle));
    Exist:=GetLastError;
    If   Exist=ERROR_ALREADY_EXISTS   then   begin
        Application.MessageBox(PChar(sRepeatLogInSystem),'��ʾ��Ϣ',MB_OK+MB_ICONINFORMATION);
        Application.Terminate;
    end;
    initAllScreenAndFormResources;
    Application.CreateForm(TDM, DM);
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
  finally
    try
      TSystemServer.getInstance.ShutDown;
      freeAllScreenAndFormResources;
    except
    end;
  end;
end.
