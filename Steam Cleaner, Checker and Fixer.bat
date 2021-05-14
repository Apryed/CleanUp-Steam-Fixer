@echo off
FOR /F "tokens=3" %%a IN ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\Language" /v Default') DO set UILanguage=%%a
IF %UILanguage% EQU 0c0a ( title Limpiador, Comprobador y reparador de Steam por Apryed - v1.1.0.A ) ELSE ( title Steam Cleaner, Checker and Fixer By Apryed - v1.1.0.A )
FOR /F "tokens=3" %%a IN ('REG QUERY "HKEY_CURRENT_USER\Software\Valve\Steam" /v SteamPath') DO set SteamPath=%%a
set SteamPath=%SteamPath:/=\%
FOR /F "tokens=3" %%a IN ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PROCESSOR_ARCHITECTURE') DO set Bits=%%a
FOR /F "tokens=3,4,5,6" %%a IN ( 'REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /V ProductName' ) DO set WinVer=%%a %%b %%c %%d
Color A
cls
pushd %~dp0
IF %1 EQU Part2 GOTO Part2
IF %UILanguage% EQU 0c0a ( CHOICE /M "Quiere ir a la Parte 2" ) else ( CHOICE /M "Do you want to go to Part 2" )
IF %ERRORLEVEL% == 1 GOTO Part2
IF %UILanguage% EQU 0c0a ( echo Parte 1/2 ) ELSE ( echo Part 1/2 )
IF %UILanguage% EQU 0c0a ( echo Paso 1/7 ) ELSE ( echo Step 1/7 )
IF %UILanguage% EQU 0c0a ( echo Cerrando Steam ) ELSE ( echo Closing Steam )
taskkill /F /IM Steam.exe /T
echo.
echo.
IF %UILanguage% EQU 0c0a ( echo Paso 2/7 ) ELSE ( echo Step 2/7 )
IF %UILanguage% EQU 0c0a ( echo Limpiando Steam ) ELSE ( echo Cleaning Steam )
pushd %SteamPath%
dir /a /b | findstr "ssfn" > Z.txt
for /f "tokens=1*delims=[]" %%a in ('find /n /v "" Z.txt') do set "entry%%a=%%b"
for /D %%a in (*.*) do if not "%%a"=="config" if not "%%a"=="steamapps" if not "%%a"=="userdata" RD /s /q "%%a"
for %%a in (*.*) do if not "%%a"=="Steam.exe" if not "%%a"=="steam.exe" if not "%%a"=="Uninstall.exe" if not "%%a"=="uninstall.exe" if not "%%a"=="%entry1%" if not "%%a"=="%entry2%" DEL /F /Q "%%a"
popd
echo.
echo.
IF %UILanguage% EQU 0c0a ( echo Paso 3/7 ) ELSE ( echo Step 3/7 )
IF %UILanguage% EQU 0c0a ( echo Restaurando opciones de inicio a las predeterminadas ) ELSE ( echo Restoring boot settings to default )
bcdedit /deletevalue nointegritychecks
bcdedit /deletevalue loadoptions
bcdedit /debug off
bcdedit /deletevalue nx
echo.
echo.
IF %UILanguage% EQU 0c0a ( echo Paso 4/7 ) ELSE ( echo Step 4/7 )
IF %UILanguage% EQU 0c0a ( echo Comprobando Windows en busca de datos corruptos ) ELSE ( echo Checking Windows for corruption )
Dism /Online /Cleanup-Image /CheckHealth
echo.
echo.
IF %UILanguage% EQU 0c0a ( echo Paso 5/7 ) ELSE ( echo Step 5/7 )
IF %UILanguage% EQU 0c0a ( echo Escaneando Windows en busca de datos corruptos ( Comprobando que se necesita para repararlo ^) ) ELSE ( echo Scaning Windows for corruption ( Checking what is needed to repair it ^) )
Dism /Online /Cleanup-Image /ScanHealth
echo.
echo.
IF %UILanguage% EQU 0c0a ( echo Paso 6/7 ) ELSE ( echo Step 6/7 )
IF %UILanguage% EQU 0c0a ( echo Reparando la salud de Windows ) ELSE ( echo Reparing Windows Health )
DISM /Online /Cleanup-Image /RestoreHealth
echo.
echo.
IF %UILanguage% EQU 0c0a ( echo Paso 7/7 ) ELSE ( echo Step 7/7 )
IF %UILanguage% EQU 0c0a ( echo Comprobando y Reparando el Sistema ) ELSE ( echo Checking and Repairing System )
SFC /scannow
echo.
echo.
echo ^<?xml version='1.0' encoding='UTF-16'?^>^<Task version='1.3' xmlns='http://schemas.microsoft.com/windows/2004/02/mit/task'^>^<RegistrationInfo^>^<Date^>2021-05-14T14:16:11.9510053^</Date^>^<Author^>Apryed^</Author^>^<URI^>\Steam-Cleaner^</URI^>^</RegistrationInfo^>^<Triggers^>^<LogonTrigger^>^<EndBoundary^>3109-12-31T23:59:59^</EndBoundary^>^<Enabled^>true^</Enabled^>^</LogonTrigger^>^</Triggers^>^<Principals^>^<Principal id='Author'^>^<GroupId^>S-1-5-32-544^</GroupId^>^<RunLevel^>HighestAvailable^</RunLevel^>^</Principal^>^</Principals^>^<Settings^>^<MultipleInstancesPolicy^>IgnoreNew^</MultipleInstancesPolicy^>^<DisallowStartIfOnBatteries^>false^</DisallowStartIfOnBatteries^>^<StopIfGoingOnBatteries^>false^</StopIfGoingOnBatteries^>^<AllowHardTerminate^>false^</AllowHardTerminate^>^<StartWhenAvailable^>false^</StartWhenAvailable^>^<RunOnlyIfNetworkAvailable^>false^</RunOnlyIfNetworkAvailable^>^<IdleSettings^>^<StopOnIdleEnd^>true^</StopOnIdleEnd^>^<RestartOnIdle^>false^</RestartOnIdle^>^</IdleSettings^>^<AllowStartOnDemand^>false^</AllowStartOnDemand^>^<Enabled^>true^</Enabled^>^<Hidden^>false^</Hidden^>^<RunOnlyIfIdle^>false^</RunOnlyIfIdle^>^<DisallowStartOnRemoteAppSession^>false^</DisallowStartOnRemoteAppSession^>^<UseUnifiedSchedulingEngine^>true^</UseUnifiedSchedulingEngine^>^<WakeToRun^>false^</WakeToRun^>^<ExecutionTimeLimit^>PT0S^</ExecutionTimeLimit^>^<DeleteExpiredTaskAfter^>PT0S^</DeleteExpiredTaskAfter^>^<Priority^>7^</Priority^>^</Settings^>^<Actions Context='Author'^>^<Exec^>^<Command^>%~f0^</Command^>^<Arguments^>Part2^</Arguments^>^</Exec^>^</Actions^>^</Task^>>"%~dp0Task.xml"
schtasks.exe /Create /XML %~dp0task.xml /tn Steam-Cleaner
del /F /S /Q %~dp0task.xml
GOTO RESTART
:Part2
IF %UILanguage% EQU 0c0a ( echo Parte 2/2 ) ELSE ( echo Part 2/2 )
IF %UILanguage% EQU 0c0a ( echo Paso 1/3 ) ELSE ( echo Step 1/3 )
IF %UILanguage% EQU 0c0a ( echo Renovando DNS ) ELSE ( echo Flushing DNS )
ipconfig /release
ipconfig /flushdns
ipconfig /renew
echo.
echo.
IF %UILanguage% EQU 0c0a ( echo Paso 2/3 ) ELSE ( echo Step 2/3 )
IF %UILanguage% EQU 0c0a ( echo Reparando Servicio de Steam ) ELSE ( echo Repairing Steam Service )
IF %UILanguage% EQU 0c0a ( echo Abre Steam, deja que inicie completamente. Luego apreta cualquier tecla para continuar... ) ELSE ( echo Open Steam, let it open completly. Then press any button to continue... )
pause >nul
taskkill /F /IM Steam.exe /T
IF %Bits% EQU "x86" ( copy "%SteamPath%\bin\steamservice.dll" "%PROGRAMFILES%\Common Files\Steam" /Y && REN "%PROGRAMFILES%\Common Files\Steam\steamservice.dll" SteamService.dll && copy "%SteamPath%\bin\secure_desktop_capture.exe" "%PROGRAMFILES%\Common Files\Steam" /Y && REN "%PROGRAMFILES%\Common Files\Steam\secure_desktop_capture.exe" secure_desktop_capture.exe && copy "%SteamPath%\bin\steamservice.exe" "%PROGRAMFILES%\Common Files\Steam" /Y && REN "%PROGRAMFILES%\Common Files\Steam\steamservice.exe" steamservice.exe && copy "%SteamPath%\bin\drivers.exe" "%PROGRAMFILES%\Common Files\Steam" /Y && REN "%PROGRAMFILES%\Common Files\Steam\drivers.exe" drivers.exe ) else ( copy "%SteamPath%\bin\steamservice.dll" "%PROGRAMFILES(X86)%\Common Files\Steam" /Y && REN "%PROGRAMFILES(X86)%\Common Files\Steam\steamservice.dll" SteamService.dll && copy "%SteamPath%\bin\secure_desktop_capture.exe" "%PROGRAMFILES(X86)%\Common Files\Steam" /Y && REN "%PROGRAMFILES(X86)%\Common Files\Steam\secure_desktop_capture.exe" secure_desktop_capture.exe && copy "%SteamPath%\bin\steamservice.exe" "%PROGRAMFILES(X86)%\Common Files\Steam" /Y && REN "%PROGRAMFILES(X86)%\Common Files\Steam\steamservice.exe" steamservice.exe && copy "%SteamPath%\bin\drivers.exe" "%PROGRAMFILES(X86)%\Common Files\Steam" /Y && REN "%PROGRAMFILES(X86)%\Common Files\Steam\drivers.exe" drivers.exe )
%SteamPath%\bin\SteamService.exe /repair
echo.
echo.
IF %UILanguage% EQU 0c0a ( echo Paso 3/3 ) ELSE ( echo Step 3/3 )
IF %UILanguage% EQU 0c0a ( echo Actualizando Windows ) ELSE ( echo Updating Windows )
IF NOT "Windows 10" == "%WinVer:0,10%" ( wuauclt.exe /resetauthorization /detectnow /updatenow ) else ( UsoClient ScanInstallWait && UsoClient StartInstall )
DEL /F /S /Q %SteamPath%\Steam.exe.old
DEL /F /S /Q %SteamPath%\.crash
IF %1 EQU Part2 ( schtasks /delete /tn Steam-Cleaner /f )
echo.
echo.
:QUIT
IF %UILanguage% EQU 0c0a ( echo Gracias por utilizar este programa. ) ELSE ( echo Thanks for using this program. )
IF %UILanguage% EQU 0c0a ( echo Recuerda firmar mi perfil si te ha servido. ) ELSE ( echo Remember to sign my profile if it was useful. )
start "" "https://steamcommunity.com/profiles/76561197976712345"
IF %UILanguage% EQU 0c0a ( echo Pulsa cualquier tecla para salir. ) ELSE ( echo Press any key to quit. )
pause >nul
exit
:RESTART
cls
IF %UILanguage% EQU 0c0a ( echo Su PC se va a reinciar. Salve cualquier cosa importante antes de continuar. Pulse cualquier tecla cuando este listo... ) ELSE ( echo Your pc is going to be restarted. Save anything important before continuing. Press any key when you are ready... )
pause >nul
shutdown /f /r /t 0
exit