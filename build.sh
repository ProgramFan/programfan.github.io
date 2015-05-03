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
echo $url
git clone ${url} -b master ../programfan.github.io.master

echo "Copying generated site."
# copy generated HTML site to `master' branch
cp -R _site/* ../programfan.github.io.master
echo "Copy done."

# commit and push generated content to `master' branch
# since repository was cloned in write mode with token auth - we can push
# there
cd ../programfan.github.io.master
git config user.email "zyangmath@gmail.com"
git config user.name "Yang Zhang"
git add -A .
git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"
echo "Pushing to remote"
git push ${url} master:master
echo "Done."

exit 0

