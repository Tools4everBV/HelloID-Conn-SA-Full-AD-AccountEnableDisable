$UserPrincipalName = $formInput.selectedUser.UserPrincipalName
HID-Write-Status -Message "Searching AD user [$userPrincipalName]" -Event Information
 
try {
    $adUser = Get-ADuser -Filter { UserPrincipalName -eq $userPrincipalName } -Properties enabled | select enabled
    HID-Write-Status -Message "Finished searching AD user [$userPrincipalName]" -Event Information
    HID-Write-Summary -Message "Found AD user [$userPrincipalName]" -Event Information
     
    $enabled = $adUser.enabled
     
    Hid-Write-Status -Message "Account enabled: $enabled" -Event Information
    HID-Write-Summary -Message "Account enabled: $enabled" -Event Information
     
    Hid-Add-TaskResult -ResultValue @{ enabled = $enabled }
} catch {
    HID-Write-Status -Message "Error retrieving AD user [$userPrincipalName] account status. Error: $($_.Exception.Message)" -Event Error
    HID-Write-Summary -Message "Error retrieving AD user [$userPrincipalName] account status" -Event Failed
     
    Hid-Add-TaskResult -ResultValue []
}