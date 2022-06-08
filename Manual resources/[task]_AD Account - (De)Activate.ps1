$VerbosePreference = "SilentlyContinue"
$InformationPreference = "Continue"
$WarningPreference = "Continue"

# variables configured in form
$userPrincipalName = $form.gridUsers.UserPrincipalName
$blnenabled = $form.enabled

if($blnenabled -eq 'true'){
    try {
        try {
            $adUser = Get-ADuser -Filter { UserPrincipalName -eq $userPrincipalName }
            Write-Information "Found AD user [$userPrincipalName]"
        } catch {
            throw "Could not find AD user [$userPrincipalName]"
        }

    	$enableUser = Enable-ADAccount -Identity $adUser
    	
        Write-Information "Successfully enabled AD user [$userPrincipalName]"

        $adUserSID = $([string]$adUser.SID)
        $adUserDisplayName = $adUser.Name
        $Log = @{
            Action            = "EnableAccount" # optional. ENUM (undefined = default) 
            System            = "ActiveDirectory" # optional (free format text) 
            Message           = "Enabled account with username $userPrincipalName" # required (free format text) 
            IsError           = $false # optional. Elastic reporting purposes only. (default = $false. $true = Executed action returned an error) 
            TargetDisplayName = $adUserDisplayName # optional (free format text) 
            TargetIdentifier  = $adUserSID # optional (free format text) 
        }
        #send result back  
        Write-Information -Tags "Audit" -MessageData $log
    } catch {
        Write-Error "Could not enable AD user [$userPrincipalName]. Error: $($_.Exception.Message)"

        $adUserSID = $([string]$adUser.SID)
        $adUserDisplayName = $adUser.Name
        $Log = @{
            Action            = "EnableAccount" # optional. ENUM (undefined = default) 
            System            = "ActiveDirectory" # optional (free format text) 
            Message           = "Failed to enable account with username $userPrincipalName. Error: $($_.Exception.Message)" # required (free format text) 
            IsError           = $true # optional. Elastic reporting purposes only. (default = $false. $true = Executed action returned an error) 
            TargetDisplayName = $adUserDisplayName # optional (free format text) 
            TargetIdentifier  = $adUserSID # optional (free format text) 
        }
        #send result back  
        Write-Information -Tags "Audit" -MessageData $log
    }
}
    
if($blnenabled -eq 'false'){
    try {
        try {
            $adUser = Get-ADuser -Filter { UserPrincipalName -eq $userPrincipalName }
            Write-Information "Found AD user [$userPrincipalName]"
        } catch {
            throw "Could not find AD user [$userPrincipalName]"
        }

    	$disableUser = Disable-ADAccount -Identity $adUser
    	
        Write-Information "Successfully disabled AD user [$userPrincipalName]"

        $adUserSID = $([string]$adUser.SID)
        $adUserDisplayName = $adUser.Name
        $Log = @{
            Action            = "DisableAccount" # optional. ENUM (undefined = default) 
            System            = "ActiveDirectory" # optional (free format text) 
            Message           = "Disabled account with username $userPrincipalName" # required (free format text) 
            IsError           = $false # optional. Elastic reporting purposes only. (default = $false. $true = Executed action returned an error) 
            TargetDisplayName = $adUserDisplayName # optional (free format text) 
            TargetIdentifier  = $adUserSID # optional (free format text) 
        }
        #send result back
        Write-Information -Tags "Audit" -MessageData $log
    } catch {
        Write-Error "Could not disable AD user [$userPrincipalName]. Error: $($_.Exception.Message)"

        $adUserSID = $([string]$adUser.SID)
        $adUserDisplayName = $adUser.Name
        $Log = @{
            Action            = "DisableAccount" # optional. ENUM (undefined = default) 
            System            = "ActiveDirectory" # optional (free format text) 
            Message           = "Failed to disable account with username $userPrincipalName. Error: $($_.Exception.Message)" # required (free format text) 
            IsError           = $true # optional. Elastic reporting purposes only. (default = $false. $true = Executed action returned an error) 
            TargetDisplayName = $adUserDisplayName # optional (free format text) 
            TargetIdentifier  = $adUserSID # optional (free format text) 
        }
        #send result back  
        Write-Information -Tags "Audit" -MessageData $log
    }
}

