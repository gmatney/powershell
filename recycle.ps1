
#https://msdn.microsoft.com/en-us/library/microsoft.visualbasic.fileio.recycleoption(v=vs.110).aspx

function recycle($path){
	Add-Type  -AssemblyName  Microsoft.VisualBasic
	if(Test-Path $path){
		$fullPath= $(Resolve-Path $path).Path
		Write-Output("Recycling $fullPath")
		if([Microsoft.VisualBasic.FileIO.FileSystem]::DirectoryExists($fullPath)){
			[Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory($fullPath,'OnlyErrorDialogs','SendToRecycleBin')
		}
		else{
			[Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile($fullPath,'OnlyErrorDialogs','SendToRecycleBin')
		}
	}
	else{
		Write-Output("Nothing to recyle at: $path")
	}
}

set-alias -name "trash" -value recycle  -description "Send to the trash/recycle bin"

