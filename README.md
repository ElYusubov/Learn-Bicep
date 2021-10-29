# Learn Bicep 

The "Learn Bicep" is a simple, yet powerful step-by-step learning guide with easy to start samples.

## Introduction

This project is created to test Bicep language features, compilation, validations, etc.

Learning by examples is a main focus and accomplished through writing simple and helpful Azure infrastructure code with Bicep language.


The followings are initial goals of the project:

    - Automate deployment via GitHub Actions
    - Author Infrastructure as a Code (IaC)
    - Author Security as Code (SaC)
    - Showcase new features of Azure Bicep as they come

- [Learn Bicep](#introduction)
  - [Badges](#badges)
  - [Run sample demos](#Run-sample-demos)
  - [Project Layout](#Project-Layout)

## Badges

[![License](https://img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)
[![SL Scan](https://github.com/ElYusubov/Learn-Bicep/actions/workflows/shiftleft-analysis.yml/badge.svg)](https://github.com/ElYusubov/Learn-Bicep/actions/workflows/shiftleft-analysis.yml)

## How to run sample demos
To get running the samples do the following in Vs Code env:
- Fork the branch (aka, starting from obvious ;)
- Install Azure CLI or PowerShell Core on you machine
- Enable the Bicep runtime on you machine
- Install VS Code Bicep extension

## Project Layout
- modules: contain reusable components
- param-files: Learn about parameterization options in Azure Bicep files
- samples: contain 10 step deployments of Azure basic and security services
- scripts: contain single '.azcli' file that walk you through deployment scripts
