@echo off
pushd %~dp0
PowerShell.exe -NoProfile -ExecutionPolicy RemoteSigned -File "%~dp0SteamCleaner.ps1"
popd
pause