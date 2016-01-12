

function battery{
  $battery=(Get-WmiObject win32_battery)
  $battery|select DeviceID,Description,EstimatedChargeRemaining,EstimatedRunTime|fl
  if($battery -eq $null){
    Write-Output("No battery detected! Must be plugged into an external power source.") 
  }
}
