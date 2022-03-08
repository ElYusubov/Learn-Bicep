// 15-deploy-private-repo.bicep

// Step-1: Create Azure container registry (ACR)
// az group create --name myACR-rg --location eastus
// az acr create --resource-group myACR-rg --name myBicepRegistry37 --sku Basic


// Step-2: Get the login server name of the ACR
// az acr login --name myBicepRegistry37


// Step-3: Publish a Bicep file as a module to a private module registry

// Step-4: Define private module path with example

// Step-5: Verify and list a published ACR module by listing ACR repository

// Step-6: Call the private module in your Bicep code
