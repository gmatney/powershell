
#Make a given script run in the backgroun.
#TODO make work with most normal commands
function bg{
	#TODO - only if is alias or function
	#TODO  figure out how to get working dir applied to script being created
	if($args.count -eq 0){ return;}
	$name=$args -join " "
	$cmd=$args[0]
	Write-Output("CMD: $cmd")
	$args=$args[1..$args.length]
	Write-Output("ARG: $args")
	$sb = ([scriptblock]::Create(  $(Get-Command $cmd).Definition  ))
	#Can use |Wait-Job|Receive-Job  #To print details early  DEBUG below
	#Start-Job  -Name $name -ArgumentList $args -scriptblock $sb|Wait-Job|Receive-Job
	Start-Job  -Name $name -ArgumentList $args -scriptblock $sb

}