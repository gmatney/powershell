
function md5($fileName){
	$filePath = $(dir $fileName).FullName
	$md5  = New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
	$hash = [System.BitConverter]::ToString($md5.ComputeHash([System.IO.File]::ReadAllBytes($filePath)))
	Write-Output( $hash )
}

function files{
	Param (
		[Parameter(Mandatory=$false)][System.UInt32]$depth,
		[Switch]$full
	)
	dirFilesHelper -dirOnly $false -depth $depth -full $full
}


function directories{
	Param (
		[Parameter(Mandatory=$false)][System.UInt32]$depth,
		[Switch]$full
	)
	dirFilesHelper -dirOnly $true -depth $depth -full $full
}



function dirFilesHelper{
	Param (
		[Parameter(Mandatory=$true)][bool]$dirOnly,
		[Parameter(Mandatory=$false)][System.UInt32]$depth,
		[Parameter(Mandatory=$false)][bool]$full
	)
	#Get-ChildItem  -Recurse|?{$_.PSIsContainer}|%{$_.FullName} 
	
	$dirLength=0;
	if(!$full){
		$dirLength=((pwd).Path.Length+1)
	}
	
	if($depth){
		if($depth -lt 1){ 
			if($dirOnly){gci . |?{ $_.PSIsContainer}|%{$_.FullName.subString($dirLength)}}
			else        {gci . |?{!$_.PSIsContainer}|%{$_.FullName.subString($dirLength)}}
		}
		else{
			$depth=$depth-1;
			if($dirOnly){gci -R -depth $depth|?{ $_.PSIsContainer}|%{$_.FullName.subString($dirLength)}}
			else        {gci -R -depth $depth|?{!$_.PSIsContainer}|%{$_.FullName.subString($dirLength)}}
		}
		
	}
	else{
		gci -R |?{$_.PSIsContainer}|%{$_.FullName.subString($dirLength)}
		if($dirOnly){gci -R |?{ $_.PSIsContainer}|%{$_.FullName.subString($dirLength)}}
		else        {gci -R |?{!$_.PSIsContainer}|%{$_.FullName.subString($dirLength)}}
	}
}
