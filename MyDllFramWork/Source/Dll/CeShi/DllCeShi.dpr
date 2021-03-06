library DllCeShi;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Classes,
  Forms,
  UnitCeShi in 'UnitCeShi.pas' {FormCeShi},
  UnitDllPublic in '..\..\Common\UnitDllPublic.pas';

{$R *.res}

  function CallDll(Application:TApplication; DllCloseRecall: TDllCloseRecall):TForm;
  begin
    Result:= nil;
    if Assigned(FormCeShi) then Exit;
    FDllCloseRecall:= DllCloseRecall;
    FormCeShi:=TFormCeShi.create(Application);
    Result:=FormCeShi;
  end;

  procedure CloseForm;stdcall;
  begin
    if Assigned(FormCeShi) then
    begin
      FreeAndNil(FormCeShi);
    end;
  end;

  exports
    CallDll,
    CloseForm;

end.
 