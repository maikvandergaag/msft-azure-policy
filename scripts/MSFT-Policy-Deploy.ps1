$policyName = Read-Host "Specify the name of the policy";
$policyDescription = Read-Host "Specify the description of the policy"
$policyFile = Read-Host "Path to json policy file";
$resourceGroup = Read-Host "Specify the resource group";

#Login to the Azure Resource Management Account
Login-AzureRmAccount

#Let the user choose the right subscrition
Write-Host "---------------------------------------------------------------------"
Write-Host "Your current subscriptions: " -ForegroundColor Yellow
Get-AzureRMSubscription
Write-Host "Enter the Subscription ID to deploy to: " -ForegroundColor Green
$sub = Read-Host 
Set-AzureRmContext -SubscriptionId $sub
clear

$subId = (Get-AzureRmContext).Subscription.SubscriptionId
$subName = (Get-AzureRmContext).Subscription.SubscriptionName

Write-Host "Policy is applied to the resource group: $resourceGroup in subscription: $subName"
$policy = New-AzureRmPolicyDefinition -Name $policyName -Description $policyDescription -Policy $policyFile;

#Assign the Azure Policy
New-AzureRmPolicyAssignment -Name $policyName -PolicyDefinition $policy -Scope "/subscriptions/$sub/resourceGroups/$resourcegroup"

