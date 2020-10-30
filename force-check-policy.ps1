# Force of policy refresh cycle

Write-Output "Initiate policy refresh cycle for current Subscription"
$azContext = Get-AzContext
$subscriptionId = $azContext.Subscription.Id
$uri = "https://management.azure.com/subscriptions/$subscriptionId/providers/Microsoft.PolicyInsights/policyStates/latest/triggerEvaluation?api-version=2019-10-01"
$azProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
$profileClient = New-Object -TypeName Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient -ArgumentList ($azProfile)
$token = $profileClient.AcquireAccessToken($azContext.Tenant.Id)
$authHeader = @{
    'Content-Type'='application/json'
    'Authorization'='Bearer ' + $token.AccessToken
}
Invoke-RestMethod -Method Post -Uri $uri -UseBasicParsing -Headers $authHeader
