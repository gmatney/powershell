
function md5($fileName){

  $filePath = $(dir $fileName).FullName
  $md5  = New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
  $hash = [System.BitConverter]::ToString($md5.ComputeHash([System.IO.File]::ReadAllBytes($filePath)))
  Write-Output( $hash )

}

function files{
	#Get-ChildItem  -Recurse|?{!$_.PSIsContainer}|%{$_.FullName} 
	gci -R|?{$_.PSIsContainer}|%{$_.FullName}
}

function directories{
	#Get-ChildItem  -Recurse|?{$_.PSIsContainer}|%{$_.FullName} 
	gci -R|?{$_.PSIsContainer}|%{$_.FullName}
}



