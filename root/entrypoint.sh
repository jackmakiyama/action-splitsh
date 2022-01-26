#!/bin/bash

ssh-keyscan github.com > /root/.ssh/known_hosts

if [ -n "${INPUT_SPLIT_DEPLOY_KEY}" ]; then
    echo "${INPUT_SPLIT_DEPLOY_KEY}" > /root/.ssh/github
    chmod 0600 /root/.ssh/github
fi

splitsh-lite --prefix="${INPUT_SPLIT_PREFIX}" --target=refs/heads/${INPUT_SPLIT} --scratch

ls -la /usr/local/bin/
ls -la /usr/bin/

ORIGIN=`git remote get-url origin`

if [ -n "${INPUT_SPLIT_DEPLOY_KEY}" ] && \
    [ -n "${INPUT_SPLIT}" ] && \
    {  [ "1" = "${INPUT_SPLIT_ONLY_IF:-1}" ] || [ "https://github.com/${INPUT_SPLIT_ONLY_IF:-1}" = "$ORIGIN" ]; }; then
    git remote add split github:${INPUT_SPLIT}
    git push -f -u split ${INPUT_SPLIT}:${INPUT_SPLIT_BRANCH:-main}
fi

git remote rm split
