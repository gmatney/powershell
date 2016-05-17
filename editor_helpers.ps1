
#Set an alias to wherever you installed Notepad
Set-Alias notepad++ 'C:\programming\Notepad++\notepad++.exe'

# Open file with notepad++
#  Or if passing a lot of lines, create a new file
#  with the data, and open that file in notepad++.
function np(){
	foreach( $arg in $args)
	{
		Write-Host "Opening in Notepad++: '$arg'"
        notepad++ $arg
    
	}
	#Remember input is from standard in, while args are not.
	$length=@($input).Count
	$input.Reset()
	$go=$true;
    if($length -gt 3){ #Figure out if meant for us.
        $msg = "Large numer of files requested, Count: $length, "
        $msg +="`n enter y to allow."
        $msg +="`n enter i to create a file with all contents inside, and open that"
        $result = Read-Host -Prompt $msg
        $go=$result -eq "y"
        if($result -eq "i"){
            $fileName="np_tmp_"+$(get-date).ToString("yyyyMMdd_HHmm")
            foreach( $i in $input){
                echo "$i" >> $fileName
            }
            Write-Host "Opening in Notepad++: '$fileName'";
            notepad++ $fileName
        }
    }
    if($go){
        foreach( $i in $input){
            Write-Host "Opening in Notepad++: '$i'";
            notepad++ $i
        }
    }
	
}

#gci .. -R|?{!$_.PSIsContainer}|%{$_.FullName} | np