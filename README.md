Splitsh-lite Github Action
==========================

Synchronises a split repository using [splitsh-lite](https://github.com/splitsh/lite)

Documentation
-------------

Its primary use is to create a split branch and push it to the parent.

The action requires the following inputs:

Key                | Description
------------------ | -----------------------------------------------------------
`split` *          | Subtree repository name (including owner)
`split_deploy_key` | The private key part of a Deploy Key on the split repository
`split_branch`     | Branch name to split (default `main`)
`split_prefix`     | The directory to perform the split on
`split_only_if`    | (`0`, `1` or repository name, default `1`) Pushes only if the origin is this, or `1`

The * indicates mandatory input.

Example usage
-------------

```yaml
name: Release Split

on:
  push:
    branches: [ main ]

jobs:
  splitsh:
    name: ⏩ Update Module Repository
    runs-on: ubuntu-latest
    steps:
      - name: ⤵️ Checkout Sources
        uses: actions/checkout@v2
        with:
          fetch-depth: 0
      - name: ⏩ Run Splitsh
        uses: jackmakiyama/action-splitsh@main
        with:
          split: robsonalvesnogueira/splitsh-mirror-repo
          split_deploy_key: ${{ secrets.SSH_KEY }}
          split_prefix: 'src/my-package-to-split/'
          split_branch: main
```

Main: https://github.com/robsonalvesnogueira/splitsh-main-repo  
Mirror: https://github.com/robsonalvesnogueira/splitsh-mirror-repo

License
-------

This library is under [MIT License](http://opensource.org/licenses/mit-license.php).
