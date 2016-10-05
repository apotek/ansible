#!/bin/bash

echo "Refresh from upstream"
git fetch -p upstream

echo "Checkout devel"
if git checkout devel; then
  echo "Rebase from upstream"
  if git rebase upstream/devel; then
    echo "send back to my git fork."
    git push -f origin devel
  fi
fi

