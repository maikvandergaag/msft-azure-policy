$policyName = Read-Host "Specify the name of the policy";
$policyDescription = Read-Host "Specify the description of the policy"
$policyFile = Read-Host "Path to json policy file";
$resourceGroup = Read-Host "Specify the resource group";

#Login to the Azure Resource Management Account
Login-AzureRmAccount
Write-Host "---------------------------------------------------------------------"
Write-Host "Your current subscriptions: " -ForegroundColor Yellow
Get-AzureRMSubscription
Write-Host "Enter the Subscription ID to deploy to: " -ForegroundColor Green
$sub = Read-Host 
Set-AzureRmContext -SubscriptionId $sub
clear

$policy = New-AzureRmPolicyDefinition -Name $policyName -Description $policyDescription -Policy $policyFile;

#Assign the Azure Policy
New-AzureRmPolicyAssignment -Name regionPolicyAssignment -PolicyDefinition $policy -Scope "/subscriptions/$sub/resourceGroups/$resourcegroup"

