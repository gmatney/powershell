#Example    echo "Today is going to be a good day" | invoke-speech
#Note: if you keep move the voice variable to be global it will speak immediately. 
function invoke-speech{
	param([Parameter(ValueFromPipeline=$true)][string] $say)
	process{
		$voice = New-Object -ComObject SAPI.SPVoice
		$voice.Rate = -3
		$voice.Speak($say) | out-null;
	}
}