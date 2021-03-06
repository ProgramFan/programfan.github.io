#!/bin/bash

# only proceed script when started not by pull request (PR)
if [ $TRAVIS_PULL_REQUEST == "true" ]; then
    echo "this is PR, exiting"
    exit 0
fi

# enable error reporting to the console
set -e

# build site with jekyll, by default to `_site' folder
jekyll build

# cleanup
rm -rf ../programfan.github.io.master

url=https://${GH_TOKEN}@github.com/Programfan/programfan.github.io.git
# clone `master' branch of the repository using encrypted GH_TOKEN for
# authentification
git clone ${url} -b master ../programfan.github.io.master

# copy generated HTML site to `master' branch
rm -rf ../programfan.github.io.master/*
cp -rf _site/* ../programfan.github.io.master

# commit and push generated content to `master' branch
# since repository was cloned in write mode with token auth - we can push
# there
cd ../programfan.github.io.master
git config user.email "zyangmath@gmail.com"
git config user.name "Yang Zhang"
git add -A .
git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"
git push origin master:master

exit 0

