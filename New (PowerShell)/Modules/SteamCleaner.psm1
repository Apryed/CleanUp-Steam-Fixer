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
	$uCh = Read-Host "Enter your choice"
	if ( -Not ($Data[1][$uCh])){
		Write-Host "`r`nInvalid choice. Please try again.`r`n"
		return DisplayMenu $Data
	}
	return $uCh, $Data[1][$uCh].Name
}