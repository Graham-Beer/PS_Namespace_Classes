function Get-PSNamespaceClasses {

<#
.Description
    Short PowerShell script to obtain a full list of classes for the PowerShell namespace
    'system.management.automation' from the MSDN documentation available online.
#>

# Set string with a formatter
$PSClass = "System.Management.Automation{0}"

# MSDN documentation link for namespace 'system.management.automation'
$url = 'https://msdn.microsoft.com/en-us/library/system.management.automation(v=vs.85).aspx'

# Return website information
$web = Invoke-WebRequest -Uri $url

# from returned webrequest find each individual class from the list of links to each
# relevant 'system.management.automation' page. i.e. $Values return .actionpreference, .psobject etc.
$Values = $web.links | select href | %{
    $_ -match ("(?<=system.management.automation)(.*)(?=\()")
    } | %{
        $Matches.values
    } |
    sort -Unique

# with use of the "formatter" add each 'class' name to the string 'System.Management.Automation.'
# to return full typename, i.e. System.Management.Automation.psobject
$FullClassName = foreach ($Value in $Values) {$PSClass -f $Value}

# display values
return $FullClassName
}