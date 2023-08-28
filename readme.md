# This is a template repository for Hybrid IaC service

## Quick start
1. Create a repository based on this template
2. Create or reuse a service principle that have the permission to deploy resources, e.g. contributor of your deploy subscription
```
az ad sp create-for-rbac --name "zilutftest" --role contributor --scopes /subscriptions/b9e38f20-7c9c-4497-a25d-1a0c5eef2108 --sdk-auth
```
3. Adding repository secret in setting, Name: AZURE_CREDENTIALS, sample value:
```
{
  "clientId": "<ClientId of your SP>", 
  "clientSecret": "<Your SP secret>",
  "subscriptionId": "<Subscription of the SP>",
  "tenantId": "72f988bf-86f1-41af-91ab-2d7cd011db47",
  "activeDirectoryEndpointUrl": "https://login.microsoftonline.com/",
  "resourceManagerEndpointUrl": "https://management.azure.com/",
  "activeDirectoryGraphResourceId": "https://graph.windows.net/",
  "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
  "galleryEndpointUrl": "https://gallery.azure.com/",
  "managementEndpointUrl": "https://management.core.windows.net/"
}

```
4. You are ready to call HybridIac service :)


## Keep sync with template update
On the other repositories you have to add this template repository as a remote.

```git remote add template [URL of the template repo]```

Then run git fetch to update the changes

`git fetch --all`

Then is possible to merge another branch from the new remote to your current one.

`git merge template/main --allow-unrelated-histories`