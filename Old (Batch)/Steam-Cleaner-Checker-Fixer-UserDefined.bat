@echo off
setlocal enableextensions enabledelayedexpansion
%~d0
pushd %~dp0
set "Tit=Steam Cleaner, Checker and Fixer By Apryed - v1.2.0"
title %Tit%
Color A
for /f "tokens=9 delims=," %%a in ('tasklist /fi "imagename eq cmd.exe" /v /fo:csv /nh ^| findstr /r /c:".*%Tit%[^,]*$" ') do set Adm=%%a
IF %Adm:~1,5% EQU Admin GOTO LANGUAGE
cls
echo I require Administrator Rights to run.
echo.
echo Please, run me as Admin so I can work properly.
echo Thanks, bye.
pause >nul
exit
:LANGUAGE
cls
echo ============================
echo ^| Select Language          ^|
echo ^| 1. English               ^|
echo ^| 2. Spanish               ^|
echo ============================
CHOICE /C 12 /M "Language : "
SET LANG=%ERRORLEVEL%
IF %LANG% EQU 2 title Limpiador, Comprobador y reparador de Steam por Apryed - v1.2.0
cls
IF %LANG% EQU 1 echo Insert Steam installation folder path
IF %LANG% EQU 1 echo  Ex.: C:\Program Files(x86)\Steam
IF %LANG% EQU 2 echo Introduzca la ruta donde esta instalado Steam
IF %LANG% EQU 2 echo  Ej.: C:\Program Files(x86)\Steam
set /P SteamPath=
IF exist "%SteamPath%\Steam.exe" GOTO StartP
:STEAMLOCE
cls
IF %LANG% EQU 1 echo Steam.exe could not be found. Please insert a valid folder path.
IF %LANG% EQU 1 echo  Ex.: C:\Program Files(x86)\Steam
IF %LANG% EQU 2 echo No se ha podido encontrar Steam.exe. Por favor inserte una ruta valida.
IF %LANG% EQU 2 echo  Ej.: C:\Program Files(x86)\Steam
set /P SteamPath=
IF NOT exist "%SteamPath%\Steam.exe" GOTO STEAMLOCE
:StartP
cls
IF %LANG% EQU 1 CHOICE /M "Do you want to go to Part 2"
IF %LANG% EQU 2 CHOICE /M "Quiere ir a la Parte 2"
IF %ERRORLEVEL% == 1 GOTO Part2
cls
IF %LANG% EQU 1 echo Part 1/2
IF %LANG% EQU 1 echo Step 1/7
IF %LANG% EQU 1 echo Closing Steam
IF %LANG% EQU 2 echo Parte 1/2
IF %LANG% EQU 2 echo Paso 1/7
IF %LANG% EQU 2 echo Cerrando Steam
taskkill /F /IM Steam.exe /T
ping 127.0.0.1 -n 15 > nul
echo.
echo.
IF %LANG% EQU 1 echo Step 2/7
IF %LANG% EQU 1 echo Cleaning Steam
IF %LANG% EQU 2 echo Paso 2/7
IF %LANG% EQU 2 echo Limpiando Steam
pushd %SteamPath%
for /D %%a in (*.*) do if not "%%a"=="config" if not "%%a"=="steamapps" if not "%%a"=="userdata" RD /s /q "%%a"
for %%a in (*.*) do if not "%%a"=="Steam.exe" if not "%%a"=="steam.exe" if not "%%a"=="uninstall.exe" if not "%%a"=="Uninstall.exe" if not "%%a"=="steam.signatures" DEL /F /Q "%%a"
echo.
echo.
IF %LANG% EQU 1 echo Step 3/7
IF %LANG% EQU 1 echo Restoring boot settings to default
IF %LANG% EQU 2 echo Paso 3/7
IF %LANG% EQU 2 echo Restaurando opciones de inicio a las predeterminadas
bcdedit /deletevalue nointegritychecks
bcdedit /deletevalue loadoptions
bcdedit /debug off
bcdedit /deletevalue nx
echo.
echo.
IF %LANG% EQU 1 echo Step 4/7
IF %LANG% EQU 1 echo Checking Windows for corruption
IF %LANG% EQU 2 echo Paso 4/7
IF %LANG% EQU 2 echo Comprobando Windows en busca de datos corruptos
Dism /Online /Cleanup-Image /CheckHealth
echo.
echo.
IF %LANG% EQU 1 echo Step 5/7
IF %LANG% EQU 1 echo Scaning Windows for corruption ( Checking what is needed to repair it )
IF %LANG% EQU 2 echo Paso 5/7
IF %LANG% EQU 2 echo Escaneando Windows en busca de datos corruptos ( Comprobando que se necesita para repararlo )
Dism /Online /Cleanup-Image /ScanHealth
echo.
echo.
IF %LANG% EQU 1 echo Step 6/7
IF %LANG% EQU 1 echo Reparing Windows Health
IF %LANG% EQU 2 echo Paso 6/7
IF %LANG% EQU 2 echo Reparando la salud de Windows
DISM /Online /Cleanup-Image /RestoreHealth
echo.
echo.
IF %LANG% EQU 1 echo Step 7/7
IF %LANG% EQU 1 echo Checking and Repairing System
IF %LANG% EQU 2 echo Paso 7/7
IF %LANG% EQU 2 echo Comprobando y Reparando el Sistema
SFC /scannow
echo.
echo.
cls
IF %LANG% EQU 1 echo Your pc is going to be restarted. Save anything important before continuing.
IF %LANG% EQU 1 echo Relaunch me after your pc has restarted.
IF %LANG% EQU 1 echo Press any key when you are ready...
IF %LANG% EQU 2 echo Su PC se va a reinciar. Salve cualquier cosa importante antes de continuar.
IF %LANG% EQU 2 echo Vuelva a ejecutarme cuando su pc se haya reiniciado.
IF %LANG% EQU 2 echo Pulse cualquier tecla cuando este list@...
pause >nul
shutdown /f /r /t 0
exit
:Part2
IF %LANG% EQU 1 echo Part 2/2
IF %LANG% EQU 1 echo Step 1/3
IF %LANG% EQU 1 echo Flushing DNS
IF %LANG% EQU 2 echo Parte 2/2
IF %LANG% EQU 2 echo Paso 1/3
IF %LANG% EQU 2 echo Renovando DNS
ipconfig /release
ipconfig /flushdns
ipconfig /renew
echo.
echo.
IF %LANG% EQU 1 echo Step 2/3
IF %LANG% EQU 1 echo Repairing Steam Service
IF %LANG% EQU 1 echo Steam will open in 10 seconds. Let it start completly. Then press any button to continue...
IF %LANG% EQU 2 echo Paso 2/3
IF %LANG% EQU 2 echo Reparando Servicio de Steam
IF %LANG% EQU 2 echo Steam se abrira en 10 segundos. Deja que inicie completamente. Luego apreta cualquier tecla para continuar...
ping 127.0.0.1 -n 10 > nul
"%SteamPath%\steam.exe"
pause >nul
taskkill /F /IM Steam.exe /T
ping 127.0.0.1 -n 15 > nul
IF "%PROGRAMFILES(X86)%"=="" ( del /S /Q "%PROGRAMFILES%\Common Files\Steam\*.*" && copy "%SteamPath%\bin\steamservice.dll" "%PROGRAMFILES%\Common Files\Steam" /Y && REN "%PROGRAMFILES%\Common Files\Steam\steamservice.dll" SteamService.dll && copy "%SteamPath%\bin\secure_desktop_capture.exe" "%PROGRAMFILES%\Common Files\Steam" /Y && REN "%PROGRAMFILES%\Common Files\Steam\secure_desktop_capture.exe" secure_desktop_capture.exe && copy "%SteamPath%\bin\steamservice.exe" "%PROGRAMFILES%\Common Files\Steam" /Y && REN "%PROGRAMFILES%\Common Files\Steam\steamservice.exe" steamservice.exe && copy "%SteamPath%\bin\drivers.exe" "%PROGRAMFILES%\Common Files\Steam" /Y && REN "%PROGRAMFILES%\Common Files\Steam\drivers.exe" drivers.exe && copy "%SteamPath%\bin\service_current_versions.vdf" "%PROGRAMFILES%\Common Files\Steam" /Y && REN "%PROGRAMFILES%\Common Files\Steam\service_current_versions.vdf" service_default_Public_versions.vdf && copy "%SteamPath%\bin\service_minimum_versions.vdf" "%PROGRAMFILES%\Common Files\Steam" /Y && REN "%PROGRAMFILES%\Common Files\Steam\service_minimum_versions.vdf" service_minimum_versions.vdf && copy "%SteamPath%\bin\steamxboxutil.exe" "%PROGRAMFILES%\Common Files\Steam" /Y && REN "%PROGRAMFILES%\Common Files\Steam\steamxboxutil.exe" steamxboxutil.exe && "%PROGRAMFILES%\Common Files\Steam\steamservice.exe" /repair ) else ( del /S /Q "%PROGRAMFILES(X86)%\Common Files\Steam\*.*" && copy "%SteamPath%\bin\steamservice.dll" "%PROGRAMFILES(X86)%\Common Files\Steam" /Y && REN "%PROGRAMFILES(X86)%\Common Files\Steam\steamservice.dll" SteamService.dll && copy "%SteamPath%\bin\secure_desktop_capture.exe" "%PROGRAMFILES(X86)%\Common Files\Steam" /Y && REN "%PROGRAMFILES(X86)%\Common Files\Steam\secure_desktop_capture.exe" secure_desktop_capture.exe && copy "%SteamPath%\bin\steamservice.exe" "%PROGRAMFILES(X86)%\Common Files\Steam" /Y && REN "%PROGRAMFILES(X86)%\Common Files\Steam\steamservice.exe" steamservice.exe && copy "%SteamPath%\bin\drivers.exe" "%PROGRAMFILES(X86)%\Common Files\Steam" /Y && REN "%PROGRAMFILES(X86)%\Common Files\Steam\drivers.exe" drivers.exe && copy "%SteamPath%\bin\service_current_versions.vdf" "%PROGRAMFILES(X86)%\Common Files\Steam" /Y && REN "%PROGRAMFILES(X86)%\Common Files\Steam\service_current_versions.vdf" service_default_Public_versions.vdf && copy "%SteamPath%\bin\service_minimum_versions.vdf" "%PROGRAMFILES(X86)%\Common Files\Steam" /Y && REN "%PROGRAMFILES(X86)%\Common Files\Steam\service_minimum_versions.vdf" service_minimum_versions.vdf && copy "%SteamPath%\bin\steamxboxutil64.exe" "%PROGRAMFILES(X86)%\Common Files\Steam" /Y && REN "%PROGRAMFILES(X86)%\Common Files\Steam\steamxboxutil64.exe" steamxboxutil64.exe && "%PROGRAMFILES(X86)%\Common Files\Steam\steamservice.exe" /repair)
%SteamPath%\bin\SteamService.exe /repair
echo.
echo.
IF %LANG% EQU 1 echo Step 3/3
IF %LANG% EQU 1 echo Updating Windows
IF %LANG% EQU 2 echo Paso 3/3
IF %LANG% EQU 2 echo Actualizando Windows
FOR /F "tokens=3,4,5,6" %%a IN ( 'REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /V ProductName' ) DO set WinVer=%%a %%b %%c %%d
IF NOT "Windows 10"== "%WinVer:0,10%" ( wuauclt.exe /resetauthorization /detectnow /updatenow ) else ( UsoClient ScanInstallWait && UsoClient StartInstall )
DEL /F /S /Q %SteamPath%\Steam.exe.old
DEL /F /S /Q %SteamPath%\.crash
echo.
echo.
IF %LANG% EQU 1 echo Thanks for using this program.
IF %LANG% EQU 1 echo Remember to sign my profile if it was useful.
IF %LANG% EQU 2 echo Gracias por utilizar este programa.
IF %LANG% EQU 2 echo Recuerda firmar mi perfil si te ha servido.
start "" "https://steamcommunity.com/profiles/76561197976712345"
IF %LANG% EQU 1 echo Press any key to quit.
IF %LANG% EQU 2 echo Pulsa cualquier tecla para salir.
pause >nul
exit