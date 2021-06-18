# iac
Infrastructure-as-code repo

## Pre-requisites
* Ensure that you enable the ingress controller add-on
  1. https://docs.microsoft.com/en-us/azure/application-gateway/tutorial-ingress-controller-add-on-new

## Done
* Manually create service principal used by GitLab CI and give just enough permission
  * the tricky part was...
    * go into Azure Active Directory
    * search for the app id/guid of the sp
    * App registrations version of the sp's ID
    * API permissions
    * add a permission
      * go to the Azure Active Directory Graph
        * Application.ReadWrite.OwnedBy
        * User.Read
* Stand up AKS cluster
  * Cheapest single node cluster I could stand up
* populate GitLab variable with necessary data to stand-up a kubernetes Terraform provider
* add app gateway
* install app gateway ingress controller <-- that was needlessly complicated!
  * https://docs.microsoft.com/en-us/azure/developer/terraform/create-k8s-cluster-with-aks-applicationgateway-ingress
  * Will be simpler when AGIC add-on for AKS leaves preview. By a lot.
* Able to stand everything up and tear it down through automation
* deploy a hello-world site

## TODO
* FIX: when re-applying the TF script, it appears that rules related to AGIC are removed
* Setup TLS and auto-redirect all traffic from 80 -> 443
* setup automatic let's encrypt TLS cert updating
  * https://intelequia.com/blog/post/1012/automating-azure-application-gateway-ssl-certificate-renewals-with-let-s-encrypt-and-azure-automation
* wire up ACI
* stale resume site & wedding site
  * build helm package
  * deploy to ACI
  * deploy
  * trigger pipelines when build is complete (for when I nuke the cluster entirely)
* ~~deploy gitlab runner pod for faster builds~~ (going to magic up AWS Lambda runners)
* finally get backing up to stoic meditations podcast
* figure out how to tag images so they aren't deleted after default retention period (7 days)
* enable trust policy
  * automatically backup signing keys to keyvault(?)

## Longer term
* The app registration's password expired in 2 years, automate cycling or find alternative
* azurerm_role_assignment.cluster_sp_contributor scope is contrib at the entire subscription, look for ways to make that more-reasonable
