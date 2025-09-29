# Push to Translation Manager in Github actions

This helper **Github Action** push i18n to Translation Manager.

## Usage in a Github actions workflow

```yml
# .github/workflows/publish.yml
name: Publish
# you may wish to trigger this for other specifics, this is an example
on:
  push:
    tags:
      - v*
    branches:
      - release-*

jobs:
  publish:
    name: Publish
    runs-on: ubuntu-latest
    steps:
    - id: translation-manager
      uses: pixl8/github-action-push-to-translation-manager@v1
```