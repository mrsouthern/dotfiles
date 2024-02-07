#!/usr/bin/env bash

GIT_CMD="$(which git)"
GIT_BRANCH="$GIT_CMD branch"
GIT_PUSH_ORIGIN="$GIT_CMD push origin"
GIT_FETCH_ORIGIN="$GIT_CMD fetch origin"
GIT_REMOTE_PRUNE="$GIT_CMD remote prune origin"
GIT_CHECK_BRANCH="$GIT_CMD show-ref refs/heads" # append /branch_name

# Check if the user has provided input
if [ $# -ne 2 ]; then
    echo "$0": usage: rename-branch OLD_BRANCH_NAME NEW_BRANCH_NAME
    exit 1
fi

OLD_BRANCH_NAME=$1
NEW_BRANCH_NAME=$2

# Check if old branch exists
BRANCH_EXISTS=$("$GIT_CHECK_BRANCH"/"$OLD_BRANCH_NAME")
if [ -z "$BRANCH_EXISTS" ]; then
    echo There is no branch with name "$OLD_BRANCH_NAME"
    exit 1
fi

# Rename branch
echo Renaming branch "$OLD_BRANCH_NAME" to "$NEW_BRANCH_NAME"
$GIT_BRANCH "$NEW_BRANCH_NAME" "origin/$OLD_BRANCH_NAME"
$GIT_PUSH_ORIGIN --set-upstream "$NEW_BRANCH_NAME"
$GIT_PUSH_ORIGIN ":$OLD_BRANCH_NAME"

echo Clean local repository
$GIT_FETCH_ORIGIN
$GIT_REMOTE_PRUNE
echo Done
