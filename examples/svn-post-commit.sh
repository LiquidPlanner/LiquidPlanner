#!/bin/sh
#
# simple SVN post-commit hook to LiquidPlanner
#
PATH=/usr/local/bin:/usr/bin

REPO="$1"
REV="$2"

svn log -r $REV $REPO | ./post-commit.rb post-commit.yml

