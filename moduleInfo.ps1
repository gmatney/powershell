

function moduleNameList{
	gcm |%{$_.ModuleName}|sort|unique
}

function moduleNamesForPowerCommands{
	gcm |?{$_.ModuleName -like "*Power*"}
}

