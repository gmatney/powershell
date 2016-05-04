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

function generate_org_associations($maxDepth, $minSub, $maxSub){
	
}

function __generate_org_association($maxDepth, $parentName, $minSub, $maxSub){
	
}


# Load the random name files only after function called.  Clear afterwards
#  Things to consider:   PersonId, FirstName, LastName, Level, CategoryTypeA, CategoryTypeB, Location, Gender 
#  Mqy should think of generic descriptors types.  Example Level is a progression, but category Type might be like an enum
function __generate_random_person(){
	
}


# Find amusing lists to generate from 
function  __generate_random_department(){
	

}