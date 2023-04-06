# Required secret variables:

  - PANTHEON_PRIVATE_KEY
  - PANTHEON_TERMINUS_MACHINE_TOKEN



# Required variables in the site's repo

  - PANTHEONSITEUUID
  - PANTHEONEMAIL
  - PANTHEONENV








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
        PANTHEONEMAIL: example@email.com
        PANTHEON_TERMINUS_MACHINE_TOKEN: ${{ secrets.PANTHEON_TERMINUS_MACHINE_TOKEN }}
        PANTHEON_PRIVATE_KEY: ${{ secrets.PANTHEON_PRIVATE_KEY }}
        PROJECT_ROOT: $(pwd)
        GH_REF2: ${{ github.event.head_commit.message }}
        PANTHEONENV: dev
        SITENAME:
```
