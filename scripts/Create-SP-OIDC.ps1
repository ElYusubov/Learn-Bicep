### Create-SP-OIDC.ps1 ###
# Log into Azure
az login

az account show

# variables
$subscriptionId = $(az account show --query id -o tsv)
$appName = "GitHub-Lean-Bicep-OIDC"
$RBACRole = "Contributor"

$githubOrgName = "ElYusubov"
$githubRepoName = "Learn-Bicep"
$githubBranch = "main"

# Create AAD App and Principal
$appId = $(az ad app create --display-name $appName --query appId -o tsv)
az ad sp create --id $appId

# Create federated GitHub credentials (Entity type 'Branch')
$githubBranchConfig = [PSCustomObject]@{
    name        = "GH-[$githubOrgName-$githubRepoName]-Branch-[$githubBranch]"
    issuer      = "https://token.actions.githubusercontent.com"
    subject     = "repo:" + "$githubOrgName/$githubRepoName" + ":ref:refs/heads/$githubBranch"
    description = "Federated credential linked to GitHub [$githubBranch] branch @: [$githubOrgName/$githubRepoName]"
    audiences   = @("api://AzureADTokenExchange")
}
$githubBranchConfigJson = $githubBranchConfig | ConvertTo-Json
$githubBranchConfigJson | az ad app federated-credential create --id $appId --parameters "@-"

# Create federated GitHub credentials (Entity type 'Pull Request')
$githubPRConfig = [PSCustomObject]@{
    name        = "GH-[$githubOrgName-$githubRepoName]-PR"
    issuer      = "https://token.actions.githubusercontent.com"
    subject     = "repo:" + "$githubOrgName/$githubRepoName" + ":pull_request"
    description = "Federated credential linked to GitHub Pull Requests @: [$githubOrgName/$githubRepoName]"
    audiences   = @("api://AzureADTokenExchange")
}
$githubPRConfigJson = $githubPRConfig | ConvertTo-Json
$githubPRConfigJson | az ad app federated-credential create --id $appId --parameters "@-"

# Assign RBAC permissions to Service Principal (Change as necessary)
$appId | foreach-object {

    # Permission 1 (Example)
    az role assignment create `
        --role $RBACRole `
        --assignee $_ `
        --subscription $subscriptionId
    
        # Permission 2 (Example)
        #az role assignment create `
        #    --role "Reader and Data Access" `
        #    --assignee "$_" `
        #    --scope "/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.Storage/storageAccounts/$storageName"
}