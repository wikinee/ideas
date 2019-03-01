#!/bin/bash
# ------------------------------
# Filename: SyncAfterFork.sh
# Date: 2017.03.17
# Author: wikinee
# Description: A script sync with author after fork.
# Modify: 2017.03.17
# ------------------------------

echo "git remote -v"
git remote -v

echo "git remote add author git repo"
# NOTE: fix it for you want sync direction
git remote add upstream https://github.com/AUTHOR_REPO/AUTHOR_REPO_NAME.git

echo "git remove -v (after add if sucess)"
git remote -v

echo "fetch; merge"
git fetch upstream
git checkout master
git merge master upstream/master