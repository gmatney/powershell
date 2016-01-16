$currentPrincipal = New-Object Security.Principal.WindowsPrincipal( [Security.Principal.WindowsIdentity]::GetCurrent() )
$lastTitle=$host.UI.RawUI.WindowTitle
$verMajor=$PSVersionTable.PSVersion.Major
$verMinor=$PSVersionTable.PSVersion.Minor
$ver=$verMajor.ToSTring()+"."+$verMinor.ToSTring()
if ($currentPrincipal.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator ))	{
	(get-host).UI.RawUI.Backgroundcolor="DarkRed"
	clear-host
	write-host "Warning: PowerShell is running as an Administrator.`n"
	$host.UI.RawUI.WindowTitle = "(ADMIN)  ($ver)" 
}
else{
	$host.UI.RawUI.WindowTitle = "(NOT ADMIN)  ($ver)" 
}
