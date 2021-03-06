function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $strComputer
    )

    #Write-Verbose "Use this cmdlet to deliver information about command processing."

    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."


    <#
    $returnValue = @{
    strComputer = [System.String]
    }

    $returnValue
    #>
}


function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $strComputer
    )

 function DriveSpace {
param( [string] $strComputer) 
"$strComputer ---- Free Space (percentage) ----"

# Does the server responds to a ping (otherwise the WMI queries will fail)
$date = Get-Date
$ConvertToGB = (1024 * 1024 * 1024)
#$query = "select * from win32_pingstatus where address = '$strComputer'"
#$result = Get-WmiObject -query $query
#if ($result.protocoladdress) {

    # Get the Disks for this computer
    $colDisks = get-wmiobject Win32_LogicalDisk  -Filter "DriveType = 3"


    # For each disk calculate the free space
    foreach ($disk in $colDisks) {
       if ($disk.size -gt 0) {$PercentFree = [Math]::round((($disk.freespace/$disk.size) * 100))
                 $Diskfree = [Math]::round(($disk.freespace/$ConvertToGB),2)       
                 $Disksize = [Math]::round(($disk.size/$ConvertToGB),2)
}
else {$PercentFree = 0}

		$Drive = $disk.DeviceID
               # $Diskfree = ($disk.freespace / $ConvertToGB)
               # $Disksize = ($disk.size / $ConvertToGB)
       "$Drive - $PercentFree"

       # if  < 100% free space, log to a file
       if ($PercentFree -le 100) {"$Drive drive: $Diskfree GB of $Disksize GB Available : $PercentFree % : $date" | out-file -append  -filepath "C:\Users\shealth.txt"}
    }
#}
}
 DriveSpace $strComputer


    #Write-Verbose "Use this cmdlet to deliver information about command processing."

    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."

    #Include this line if the resource requires a system reboot.
    #$global:DSCMachineStatus = 1


}


function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [System.String]
        $strComputer
    )

    #Write-Verbose "Use this cmdlet to deliver information about command processing."

    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."


    <#
    $result = [System.Boolean]
    
    $result
    #>
   $false
}


Export-ModuleMember -Function *-TargetResource

