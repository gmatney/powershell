

function battery{
  $battery=(Get-WmiObject win32_battery)
  $battery|select DeviceID,Description,EstimatedChargeRemaining,EstimatedRunTime|fl
}
