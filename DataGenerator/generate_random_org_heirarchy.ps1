$surnames         = Import-Csv -Delimiter "`t" -Path         Surnames.tsv
$maleFirstNames   = Import-Csv -Delimiter "`t" -Path   MaleFirstNames.tsv
$femaleFirstNames = Import-Csv -Delimiter "`t" -Path FemaleFirstNames.tsv

function random_popular_surname(){
    return $surnames[$(Get-Random -minimum 0 -maximum $surnames.Count)].Name
}

function random_popular_female_firstname(){
    return $femaleFirstNames[$(Get-Random -minimum 0 -maximum $femaleFirstNames.Count)].Name
}

function random_popular_male_firstname(){
    return $maleFirstNames[$(Get-Random -minimum 0 -maximum $maleFirstNames.Count)].Name
}

function random_popular_name(){
    $randomName=""
    if( $(Get-Random -minimum 0 -maximum 2) -eq 0 ){
        $randomName = random_popular_female_firstname
    }
    else{
        $randomName = random_popular_male_firstname
    }
    $randomName += " " + $(random_popular_surname)
    Write-Output($randomName)
}

function randomChars(){
    #https://blogs.technet.microsoft.com/heyscriptingguy/2015/11/05/generate-random-letters-with-powershell/
    #65-90 represent the upper case letters of the alphabet
    #97-122 are lower
	Write-Output(-join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_}))
}


function department_name(){
    #TODO think of more interesting
    Write-Output("Classified-Department");
}


$orgUniqueIdCount=1;
function getOrgUniqueID(){
    Set-Variable -Name orgUniqueIdCount -Value ($orgUniqueIdCount + 1) -Scope Global
    Write-Output($orgUniqueIdCount++)
}


#TODO Find amusing org lists to generate from with style
function generate_random_department($linksUpTo){
    $unit = $(generate_org_node $(getOrgUniqueID) $(department_name) "DEPARTMENT" $linksUpTo)
    Write-Output($unit)
}

# Load the random name files only after function called.  Clear afterwards
#  Things to consider:   PersonId, FirstName, LastName, Level, CategoryTypeA, CategoryTypeB, Location, Gender 
#  Mqy should think of generic descriptors types.  Example Level is a progression, but category Type might be like an enum
function generate_random_employee($linksUpTo){
    $unit = $(generate_org_node $(getOrgUniqueID) $(random_popular_name) "EMPLOYEE" $linksUpTo)
    Write-Output($unit)
}

function generate_org_node($id, $name, $class, $linksUpTo, $orgId, $orgName){

    $object = New-Object -TypeName PSObject
    $object | Add-Member -MemberType NoteProperty -Name ID        -Value "$id"
    $object | Add-Member -MemberType NoteProperty -Name Name      -Value "$name"
    $object | Add-Member -MemberType NoteProperty -Name Class     -Value "$class"
    $object | Add-Member -MemberType NoteProperty -Name LinksUpTo -Value $linksUpTo.ID  
    if($orgId      -ne $null) { $object | Add-Member -MemberType NoteProperty -Name OrgId     -Value "$orgId"        }
    if($orgName    -ne $null) { $object | Add-Member -MemberType NoteProperty -Name OrgName   -Value "$orgName"      }
    Write-Output $object
}

function generate_org_associations($maxDepth, $minSub, $maxSub){	
    __generate_org_association $maxDepth $null $minSub $maxSub
    
}

#generate_random_department
function __generate_org_association($maxDepth, $parentName, $minSub, $maxSub){
	if($maxDepth -gt -1){
        if($maxDepth -eq 0){ $IamYourFather = $(generate_random_employee $parentName) }
        else{ $IamYourFather = $(generate_random_department $parentName) } 
        Write-Output($IamYourFather)
        for($i=0;$i -lt $(Get-Random -Minimum $minSub -Maximum $maxSub) ; $i++){
            __generate_org_association $($maxDepth-1) $IamYourFather $minSub $maxSub
        }
    }
    
}

# Example: get_100_random_employees | ConvertTo-Json
function get_100_random_employees(){
    $employees = New-Object System.Collections.ArrayList
    1..100 |%{ [void] $employees.Add( $(generate_random_employee) ) }
    Write-Output($employees)
}


generate_org_associations  3  1 8