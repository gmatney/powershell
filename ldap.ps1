

#
#  Usage example:  ldap_query "(&(objectCategory=User)"
#
# http://blog.kbrnd.com/2014/10/23/query-ldap-with-powershell/
# https://technet.microsoft.com/en-us/library/ff730967.aspx
# https://msdn.microsoft.com/en-us/library/aa772218(v=vs.85).aspx


function ldap_query($strFilter){
    $objDomain = New-Object System.DirectoryServices.DirectoryEntry

    $objSearcher = New-Object System.DirectoryServices.DirectorySearcher
    $objSearcher.SearchRoot = $objDomain
    $objSearcher.PageSize = 1000  #Max is 1000
    $objSearcher.Filter = $strFilter
    $objSearcher.SearchScope = "Subtree"

    #queries for everything if Properties are not specified
    #$colProplist = "name"
    #foreach ($i in $colPropList){$objSearcher.PropertiesToLoad.Add($i)}

    $colResults = $objSearcher.FindAll()

    foreach ($objResult in $colResults){
        #{$objItem = $objResult.Properties; $objItem.name}
        $objResult.Properties;
    }
}
