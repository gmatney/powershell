

function detect_assemblies{
	gci . -include ('*.exe', '*.dll') -R |
	ForEach-Object {
		try {
			$_ | Add-Member NoteProperty FileVersion ($_.VersionInfo.FileVersion)
			$_ | Add-Member NoteProperty AssemblyVersion (
				[Reflection.AssemblyName]::GetAssemblyName($_.FullName).Version
			)
		} catch {}
		$_
	} |?{$_.AssemblyVersion -ne $null}|
	Select-Object Name,FileVersion,AssemblyVersion
}

function detect_assemblies2{
	gci -R . *.dll|?{!$_.IsPSContainer}|
		%{ try{[System.Reflection.AssemblyName]::GetAssemblyName($_.FullName)
		} catch{<# Ignore modules that don't contain assembly manifest #>}}
}
	
	

Set-Alias -name ildasm  -value 'C:\Program Files (x86)\Microsoft SDKs\Windows\v8.1A\bin\NETFX 4.5.1 Tools\ildasm.exe'  -description "IL Disassembler"
Set-Alias -name gacutil -value 'C:\Program Files (x86)\Microsoft SDKs\Windows\v8.1A\bin\NETFX 4.5.1 Tools\gacutil.exe' -description "Global Assembly Cache Util"




