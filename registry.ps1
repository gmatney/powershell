# Example usage registry_set "HKLM:/Software/YourApp/Something"  "name"  "value"
# May need to do as Admin
# TODO:  look into   [Microsoft.Win32.Registry]::SetValue
function registry_set($registryPath, $name, $value){
	Write-Output("RegistryPath:$registryPath")
	Write-Output("Name:        $name")
	Write-Output("Value:       $value")
	if(!(Test-Path $registryPath)){
		New-Item -Path $registryPath -Force | Out-Null
	}
	New-ItemProperty -Path $registryPath -Name "$name" -Value "$value"
}
