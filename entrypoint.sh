#!/bin/bash

GIT_BRANCH=${GITHUB_REF##*/}

if [[ $GIT_BRANCH == v* ]]; then
  VERSION_NUMBER="${GIT_BRANCH//v}"
else
  VERSION_NUMBER="${GIT_BRANCH//release-}"
fi

if [[ -z "$INPUT_TRANSLATIONS_ENDPOINT" ]] ; then
	echo "Translation manager endpoint environment variables not set. Please set the endpoint variables to use this action."
	exit 0
fi

if [[ -z "$INPUT_TRANSLATIONS_API_KEY" ]] ; then
	echo "Translation manager API key environment variables not set. Please set API key variables to use this action."
	exit 0
fi

TRANSLATION_VERSION_NUMBER=$(echo "$VERSION_NUMBER" | sed 's/\([0-9]\+\.[0-9]\+\)\.[0-9]\+/\1.0/')

SOURCEDIR=""
for dir in "$PWD/i18n" "$PWD/system/i18n"; do
  if [[ -d $dir ]]; then
    SOURCEDIR=$dir
    break
  fi
done

if [[ -z $SOURCEDIR ]]; then
  echo "No i18n directory found - cancelling translations push"
  exit 0
fi

PROJ_SLUG="${{ github.event.repository.name }}"
PROJ_SLUG=$(echo "$PROJ_SLUG" | tr '[:upper:]' '[:lower:]')

echo "Pushing translations to Translation Manager"
echo "Project: $PROJ_SLUG"
echo "Version: $TRANSLATION_VERSION_NUMBER"
echo "Source:  $SOURCEDIR"

box pixl8 translations setEndpoint endpoint="$INPUT_TRANSLATIONS_ENDPOINT"
box pixl8 translations setCredentials apiKey="$INPUT_TRANSLATIONS_API_KEY"
box pixl8 translations push projectSlug="$PROJ_SLUG" projectVersion="$TRANSLATION_VERSION_NUMBER" sourceDirectory="$SOURCEDIR"