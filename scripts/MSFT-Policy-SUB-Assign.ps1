param(
  [Parameter(Mandatory=$True,Position=1)]
  [string]$PolicyName = "",
  [Parameter(Mandatory=$True,Position=2)]
  [string]$PolicyDescription = "",
  [Parameter(Mandatory=$True,Position=3)]
  [string]$PolicyFile = ""
)

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

$PolicyFile
Write-Host "Policy is applied to the resource group: $resourceGroup in subscription: $subName" -ForegroundColor Yellow
$policy = New-AzureRmPolicyDefinition -Name $PolicyName -Description $PolicyDescription -Policy $PolicyFile

Write-Host "Assing the Policy to the resource group" -ForegroundColor Yellow

#Assign the Azure Policy
New-AzureRmPolicyAssignment -Name $PolicyName -PolicyDefinition $policy -Scope "/subscriptions/$subId"

