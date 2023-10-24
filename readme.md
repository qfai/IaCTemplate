# This is a template repository for Hybrid IaC service

## Quick start
1. Create a repository based on this template
2. Create or reuse a service principle that have the permission to deploy resources, e.g. contributor of your deploy subscription
```
az ad sp create-for-rbac --name "<Name of your SP>" --role contributor --scopes /subscriptions/<Your Subscription>
```
3. Go to Microsoft Entra ID (AAD), find your service principle just created. Go to `Certificates & secrets` -> `Federated credentials` -> `Add credential`.

Federated credential scenario: choose `Github Actions deploying Azure resources`.

Choose `Environment` for Entity type. Input `terraform` as value.

4. Create `terraform` environment in your Github repository. `Settings` -> `Environments` -> `New environment`.

5. You are ready to call HybridIac service :)


## Keep sync with template update
On the other repositories you have to add this template repository as a remote.

```git remote add template [URL of the template repo]```

Then run git fetch to update the changes

`git fetch --all`

Then is possible to merge another branch from the new remote to your current one.

`git merge template/main --allow-unrelated-histories`