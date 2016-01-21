

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
	

#Leads from:   http://stackoverflow.com/questions/5475122/how-to-use-add-type-with-path-and-also-language-csharpversion3
function loadAssembliesFromDirsAndAddTypeFromSource{
	param(
		$assemblyDirCollection,
		$scriptPath,
		$blackList             #Assemblies not to load
	)
	$addedAlready= New-Object System.Collections.ArrayList
	$cp = new-object codedom.compiler.compilerparameters
	foreach ($as in $assemblyDirCollection){
		gci -R $as *.dll |%{ 
			try{
				($a = [Reflection.Assembly]::LoadFrom($_.FullName)  ) -and
				(! ($addedAlready -contains  $a.GetName.Name)       ) -and
				(! ($blackList    -contains  $a.GetName.Name)       ) -and
				($cp.ReferencedAssemblies.Add($_.FullName) -or $true) -and
				$addedAlready.Add(           $a.GetName.Name        )
			}catch{<#Ignore DLL files without manifests and so on #>
			}
		}|Out-Null
	}
	Write-Output("Loaded "+$addedAlready)
	# optionally turn on debugging support
	if ($debugscript){
		$cp.TreatWarningsAsErrors = $true
		$cp.IncludeDebugInformation = $true
		$cp.OutputAssembly = $env:temp + '\-' + [diagnostics.process]::getcurrentprocess().id + '.dll'
	}

	$script = [io.file]::readalltext($scriptPath)
	add-type $script -lang csharp -compilerparam $cp

}
function assemblies_current{
	[appdomain]::currentdomain.getassemblies() | sort -property fullname | format-table fullname
}
	

Set-Alias -name ildasm  -value 'C:\Program Files (x86)\Microsoft SDKs\Windows\v8.1A\bin\NETFX 4.5.1 Tools\ildasm.exe'  -description "IL Disassembler"
Set-Alias -name gacutil -value 'C:\Program Files (x86)\Microsoft SDKs\Windows\v8.1A\bin\NETFX 4.5.1 Tools\gacutil.exe' -description "Global Assembly Cache Util"




