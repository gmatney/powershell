
$shell=$shell
function remind_get_up_and_move(){
	if($shell -eq $null){
		$shell = new-object -comobject "Shell.Application"
	}
	while($true){
		sleep 60*60;  #Every Hour
		$shell.MinimizeAll()	
		#echo "Human, you probably should move around and stretch!"|Invoke-Speech 
		$wshell = New-Object -ComObject Wscript.Shell
		$wshell.Popup("Move around! You've been sitting too long.", 0, "Think of your health.", 4096)
	}
}
