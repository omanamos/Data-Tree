#!/bin/bash
# See https://medium.com/@nthgergo/publishing-gh-pages-with-travis-ci-53a8270e87db
set -o errexit

# build (CHANGE THIS)
npm run build

echo "Travis Branch: $TRAVIS_BRANCH";

# Exit if branch is not master
# if ["$TRAVIS_BRANCH" != "master" ]; then exit 0; fi

# Remove and Recreate tempGHPages directory
rm -rf tempGHPages
mkdir tempGHPages

# Init
cd tempGHPages
git init

# config
git config --global user.email "cchandurkar@gmail.com"
git config --global user.name "cchandurkar"

# checkout
git checkout -b gh-pages
git pull master:gh-pages

# Copy Files
cp -r ./docs ./tempGHPages
cp -a ./dist/. ./tempGHPages

# deploy
git add --all
git commit -m "Updating Docs"
echo "Pushing https://${GITHUB_TOKEN}@${GITHUB_REF}.git";

git push "https://${GITHUB_TOKEN}@${GITHUB_REF}.git" master:gh-pages > /dev/null 2>&1

# Remove tempGHPages directory
rm -rf tempGHPages
