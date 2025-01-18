param (
	[string]$PathSteam,
	[switch]$Part
)
$script:TaskName = "Steam Cleaner"
$script:MSGs = DATA { ConvertFrom-StringData -StringData @'
# English strings
1=This Program requieres Administrator permissions to run properly.\nClosing program...
2=Checking Steam Install Path...
3=Steam folder found at "{0}".
4=Steam folder not found.
5=Error searching for Steam folder.
6=Type your Steam Path Location.\n  Examples:\n    %PROGRAMFILES(X86)%\\Steam\n    C:\\Program Files(x86)\\Steam\n    C:\\Games\\Steam\\\n\nPath
7=Selected Path: "{0}"
8="config", "steamapps", "userdata", "steam.exe", "uninstall.exe" or "steam.signatures" are not present in the folder "{0}".
9=Would you like to try again?
10=1/2 - 1/6 - Closing Steam...
11=1/2 - 2/6 - Cleaning Steam...
12a=1/2 - 3/6 - Skipping - SecureBoot is Enabled.
12b=1/2 - 3/6 - Resetting PC start options to default...
13=1/2 - 4/6 - Deep Checking Windows for corrupted data...
14=1/2 - 5/6 - Fixing Windows Health...
15=1/2 - 6/6 - Checking/Repairing OS...
16=Scheduling task for part 2
17=Your pc is going to be restarted. Save anything important before continuing.\n\nPress any key when you are ready...
18=2/2 - 1/3 - Renewing IP and DNS...
19=2/2 - 2/3 - Repairing Steam Service...\nSteam will start now.
20=Wait till Steam opens completely, then press any buttons...
21=2/2 - 3/3 - Updating Windows...
22=Thanks for using this program.\nRemember to sign my profile if it was useful.\n\nPress any key when you are ready...
Part1=Part 1/2
Part2=Part 2/2
Yes=Yes
No=No
Bye=Please, came again once you really want to refresh Steam.
Title={0} By Apryed - v0.1.2b_18-01-2025
'@}
$host.ui.RawUI.WindowTitle = $([string]::Format($MSGs.'TITLE',$TaskName))
# Imports Languages
Import-LocalizedData -BindingVariable "MSGs" -BaseDirectory "$($PSScriptRoot)\Langs" -FileName "Msgs.psd1" -ErrorAction:SilentlyContinue
# Check if PowerShell was launched as Admin
Switch (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){
	$True {
		# Start of the program
		Import-Module -Name ".\Modules\SteamCleaner.psm1" -Force
		Clear-Host
		Switch ($Part){
			$False {
				Write-Host $MSGs.'2'
				# Checks for Steam Instalation directory.
				if ($PathSteam) {
					$SteamPath = $PathSteam
					$allExist = ("config", "steamapps", "userdata", "steam.exe", "uninstall.exe", "steam.signatures" | ForEach-Object { Test-Path "$SteamPath\$_" }) -notcontains $false
					if ($allExist -Like $False){
						Write-Host $([string]::Format($MSGs.'8', $SteamPath))
					}
				} else {
					try {
						$SteamPath = (Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*", "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" -Include "Steam").UninstallString.trim("\uninstall.exe")
						$allExist = ("config", "steamapps", "userdata", "steam.exe", "uninstall.exe", "steam.signatures" | ForEach-Object { Test-Path "$SteamPath\$_" }) -notcontains $false
					} catch {
						$null
					}
				}
				# If Previous check match, it will auto work on the folder. If not, it will ask for the directoy.
				Switch ($SteamPath){
					{ ($_ -like "?:\*") -and ($allExist -like $True) } {
						Write-Host $([string]::Format($MSGs.'3', $SteamPath))
					}
					DEFAULT {
						while ( ( ($allExist -NotLike $TRUE) -and ($Loop -NotLike 0) ) -or ( $SteamPath -Like $null ) ) {
							$SteamPath = (Read-Host $([string]::Format($MSGs.'6'))).Trim()
							<# Transforms Enviromental to String #>
							if ( (($SteamPath -Split "\\")[0]) -like "%*%" ){
								$SteamPath = @(($SteamPath -Split "\\")[0].trim("%"),($SteamPath -Split "\\")[1..$($SteamPath.Length-1)])
								$SteamPath = [System.Environment]::GetEnvironmentVariable($SteamPath[0])+"\"+($SteamPath[1] -join "\")
							}
							# Removes the "\" at the end of the route, in case it was implemented.
							if ($SteamPath[$SteamPath.Length-1] -like "\") { $SteamPath = $SteamPath.Substring(0,$SteamPath.Length-1) }
							$allExist = ("config", "steamapps", "userdata", "steam.exe", "uninstall.exe", "steam.signatures" | ForEach-Object { Test-Path "$SteamPath\$_" }) -notcontains $false
							if (-not $allExist){
								Write-Host $([string]::Format($MSGs.'8', $SteamPath))
								$Loop = (DisplayMenu ( $([string]::Format($MSGs.'9')), @( @{Name=$([string]::Format($MSGs.'No'))},@{Name=$([string]::Format($MSGs.'Yes'))} )))[0]
							}
						}
					}
				}
				Switch ( ($allExist -Like $True) -or ($Loop -NotLike 0) ){
					{$_} {
						# WORK
						Write-Host $([string]::Format($MSGs.'7', $SteamPath))
						Write-Host $([string]::Format($MSGs.'Part1'))
						Write-Host $([string]::Format($MSGs.'10'))
						# Fully Close Steam
						try {
							(Get-Process "steamservice", "Steam").id 2>$null | ForEach-Object {
								Stop-Process -Id $_ -Force
								Wait-Process -Id $_
							}
							Start-Sleep -Seconds 5
						} catch {
							$null
						}
						# Cleaning Steam
						Write-Host $([string]::Format($MSGs.'11'))
						Get-ChildItem -Path $SteamPath | Where-Object { $_.Name -notin "config", "steamapps", "userdata", "config", "steamapps", "userdata", "steam.exe", "uninstall.exe", "steam.signatures" } | Remove-Item -Recurse -Force
						# Default Windows Start Parameters
						$SecureBootStatus = (Get-CimInstance -Namespace "root\WMI" -ClassName "MS_SecureBoot").SecureBootEnabled
						if ($SecureBootStatus -eq $true) {
							Write-Host $([string]::Format($MSGs.'12a'))
						} else {
							Write-Host $([string]::Format($MSGs.'12b'))
							bcdedit /deletevalue nointegritychecks
							bcdedit /deletevalue loadoptions
							bcdedit /debug off
							bcdedit /deletevalue nx
						}
						# Deep Checking Windows for corruption
						Write-Host $([string]::Format($MSGs.'13'))
						Repair-WindowsImage -Online -ScanHealth
						# Reparing Windows Health
						Write-Host $([string]::Format($MSGs.'14'))
						Repair-WindowsImage -Online -RestoreHealth
						# Checking and Repairing System
						Write-Host $([string]::Format($MSGs.'15'))
						SFC /scannow
						# Scheduling Task
						Write-Host $([string]::Format($MSGs.'16'))
						if (Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue) {
							Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
						}
						$Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -WorkingDirectory "${PSScriptRoot}" -Argument "-ExecutionPolicy Bypass -Command `".\SteamCleaner.ps1 -PathSteam '${SteamPath}' -Part`""
						$Principal = New-ScheduledTaskPrincipal -GroupId "S-1-5-32-544" -RunLevel Highest
						$Trigger = New-ScheduledTaskTrigger -AtLogon
						$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable
						Register-ScheduledTask -Action $Action -Principal $Principal -Trigger $Trigger -Settings $Settings -TaskName $TaskName -Description "${TaskName} Task" | Out-Null
						Write-Host $([string]::Format($MSGs.'17'))
						[System.Console]::ReadKey($true) | Out-Null
						Restart-Computer -Force
					}
					DEFAULT {
						# QUIT Without Working
						Write-Host $([string]::Format($MSGs.'Bye'))
					}
				}
			}
			$True {
				Write-Host $([string]::Format($MSGs.'Part2'))
				# FLUSHDNS
				Write-Host $([string]::Format($MSGs.'18'))
				Get-NetAdapter | Foreach-object { Disable-NetAdapter -Name $_.Name -Confirm:$false }
				Clear-DnsClientCache
				Get-NetAdapter | Foreach-object { Enable-NetAdapter -Name $_.Name }
				$script:elapsed = 0
				Do {
					Start-Sleep -Seconds 5
					$elapsed += 5
				} While ( -Not (Get-NetAdapter | Where-Object { $_.Status -eq "Up" -and $_.LinkSpeed -gt 0 }) -and $elapsed -lt 30)
				# Repairing Steam Service
				Write-Host $([string]::Format($MSGs.'19'))
				while ( -Not (Get-Process "Steam" -ErrorAction SilentlyContinue) ){
					Start-Process "${PathSteam}\steam.exe"
					Start-Sleep -Seconds 5
				}
				Write-Host $([string]::Format($MSGs.'20'))
				[System.Console]::ReadKey($true) | Out-Null
				# Fully Close Steam AGAIN
				try {
					(Get-Process "steamservice", "Steam" -ErrorAction SilentlyContinue).id 2>$null | ForEach-Object {
						Stop-Process -Id $_ -Force
						Wait-Process -Id $_
					}
					Start-Sleep -Seconds 5
				} catch {
					$null
				}
				Switch ([Environment]::Is64BitProcess) {
					$True{
						CopyCom ${env:ProgramFiles(x86)} ${PathSteam}
					}
					$False{
						CopyCom ${env:ProgramFiles} ${PathSteam}
					}
				}
				Start-Process -FilePath "${PathSteam}\bin\SteamService.exe" -ArgumentList "/repair" -Wait
				Write-Host $([string]::Format($MSGs.'21'))
				Switch (([System.Environment]::OSVersion.Version).Major){
					{$_ -GE 10}{
						Invoke-Expression -Command "UsoClient.exe ScanInstallWait"
						Invoke-Expression -Command "UsoClient.exe StartInstall"
					}
					{$_ -LT 10}{
						Invoke-Expression -Command "wuauclt.exe /detectnow"
						Invoke-Expression -Command "wuauclt.exe /updatenow"
					}
				}
				Start-Process "https://steamcommunity.com/profiles/76561197976712345"
				Get-ChildItem -Path $PathSteam | Where-Object { $_.Name -in "*.old", ".crash" } | Remove-Item -Force
				Write-Host $([string]::Format($MSGs.'22'))
				[System.Console]::ReadKey($true) | Out-Null
				if (Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue) {
					Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
				}
			}
		}
		Remove-Module -Name "SteamCleaner" -Force
	}
	$False {
		Write-Host $MSGs.'1'
	}
}