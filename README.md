Using GitHub Actions is a great option for deploying code from a GitHub repository to Pantheon if you want to add additional Continous Integration workflow in your setup. 


With this Github action, you can:

  - Deploy you repo with
    - Whole code repo
	- To a nested docroot `/web` path
	- A specific theme, plugin, or any other directory by specifying the LOCAL_PATH and REMOTE_PATH options.
  - Post deploy options:
	- Clear cache 
	- Auto commit and deploy to `TEST` envionment
	- Auto commit and deploy to `LIVE` envionment

# Initial setup

SSH PUBLIC KEY SETUP IN WP ENGINE
Generate a new SSH key pair if you have not already done so. Please note that this SSH Key needs to be passwordless.

Add SSH Public Key to WP Engine SSH Gateway Key settings. This Guide will show you how.

SSH PRIVATE KEY SETUP IN GITHUB
Add the SSH Private Key to your Repository Secrets or your Organization Secrets. Save the new secret "Name" as WPE_SSHG_KEY_PRIVATE.
YML SETUP
Create .github/workflows/main.yml directory and file locally. Copy and paste the configuration from below, replacing the value under branches: and the value for WPE_ENV:.

To deploy from another branch, simply create another yml file locally for that branch, such as .github/workflows/stage.yml and replace the values for branches: and WPE_ENV: for that workflow.

This provides the ability to perform a different workflow for different branches/environments. Consult "Environment Variable & Secrets" for more available options.

Git push your site GitHub repo. The action will do the rest!
View your actions progress and logs by navigating to the "Actions" tab in your repo.


## Setup Instructions


1. **SSH PUBLIC KEY SETUP IN WP ENGINE**
* [Generate a new SSH key pair](https://wpengine.com/support/ssh-keys-for-shell-access/#Generate_New_SSH_Key?utm_content=wpe_gha) if you have not already done so. Please note that this SSH Key needs to be *passwordless*.

* Add *SSH Public Key* to WP Engine SSH Gateway Key settings. [This Guide will show you how.](https://wpengine.com/support/ssh-gateway/#Add_SSH_Key?utm_content=wpe_gha)

2. **SSH PRIVATE KEY SETUP IN GITHUB**

* Add the *SSH Private Key* to your [Repository Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository) or your [Organization Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-an-organization). Save the new secret "Name" as `WPE_SSHG_KEY_PRIVATE`.

3. **YML SETUP**

* Create `.github/workflows/main.yml` directory and file locally.
Copy and paste the configuration from below, replacing the value under `branches:` and the value for `WPE_ENV:`.

* To deploy from another branch, simply create another yml file locally for that branch, such as `.github/workflows/stage.yml` and replace the values for `branches:` and  `WPE_ENV:` for that workflow.

This provides the ability to perform a different workflow for different branches/environments. Consult ["Environment Variable & Secrets"](#environment-variables--secrets) for more available options.

4. Git push your site GitHub repo. The action will do the rest!

View your actions progress and logs by navigating to the "Actions" tab in your repo.

## Example GitHub Action workflow

### Simple main.yml:




Sample Github action that you can add in your repo

```
name: Pantheon Build
on:
  push:
    branches:
      - main

jobs:
  github_deploy_to_dev:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3
    - name: Pantheon Deploy
      uses: pantheoncarl/code-deploy-wp@main
      id: cache-vendor
      env:
        PANTHEONSITEUUID: 1234abcd-1234-abc-1111-1234abcd
        PANTHEON_TERMINUS_MACHINE_TOKEN: ${{ secrets.PANTHEON_TERMINUS_MACHINE_TOKEN }}
        PANTHEON_PRIVATE_KEY: ${{ secrets.PANTHEON_PRIVATE_KEY }}
        PROJECT_ROOT: $(pwd)
        GH_REF2: ${{ github.event.head_commit.message }}
        PANTHEONENV: dev
        SITENAME:
```
