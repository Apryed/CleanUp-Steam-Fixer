@echo off
pushd %~dp0
PowerShell.exe -command {Get-ChildItem -Path "%~dp0" -Recurse | Unlock-File}
REM PowerShell.exe -NoProfile -ExecutionPolicy RemoteSigned -File "%~dp0SteamCleaner.ps1"
popd
pause