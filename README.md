# Push to Translation Manager in Github actions

This helper **Github Action** push i18n to Translation Manager.

## Usage in a Github actions workflow

```yml
...
- name: Push to Translation Manager
  if: "env.PUBLISH == 'true'"
  uses: pixl8/github-action-push-to-translation-manager@v1
  with:
    translations_api_key: ${{ secrets.TRANSLATIONS_API_KEY }}
    # Optional: specify a custom project slug
    # project_slug: "my-custom-project"
...
```