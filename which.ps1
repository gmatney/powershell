#  Tell more details about commands
#
#  TODO  if can't find, go look through path to find executable. (Then can set aliases for)

function which($name)
{
    foreach($cmd in (Get-Command $name | Sort-Object $_.CommandType ))
    {
        echo ""
        Write-Output ( [string]::format( "{0,-18}{1}", $cmd.CommandType, $cmd.Name))
        
        describe_command_property $cmd "Definition" "Def"
            If($cmd.CommandType -eq "Application") { }
        ElseIf($cmd.CommandType -eq "Alias"      ){
            describe_command_property $cmd "Description" "Desc"  ;
            describe_command_property $cmd "ReferencedCommand"  "RefCmd" ;
        }
        ElseIf($cmd.CommandType -eq "Cmdlet"    )
        {
            describe_command_property $cmd "HelpUri" "help" ;
        }
    }
}

function describe_command_property($cmd,$propertyName,$aliasName){
    $expandedProperty=$cmd | Select-Object -ExpandProperty $propertyName
    Write-Output ( [string]::format( "{0,-18}{1}", $aliasName+":",$expandedProperty )) 
}


function which_short($name){
    foreach($cmd in (Get-Command $name | Sort-Object $_.CommandType )){
        Write-Output ( [string]::format( "{0,-18}{1}", $cmd.CommandType, $cmd.Name)) 
    }
}



