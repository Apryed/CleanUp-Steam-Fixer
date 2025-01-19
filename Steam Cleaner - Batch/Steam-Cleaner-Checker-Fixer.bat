@ECHO off
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
FOR /F "tokens=3" %%a IN ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\Language" /v Default') DO SET UILanguage=%%a
IF %UILanguage% EQU 0c0a ( CHCP 65001 )
IF %UILanguage% EQU 0c0a ( TITLE Limpiador, Comprobador y reparador de Steam por Apryed - v1.2.0 )
FOR /F "tokens=3" %%a IN ('REG QUERY "HKEY_CURRENT_USER\Software\Valve\Steam" /v SteamPath') DO SET SteamPath=%%a
SET SteamPath=%SteamPath:/=\%
FOR /F "tokens=3" %%a IN ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PROCESSOR_ARCHITECTURE') DO SET Bits=%%a
FOR /F "tokens=3,4,5,6" %%a IN ( 'REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /V ProductName' ) DO SET WinVer=%%a %%b %%c %%d
COLOR A
SET res=F
CLS
PUSHD %~dp0
IF "%1" == "" GOTO Start
IF %1 == Part1 GOTO %1
IF %1 == part1 GOTO %1
IF %1 == Part2 GOTO %1
IF %1 == part2 GOTO %1
IF %UILanguage% EQU 0c0a ( ECHO Opción de lanzamiento no valida. ) ELSE ( ECHO Launch option NOT valid. )
PAUSE
EXIT
:START
IF %UILanguage% EQU 0c0a ( CHOICE /M "Quiere ir a la Parte 2" ) ELSE ( CHOICE /M "Do you want to go to Part 2" )
IF %ERRORLEVEL% == 1 GOTO Part2
:Part1
IF %UILanguage% EQU 0c0a ( ECHO Parte 1/2 && ECHO Paso 1/7 && ECHO Cerrando Steam ) ELSE ( ECHO Part 1/2 && ECHO Step 1/7 && ECHO Closing Steam )
taskkill /F /IM Steam.exe /T
ECHO.
ECHO.
IF %UILanguage% EQU 0c0a ( ECHO Paso 2/7 && ECHO Limpiando Steam ) ELSE ( ECHO Step 2/7 && ECHO Cleaning Steam )
PUSHD %SteamPath%
FOR /D %%a IN (*.*) DO IF NOT "%%a"=="config" IF NOT "%%a"=="steamapps" IF NOT "%%a"=="userdata" RD /s /q "%%a"
FOR %%a IN (*.*) DO IF NOT "%%a"=="Steam.exe" IF NOT "%%a"=="steam.exe" IF NOT "%%a"=="Uninstall.exe" IF NOT "%%a"=="uninstall.exe" IF NOT "%%a"=="steam.signatures" DEL /F /Q "%%a"
POPD
ECHO.
ECHO.
IF %UILanguage% EQU 0c0a ( ECHO Paso 3/7 && ECHO Restaurando opciones de inicio a las predeterminadas ) ELSE ( ECHO Step 3/7 && ECHO Restoring boot settings to default )
bcdedit /deletevalue nointegritychecks
bcdedit /deletevalue loadoptions
bcdedit /debug off
bcdedit /deletevalue nx
ECHO.
ECHO.
IF %UILanguage% EQU 0c0a ( ECHO Paso 4/7 && ECHO Comprobando Windows en busca de datos corruptos ) ELSE ( ECHO Step 4/7 && ECHO Checking Windows FOR corruption )
Dism /Online /Cleanup-Image /CheckHealth
ECHO.
ECHO.
IF %UILanguage% EQU 0c0a ( ECHO Paso 5/7 && ECHO Escaneando Windows en busca de datos corruptos ( Comprobando que se necesita para repararlo ^) ) ELSE ( ECHO Step 5/7 && ECHO Scaning Windows FOR corruption ( Checking what is needed to repair it ^) )
Dism /Online /Cleanup-Image /ScanHealth
ECHO.
ECHO.
IF %UILanguage% EQU 0c0a ( ECHO Paso 6/7 && ECHO Reparando la salud de Windows ) ELSE ( ECHO Step 6/7 && ECHO Reparing Windows Health )
DISM /Online /Cleanup-Image /RestoreHealth
ECHO.
ECHO.
IF %UILanguage% EQU 0c0a ( ECHO Paso 7/7 && ECHO Comprobando y Reparando el Sistema ) ELSE ( ECHO Step 7/7 && ECHO Checking and Repairing System )
SFC /scannow
ECHO.
ECHO.
ECHO ^<?xml version='1.0' encoding='UTF-16'?^>^<Task version='1.3' xmlns='http://schemas.microsoft.com/windows/2004/02/mit/task'^>^<RegistrationInfo^>^<Date^>2021-05-14T14:16:11.9510053^</Date^>^<Author^>Apryed^</Author^>^<URI^>\Steam-Cleaner^</URI^>^</RegistrationInfo^>^<Triggers^>^<LogonTrigger^>^<EndBoundary^>3109-12-31T23:59:59^</EndBoundary^>^<Enabled^>true^</Enabled^>^</LogonTrigger^>^</Triggers^>^<Principals^>^<Principal id='Author'^>^<GroupId^>S-1-5-32-544^</GroupId^>^<RunLevel^>HighestAvailable^</RunLevel^>^</Principal^>^</Principals^>^<Settings^>^<MultipleInstancesPolicy^>IgnoreNew^</MultipleInstancesPolicy^>^<DisallowStartIfOnBatteries^>false^</DisallowStartIfOnBatteries^>^<StopIfGoingOnBatteries^>false^</StopIfGoingOnBatteries^>^<AllowHardTerminate^>false^</AllowHardTerminate^>^<StartWhenAvailable^>false^</StartWhenAvailable^>^<RunOnlyIfNetworkAvailable^>false^</RunOnlyIfNetworkAvailable^>^<IdleSettings^>^<StopOnIdleEnd^>true^</StopOnIdleEnd^>^<RestartOnIdle^>false^</RestartOnIdle^>^</IdleSettings^>^<AllowStartOnDemand^>false^</AllowStartOnDemand^>^<Enabled^>true^</Enabled^>^<Hidden^>false^</Hidden^>^<RunOnlyIfIdle^>false^</RunOnlyIfIdle^>^<DisallowStartOnRemoteAppSession^>false^</DisallowStartOnRemoteAppSession^>^<UseUnifiedSchedulingEngine^>true^</UseUnifiedSchedulingEngine^>^<WakeToRun^>false^</WakeToRun^>^<ExecutionTimeLimit^>PT0S^</ExecutionTimeLimit^>^<DeleteExpiredTaskAfter^>PT0S^</DeleteExpiredTaskAfter^>^<Priority^>7^</Priority^>^</Settings^>^<Actions Context='Author'^>^<Exec^>^<Command^>%~f0^</Command^>^<Arguments^>Part2^</Arguments^>^</Exec^>^</Actions^>^</Task^>>"%~dp0Task.xml"
schtasks.exe /Create /XML %~dp0task.xml /tn Steam-Cleaner
DEL /F /S /Q %~dp0task.xml
GOTO RESTART
:Part2
IF %UILanguage% EQU 0c0a ( ECHO Parte 2/2 && ECHO Paso 1/3 && ECHO Renovando DNS ) ELSE ( ECHO Part 2/2 && ECHO Step 1/3 && ECHO Flushing DNS )
ipconfig /release
ipconfig /flushdns
ipconfig /renew
ECHO.
ECHO.
IF %UILanguage% EQU 0c0a ( ECHO Paso 2/3 && ECHO Reparando Servicio de Steam && ECHO Steam se abrira en 10 segundos. Deja que inicie completamente. Luego apreta cualquier tecla para continuar... ) ELSE ( ECHO Step 2/3 && ECHO Repairing Steam Service && ECHO Steam will open in 10 seconds. Let it start completly. Then press any button to continue... )
ping 127.0.0.1 -n 10 > nul
"%SteamPath%\steam.exe"
PAUSE >nul
taskkill /F /IM Steam.exe /T
IF %Bits% EQU "x86" ( COPY "%SteamPath%\bin\steamservice.dll" "%PROGRAMFILES%\Common Files\Steam" /Y && REN "%PROGRAMFILES%\Common Files\Steam\steamservice.dll" SteamService.dll && COPY "%SteamPath%\bin\secure_desktop_capture.exe" "%PROGRAMFILES%\Common Files\Steam" /Y && REN "%PROGRAMFILES%\Common Files\Steam\secure_desktop_capture.exe" secure_desktop_capture.exe && COPY "%SteamPath%\bin\steamservice.exe" "%PROGRAMFILES%\Common Files\Steam" /Y && REN "%PROGRAMFILES%\Common Files\Steam\steamservice.exe" steamservice.exe && COPY "%SteamPath%\bin\drivers.exe" "%PROGRAMFILES%\Common Files\Steam" /Y && REN "%PROGRAMFILES%\Common Files\Steam\drivers.exe" drivers.exe ) ELSE ( COPY "%SteamPath%\bin\steamservice.dll" "%PROGRAMFILES(X86)%\Common Files\Steam" /Y && REN "%PROGRAMFILES(X86)%\Common Files\Steam\steamservice.dll" SteamService.dll && COPY "%SteamPath%\bin\secure_desktop_capture.exe" "%PROGRAMFILES(X86)%\Common Files\Steam" /Y && REN "%PROGRAMFILES(X86)%\Common Files\Steam\secure_desktop_capture.exe" secure_desktop_capture.exe && COPY "%SteamPath%\bin\steamservice.exe" "%PROGRAMFILES(X86)%\Common Files\Steam" /Y && REN "%PROGRAMFILES(X86)%\Common Files\Steam\steamservice.exe" steamservice.exe && COPY "%SteamPath%\bin\drivers.exe" "%PROGRAMFILES(X86)%\Common Files\Steam" /Y && REN "%PROGRAMFILES(X86)%\Common Files\Steam\drivers.exe" drivers.exe )
%SteamPath%\bin\SteamService.exe /repair
ECHO.
ECHO.
IF %UILanguage% EQU 0c0a ( ECHO Paso 3/3 && ECHO Actualizando Windows ) ELSE ( ECHO Step 3/3 && ECHO Updating Windows )
IF NOT "Windows 10" == "%WinVer:0,10%" ( wuauclt.exe /resetauthorization /detectnow /updatenow ) ELSE ( UsoClient ScanInstallWait && UsoClient StartInstall )
DEL /F /S /Q %SteamPath%\Steam.exe.old
DEL /F /S /Q %SteamPath%\.crash
IF %1 EQU Part2 ( schtasks /delete /tn Steam-Cleaner /f )
ECHO.
ECHO.
:QUIT
IF %UILanguage% EQU 0c0a ( ECHO Gracias por utilizar este programa. && ECHO Recuerda firmar mi perfil si te ha servido. && ECHO Pulsa cualquier tecla para salir. ) ELSE ( ECHO Thanks FOR using this program. && ECHO Remember to sign my profile IF it was useful. && ECHO Press any key to quit. )
start "" "https://steamcommunity.com/profiles/76561197976712345"
PAUSE >nul
EXIT
:RESTART
CLS
IF %UILanguage% EQU 0c0a ( ECHO Su PC se va a reinciar. Salve cualquier cosa importante antes de continuar. Pulse cualquier tecla cuando este listo... ) ELSE ( ECHO Your pc is going to be restarted. Save anything important before continuing. Press any key when you are ready... )
PAUSE >nul
shutdown /f /r /t 0
EXIT