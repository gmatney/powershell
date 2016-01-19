
function services_running{
  Get-Service|?{$_ -ne $null}|?{$_.Status.toString() -eq "Running"}
}

