try {
    $adUser = Get-ADuser -Filter { UserPrincipalName -eq $userPrincipalName }
    HID-Write-Status -Message "Found AD user [$userPrincipalName]" -Event Information
    HID-Write-Summary -Message "Found AD user [$userPrincipalName]" -Event Information
} catch {
    HID-Write-Status -Message "Could not find AD user [$userPrincipalName]. Error: $($_.Exception.Message)" -Event Error
    HID-Write-Summary -Message "Failed to find AD user [$userPrincipalName]" -Event Failed
}
 
if($blnenabled -eq 'true'){
    try {
        Enable-ADAccount -Identity $adUser
         
        HID-Write-Status -Message "Finished enable AD user [$userPrincipalName]" -Event Success
        HID-Write-Summary -Message "Successfully enabled AD user [$userPrincipalName]" -Event Success
    } catch {
        HID-Write-Status -Message "Could not enable AD user [$userPrincipalName]. Error: $($_.Exception.Message)" -Event Error
        HID-Write-Summary -Message "Failed to enable AD user [$userPrincipalName]" -Event Failed
    }
}
     
if($blnenabled -eq 'false'){
    try {
        Disable-ADAccount -Identity $adUser
         
        HID-Write-Status -Message "Finished disable AD user [$userPrincipalName]" -Event Success
        HID-Write-Summary -Message "Successfully disabled AD user [$userPrincipalName]" -Event Success
    } catch {
        HID-Write-Status -Message "Could not disable AD user [$userPrincipalName]. Error: $($_.Exception.Message)" -Event Error
        HID-Write-Summary -Message "Failed to disable AD user [$userPrincipalName]" -Event Failed
    }
}