# Learn Bicep 

The "Learn Bicep" is a simple, yet powerful step-by-step learning guide with easy to start samples.

[![License](https://img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)
[![SL Scan](https://github.com/ElYusubov/Learn-Bicep/actions/workflows/shiftleft-analysis.yml/badge.svg)](https://github.com/ElYusubov/Learn-Bicep/actions/workflows/shiftleft-analysis.yml)
[![Main-site-deployment](https://github.com/ElYusubov/Learn-Bicep/actions/workflows/main.deployment.yaml/badge.svg)](https://github.com/ElYusubov/Learn-Bicep/actions/workflows/main.deployment.yaml)

## Azure Bicep blog posts
- [Managing Azure Bicep sensitive info with Azure key Vault](https://thecloudmarathoner.com/index.php/2021/11/16/managing-azure-bicep-sensitive-info-with-key-vault/)
- [Hardening parameter inputs on Azure Bicep files](https://thecloudmarathoner.com/index.php/2021/10/22/hardening-parameter-inputs-on-azure-bicep-files/)
- [Four parameterization options for your Azure Bicep deployments](https://thecloudmarathoner.com/index.php/2021/10/15/four-parameterization-options-for-your-azure-bicep-deployments/)
- [August month updates from Azure Bicep](https://thecloudmarathoner.com/index.php/2021/09/03/august-month-updates-from-azure-bicep/)
- [How to check and update Azure CLI version on your workstation?](https://thecloudmarathoner.com/index.php/2021/09/02/how-to-check-and-update-azure-cli-verison-on-your-workstation/)
- [What is new in Azure Bicep v0.4?](https://thecloudmarathoner.com/index.php/2021/07/30/what-is-new-in-azure-bicep-v0-4/)
- [Troubleshooting an error on Bicep module – on Azure CLI (2.22.0) for Windows 10](https://thecloudmarathoner.com/index.php/2021/04/19/error-on-bicep-module-on-azure-cli-2-22-0-for-windows-10/)

## Introduction

This project is created to test Bicep language features, compilation, validations, etc.

Learning by examples is a main focus and accomplished through writing simple and helpful Azure infrastructure code with Bicep language.


The followings are initial goals of the project:

    - Automate deployment via GitHub Actions
    - Author Infrastructure as a Code (IaC)
    - Author Security as Code (SaC)
    - Showcase new features of Azure Bicep as they come

- [Learn Bicep](#introduction)
  - [Azure Bicep posts](#Azure-Bicep-posts)
  - [Run sample demos](#Run-sample-demos)
  - [Workflows](#Workflows)
  - [Project Layout](#Project-Layout)

## How to run sample demos
Get running your samples in the VS Code:
- Fork the branch (aka, starting from obvious ;)
- Install Azure CLI or PowerShell Core on you machine
- Enable the Bicep runtime on you machine: try 'az bicep version' or 'bicep version'
- Install VS Code Bicep extension

## Workflows
- SL Scan: shiftleft-analysis:-> describes workflow purpose
- Deploy-Main-Site: main.deployment:-> describes workflow purpose

## Project Layout
- modules: contain reusable components
- param-files: Learn about parameterization options in Azure Bicep files
- samples: contain 11 step deployments of Azure and security services
- scripts: contain single '.azcli' file that walk you through deployment scripts
