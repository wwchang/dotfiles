#!/usr/bin/env bash

for remote in origin GitCafe Bitbucket; do
  # debug: echo $remote
  git push $remote master
done
