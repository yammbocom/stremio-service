; Copyright (C) 2017-2026 Smart Code OOD 203358507

#define MyAppName "Yammbo TV Service"
#define MyAppShortName "YammboTVService"
#define MyAppExeName "stremio-service.exe"
#define MyAppRoot SourcePath + "..\"
#define MyAppBinLocation SourcePath + "..\stremio-service-windows\"
#define MyAppResBinLocation SourcePath + "..\resources\bin\windows\"
#define MyAppExeLocation MyAppBinLocation + MyAppExeName
#define MyAppVersion() GetVersionComponents(MyAppExeLocation, Local[0], Local[1], Local[2], Local[3]), \
  Str(Local[0]) + "." + Str(Local[1]) + "." + Str(Local[2])

#define MyAppPublisher "Yammbo"
#define MyAppCopyright "Copyright (C) 2017-" + GetDateTimeString('yyyy', '', '') + " " + MyAppPublisher
#define MyAppURL "https://tv.yammbo.com/"
#define MyAppGoodbyeURL "https://tv.yammbo.com/"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{A9F3C7E2-5B41-4E8A-BC36-1D2E3F4A5B6C}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppCopyright={#MyAppCopyright} 
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppShortName}
SetupMutex=YammboTVServiceSetupMutex,Global\YammboTVServiceSetupMutex
; Remove the following line to run in administrative install mode (install for all users.)
PrivilegesRequired=lowest
DisableReadyPage=yes
DisableDirPage=yes
DisableProgramGroupPage=yes
; DisableFinishedPage=yes
ChangesAssociations=yes
OutputBaseFilename={#MyAppShortName}Setup
OutputDir=..
Compression=lzma
SolidCompression=yes
WizardStyle=modern
LanguageDetectionMethod=uilanguage
ShowLanguageDialog=auto
CloseApplications=yes
WizardImageFile={#SourcePath}\windows-installer.bmp
WizardSmallImageFile={#SourcePath}\windows-installer-header.bmp
SetupIconFile={#SourcePath}..\resources\service.ico
UninstallDisplayIcon={app}\{#MyAppExeName},0

[Code]
function ShouldSkipPage(PageID: Integer): Boolean;
begin
  { Hide finish page if run app is selected }
  if (PageID = wpFinished) and WizardIsTaskSelected('runapp') then
    Result := True
  else
    Result := False;
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  case (CurPageID) of
    wpSelectTasks: WizardForm.NextButton.Caption := SetupMessage(msgButtonInstall);
    wpFinished: WizardForm.NextButton.Caption := SetupMessage(msgButtonFinish);
  else
    WizardForm.NextButton.Caption := SetupMessage(msgButtonNext);
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode: Integer;
begin
  if (CurStep = ssDone) and WizardIsTaskSelected('runapp') then
    ExecAsOriginalUser(ExpandConstant('{app}\{#MyAppExeName}'), '', '', SW_SHOW, ewNoWait, ResultCode);
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  ErrorCode: Integer;
begin
  case (CurUninstallStep) of
    usDone: ShellExec('', ExpandConstant('{#MyAppGoodbyeURL}'), '', '', SW_SHOW, ewNoWait, ErrorCode);
  end;
end;

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[CustomMessages]
RemoveDataFolder=Remove all data and configuration?
english.RemoveDataFolder=Remove all data and configuration?

[Tasks]
Name: "runapp"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"

[Files]
; NOTE: Don't use "Flags: ignoreversion" on any shared system files
Source: "{#MyAppExeLocation}"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#MyAppRoot}LICENSE.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#MyAppResBinLocation}ffmpeg.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#MyAppResBinLocation}ffprobe.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#MyAppResBinLocation}stremio-runtime.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#MyAppResBinLocation}server.js"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#MyAppResBinLocation}avcodec-58.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#MyAppResBinLocation}avdevice-58.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#MyAppResBinLocation}avfilter-7.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#MyAppResBinLocation}avformat-58.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#MyAppResBinLocation}avutil-56.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#MyAppResBinLocation}postproc-55.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#MyAppResBinLocation}swresample-3.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#MyAppResBinLocation}swscale-5.dll"; DestDir: "{app}"; Flags: ignoreversion

[Registry]

; stremio: protocol
Root: HKA; Subkey: "Software\Classes\YammboTVService"; ValueType: string; ValueName: ""; ValueData: "URL:Yammbo Tv Protocol"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\YammboTVService"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\YammboTVService\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName},0"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\YammboTVService\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""-o"" ""%1"""; Flags: uninsdeletekey

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

; This is used if the desktop shortcut is created by the [run] section.
; [UninstallDelete]
; Type: files; Name: "{autodesktop}\{#MyAppName}.lnk"

; [Run]
; Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
; Filename: "cmd"; Parameters: "/c copy ""{autoprograms}\{#MyAppName}.lnk"" ""{autodesktop}"""; Description: "{cm:CreateDesktopIcon}"; Flags: postinstall skipifsilent shellexec runhidden waituntilterminated runascurrentuser
