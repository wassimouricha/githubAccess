#!/bin/sh

set -e

git fetch origin $GITHUB_BASE_REF
commits=$(git rev-list --no-merges $GITHUB_SHA ^origin/$GITHUB_BASE_REF)

for commit in $commits; do
  message=$(git show -s --format=%B $commit)

  if ! echo "$message" | grep -qE '^(feat|fix|docs|style|refactor|test|chore)(\(.+\))?: .{1,}' ; then
    echo "Commit $commit does not follow the conventional commit format"
    exit 1
  fi
done
