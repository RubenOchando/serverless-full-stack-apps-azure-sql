$ipAddress=(Invoke-WebRequest -Uri "https://ipinfo.io/ip").Content
Connect-AzAccount
$Customername = "ptaken"
$Location = "norwayeast"
$SubscriptionId='09277bbe-69f1-4e20-87e2-1bcf288e3aa0'
Select-AzSubscription $SubscriptionId

# Collect password 
$adminSqlLogin = "cloudadmin"
$password = "P@Azw0rd-204" #Your username is 'cloudadmin'. Please enter a password for your Azure SQL Database server that meets the password requirements P@Azw0rd-204 "
# Prompt for local ip address
#$ipAddress = Read-Host "Please enter your IP address (include periods)"

# Get resource group and location and random string
$resourceGroupName = "PointtakenOperations"
$resourceGroup = Get-AzResourceGroup | Where-Object ResourceGroupName -like $resourceGroupName
$uniqueID = Get-Random -Minimum 100000 -Maximum 1000000
$location = $resourceGroup.Location
# The logical server name has to be unique in the system
$serverName = "ptoperations-mockdata-sql"
# The sample database name
$databaseName = "bus-db"    
Write-Host "Please note your unique ID for future exercises in this module:"  
Write-Host $uniqueID
Write-Host "Your resource group name is:"
Write-Host $resourceGroupName
Write-Host "Your resources were deployed in the following region:"
Write-Host $location
Write-Host "Your server name is:"
Write-Host $serverName

# Create a new server with a system wide unique server name
<#$server = New-AzSqlServer -ResourceGroupName $resourceGroupName `
    -ServerName $serverName `
    -Location $location `
    -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $adminSqlLogin, $(ConvertTo-SecureString -String $password -AsPlainText -Force))
#>
    # Create a server firewall rule that allows access from the specified IP range and all Azure services


$serverFirewallRule = New-AzSqlServerFirewallRule `
    -ResourceGroupName $resourceGroupName `
    -ServerName $serverName `
    -FirewallRuleName "AllowedIPs" `
    -StartIpAddress $ipAddress -EndIpAddress $ipAddress 
$allowAzureIpsRule = New-AzSqlServerFirewallRule `
    -ResourceGroupName $resourceGroupName `
    -ServerName $serverName `
    -AllowAllAzureIPs
# Create a database
$database = New-AzSqlDatabase  -ResourceGroupName $resourceGroupName `
    -ServerName $serverName `
    -DatabaseName $databaseName `
    -Edition "GeneralPurpose" -Vcore 1 -ComputeGeneration "Gen5" `
    -ComputeModel Serverless -MinimumCapacity 0.5
Write-Host "Database deployed."
