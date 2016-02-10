
if($false){
	#Network Card Bandwidth Info 
	Get-WmiObject -class Win32_PerfFormattedData_Tcpip_NetworkInterface |
		Select Name, CurrentBandWidth |
		Format-Table  @{Expression={$_.Name}; Label="NIC" }, @{Expression={$_.CurrentBandWidth/ 1000000 }; Label="MBit/s"}

		
	Get-NetAdapterStatistics

	Get-Counter -ListSet "Network Interface" | Select-Object -ExpandProperty "Paths"

	$network=(get-counter -list "Network Interface").paths
	$counters = Get-Counter -Counter $network -SampleInterval 1 -MaxSamples 5
	$counters | % { $_.counterSamples } | sort path | ft timestamp, path, cookedvalue -Wrap –AutoSize


	#NetStat for powershell:  https://gist.github.com/empo/958531

	# http://www.kennethghartman.com/log-connections-powershell-script/

	#Other bandwith ideas:
	# https://gallery.technet.microsoft.com/PSNetMon-PowerShell-cd2b345e
	# http://blogs.technet.com/b/parallel_universe_-_ms_tech_blog/archive/2012/03/29/powershell-simple-bandwidth-monitor.aspx
	# https://www.corelan.be/index.php/2009/01/28/monitoring-your-network-with-powershell/




	# Search powershell netmon
	# https://gallery.technet.microsoft.com/scriptcenter/Network-Monitor-Captures-7295810c
	# http://blog.pluralsight.com/microsoft-message-analyzer
	# Message analyzer powershell

}


