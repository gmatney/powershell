# To be used to make it easier to remember what windows objects can be controlled
# Example: $excel = New-Object -com "Excel.Application"
# -appOnly switch just prints the Applications 
function comObjectList{
    param([switch] $appOnly);
    if($appOnly){
        gci HKLM:\Software\Classes -ea 0|
          ?{$_.PSChildName -match '^\w+\.\w+$' -and 
          (gp "$($_.PSPath)\CLSID" -ea 0)}|
          ?{$_.PSChildName.trim().EndsWith("Application")}
    }
    else{
        gci HKLM:\Software\Classes -ea 0|
          ?{$_.PSChildName -match '^\w+\.\w+$' -and 
          (gp "$($_.PSPath)\CLSID" -ea 0)}|select PSChildName
    }
}
