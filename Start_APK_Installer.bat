@echo off
setlocal
rem ------------------------------------------------------------------
rem  Opens the newest apk_installer_V_0_x.html (in the same folder as
rem  this .bat file) in Microsoft Edge, regardless of default browser.
rem ------------------------------------------------------------------

rem 1) Find the newest installer file in this folder (by modification date)
set "PAGE="
for /f "delims=" %%F in ('dir /b /a-d /o:d "%~dp0apk_installer_V_0_*.html" 2^>nul') do set "PAGE=%~dp0%%F"
if not defined PAGE (
    echo Could not find apk_installer_V_0_*.html in:
    echo   %~dp0
    echo Put this .bat file in the same folder as the installer HTML file.
    pause
    exit /b 1
)

rem 2) Find Edge
set "EDGE="
for %%E in (
    "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
    "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
    "%LocalAppData%\Microsoft\Edge\Application\msedge.exe"
) do if not defined EDGE if exist %%E set "EDGE=%%~E"

rem 3) Start it
if defined EDGE (
    start "" "%EDGE%" --new-window "%PAGE%"
) else (
    rem Fallback: let Windows locate Edge via its registered app path
    start "" msedge --new-window "%PAGE%" || (
        echo Microsoft Edge was not found on this computer.
        echo Please open this file manually in Edge or Chrome:
        echo   %PAGE%
        pause
        exit /b 1
    )
)
endlocal
