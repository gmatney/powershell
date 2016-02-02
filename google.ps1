function google {
	param(
		[Parameter(ValueFromPipeline=$true)]
		[string]$query
	)
	Write-Output("Googling: '$query'")
	
	Start "https://www.google.com/search?q=$query"	
	#Process {
		
	#}

}
