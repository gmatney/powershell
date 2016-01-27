
function printerCurrentDefault
{
 Get-WMIObject -query "Select * From Win32_Printer Where Default = TRUE"
}


function printersAvailable
{
 Get-WMIObject -query "Select * From Win32_Printer"
}
