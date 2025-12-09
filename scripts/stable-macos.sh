#!/usr/bin/env bash

#################################################################
#    This script mimics the github action which does the build  #
#################################################################


# Step 0 - set the environment variables
export APP_NAME=Asimov
# ASSETS_REPOSITORY is where all the downloads are.
# VSCodium has this be the current repo, voideditor/void-builder:
# ASSETS_REPOSITORY: ${{ github.repository }}
#  ASSETS_REPOSITORY: ${{ github.repository_owner }}/binaries
export BINARY_NAME=asimov
#GH_REPO_PATH: ${{ github.repository_owner }}/binaries
#ORG_NAME: ${{ github.repository_owner }}
export OS_NAME=osx
#VERSIONS_REPOSITORY: ${{ github.repository_owner }}/versions
export VSCODE_QUALITY=stable
export VSCODE_ARCH="${VSCODE_ARCH:-arm64}"

export CI_BUILD=no
export GITHUB_REPOSITORY=
export RELEASE_VERSION=
export VSCODE_LATEST=
export GITHUB_ENV=

export SHOULD_DEPLOY=no
export SHOULD_BUILD=yes


# Step 1
#PULL_REQUEST_ID: ${{ github.event.inputs.checkout_pr }}
. get_pr.sh

# Step 2
#VOID_COMMIT: ${{ github.event.inputs.void_commit }} # Void added this
#VOID_RELEASE: ${{ github.event.inputs.void_release }} # Void added this
. get_repo.sh

# Step 3
#GENERATE_ASSETS: ${{ github.event.inputs.generate_assets }}
#. check_cron_or_pr.sh

# Step 4
#if [[ "$SHOULD_DEPLOY" == "yes" ]]; then
#GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
#. check_tags.sh
#fi

# Step 5
if [[ "$SHOULD_BUILD" == "yes" ]]; then
#GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
./build.sh
fi

# Step 6
if [[ "$SHOULD_BUILD" == "yes" && "$SHOULD_DEPLOY" == "yes" ]]; then
#          CERTIFICATE_OSX_APP_PASSWORD: ${{ secrets.CERTIFICATE_OSX_NEW_APP_PASSWORD }}
#          CERTIFICATE_OSX_ID: ${{ secrets.CERTIFICATE_OSX_NEW_ID }}
#          CERTIFICATE_OSX_P12_DATA: ${{ secrets.CERTIFICATE_OSX_NEW_P12_DATA }}
#          CERTIFICATE_OSX_P12_PASSWORD: ${{ secrets.CERTIFICATE_OSX_NEW_P12_PASSWORD }}
#          CERTIFICATE_OSX_TEAM_ID: ${{ secrets.CERTIFICATE_OSX_NEW_TEAM_ID }}
./prepare_assets.sh
fi

# Step 7
if [[ "$SHOULD_BUILD" == "yes" && "$SHOULD_DEPLOY" == "yes" ]]; then
#          GITHUB_TOKEN: ${{ secrets.STRONGER_GITHUB_TOKEN }} # Void bumped this to stronger
./release.sh
fi

# Step 8
if [[ "$SHOULD_DEPLOY" == "yes" ]]; then
#          FORCE_UPDATE: ${{ github.event.inputs.force_version }}
#          GITHUB_TOKEN: ${{ secrets.STRONGER_GITHUB_TOKEN }}
#          GITHUB_USERNAME: ${{ github.repository_owner }}
./update_version.sh
fi

