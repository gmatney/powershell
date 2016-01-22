
#If have multiple eternet cards see this (what this was based on)
#http://defaultset.blogspot.com/2010/04/powershell-wireless-network-scan-script.html

function wirelessNetworksAvailable{
	$GLOBAL:ActiveNetworks = @();
	$CurrentIfName = "";   
	$i = -1;

	$bufRead = {
		param($buf, $i, $paramType, $matchStr)
		if ([regex]::IsMatch($buf,"$matchStr")) {
			$GLOBAL:ActiveNetworks[$i].$paramType = $buf.Replace($matchStr+":","");
		}
	}

	netsh wlan show network mode=bssid | % {
		$buf = [regex]::replace($_,"[ ]","");
		if ([regex]::IsMatch($buf,"^SSID\d{1,}(.)*")) {
				$item = "" | Select-Object SSID,NetType,Auth,Encryption,BSSID,Signal,Radiotype,Channel;
				$i+=1;
			$item.SSID = [regex]::Replace($buf,"^SSID\d{1,}:","");
				$GLOBAL:ActiveNetworks+=$item;
		}
		& $bufRead $buf $i "NetType"    "Networktype"
		& $bufRead $buf $i "Auth"       "Authentication"
		& $bufRead $buf $i "Encryption" "Encryption"
		& $bufRead $buf $i "BSSID"      "BSSID1"
		& $bufRead $buf $i "Signal"     "Signal"
		& $bufRead $buf $i "Radiotype"  "Radiotype"
		& $bufRead $buf $i "Channel"    "Channel"
	}

	if($GLOBAL:ActiveNetworks.Length -lt 1){
		echo "Either your network card is off or there are no wireless networks available."
	}
	else{
		$GLOBAL:ActiveNetworks|sort -d signal|format-table Signal,SSID,Auth,Encryption,BSSID,Radiotype,Channel
	}
}
