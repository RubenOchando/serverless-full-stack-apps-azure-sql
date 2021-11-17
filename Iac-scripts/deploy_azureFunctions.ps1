$resourceGroupName = "PointtakenOperations"
$resourceGroup = Get-AzResourceGroup | Where-Object ResourceGroupName -like $resourceGroupName
#$uniqueID = Get-Random -Minimum 100000 -Maximum 1000000
$location = $resourceGroup.Location
# Azure function name
$azureFunctionName = "ptrohbuspocas-204"
# Get storage account name
#$storageAccountName = (Get-AzStorageAccount -ResourceGroup $resourceGroupName).StorageAccountName
$storageAccountName = "functiondbbuspoc"
$storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroupName -AccountName $storageAccountName -Location $location -SkuName Standard_GRS
$functionApp = New-AzFunctionApp -Name $azureFunctionName -ResourceGroupName $resourceGroupName -StorageAccount $storageAccountName -FunctionsVersion 3 -RuntimeVersion 3 -Runtime dotnet -Location $location
