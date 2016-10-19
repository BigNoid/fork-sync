#!/bin/bash
#
#     Copyright (C) 2016 BigNoid
#
# This script is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This script is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this script; see the file LICENSE.  If not, see
# <http://www.gnu.org/licenses/>.
#

BRANCH=master
UPSTREAM=upstream
git stash
git checkout $BRANCH
git reset --hard
git fetch
git rebase
git fetch $UPSTREAM
git rebase $UPSTREAM/$BRANCH
git push origin $BRANCH

if [ "$1" = "pr" ]
then
    git branch -D $3
    git fetch -f $UPSTREAM pull/$2/head:$3
    git checkout $3
else
    echo "If you want to checkout a PR locally, run this script with arguments: pr <ID> <BRANCHNAME>"
fi
if [ "$1" = "new" ]
then
    git checkout -b $2
else
    echo "To checkout a new branch based on $UPSTREAM/$BRANCH use arguments: new <BRANCHNAME>"
fi
