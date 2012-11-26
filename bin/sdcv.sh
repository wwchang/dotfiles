#!/usr/bin/env bash

# used to add some features to original command sdcv.
# added features:
#       espeak automatically.

# usage:
# $ sdcv.sh "WORD1" "WORD2" ...

for Word in "$*"; do
    # Words[$N] = $Word
    sdcv "$Word" ; echo "$Word" | espeak;
done
