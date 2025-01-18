$script:MDM = DATA { ConvertFrom-StringData -StringData @'
# English strings
1=Enter your choice
2=\nInvalid choice. Please try again...\n
'@}
Import-LocalizedData -BindingVariable "MDM" -BaseDirectory "$($PSScriptRoot)\..\Langs" -FileName "Module_DM.psd1" -ErrorAction:SilentlyContinue
function DisplayMenu($Data){
	Write-Host "`r`n`r`n$($Data[0])"
	$ChCount = 0
	$lastIndex = $Data[1].Count-1
	# Get the length of the last index
	$lengthOfLastIndex = $lastIndex.ToString().Length
	$Data[1] | ForEach-Object {
		$ELen=$_.Name.Length + $lengthOfLastIndex + 3 + 1
		if ($ChCount -lt $ELen ){ $ChCount = $ELen} }
	Write-Host $("="*$ChCount)
	for ($i = 0; $i -lt $Data[1].Length; $i++) {
		Write-Host "$i - $($Data[1][$i].Name)"
	}
	Write-Host `r`n
	$uCh = Read-Host $([string]::Format($MDM.'1'))
	if ( -Not ($Data[1][$uCh])){
		Write-Host $([string]::Format($MDM.'2'))
		return DisplayMenu $Data
	}
	return $uCh, $Data[1][$uCh].Name
}
function CopyCom($Dir,$Path){
	Get-ChildItem -Path "${Dir}\Common Files\Steam" | Where-Object { $_.Name -notin "drivers" } | Remove-Item -Recurse -Force
	Copy-Item -Path "${Path}\bin\drivers.exe", "${Path}\bin\secure_desktop_capture.exe", "${Path}\bin\service_current_versions.vdf", "${Path}\bin\service_minimum_versions.vdf", "${Path}\bin\steamservice.dll", "${Path}\bin\steamservice.exe", "${Path}\bin\steamxboxutil64.exe" -Destination "${Dir}\Common Files\Steam"
	Rename-Item -Path "${Dir}\Common Files\Steam\service_current_versions.vdf" -NewName "service_default_Public_versions.vdf"
	Rename-Item -Path "${Dir}\Common Files\Steam\steamservice.dll" -NewName "SteamService.dll"
	Start-Process -FilePath "${Dir}\Common Files\Steam\SteamService.exe" -ArgumentList "/repair" -Wait
}