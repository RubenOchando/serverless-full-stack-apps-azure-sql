# Resource group name and resource group
Connect-AzAccount
$Customername = "ptaken"
$Location = "norwayeast"
$SubscriptionId='09277bbe-69f1-4e20-87e2-1bcf288e3aa0'
Select-AzSubscription $SubscriptionId
$resourceGroupName = "PointtakenOperations"
$resourceGroup = Get-AzResourceGroup | Where-Object ResourceGroupName -like $resourceGroupName
$location = $resourceGroup.Location
# Get the repository name
$appRepository = "(e.g. https://github.com/[username]/serverless-full-stack-apps-azure-sql):"
# Clone the repo - note this asks for the token
#$cloneRepository = git clone $appRepository
# Get subscription ID 
$subId = [Regex]::Matches($resourceGroup.ResourceId, "(\/subscriptions\/)+(.*\/)+(.*\/)").Groups[2].Value
$subId = $subId.Substring(0,$subId.Length-1)
# Deploy logic app
az deployment group create --name DeployResources --resource-group $resourceGroupName `
    ` --template-file ./serverless-full-stack-apps-azure-sql/deployment-scripts/template.json `
    --parameters subscription_id=$subId location=$location
