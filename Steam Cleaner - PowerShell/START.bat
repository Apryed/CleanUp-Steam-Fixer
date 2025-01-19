@echo off
pushd %~dp0
PowerShell.exe -Command "Get-ChildItem -Path '%~dp0' -Recurse | Unblock-File"
PowerShell.exe -NoProfile -ExecutionPolicy RemoteSigned -File "%~dp0SteamCleaner.ps1"
popd
pause