#!/bin/bash

export SECRET_DIR=$1
export SRC_DIR=$2
export GIT_URL=$3

echo "Git URL : $GIT_URL"

export GIT_HOST=$(sed 's/.*[@]\(.*\)[:].*/\1/' <<< "$GIT_URL")

echo "Git Host : $GIT_HOST"

cp /etc/ssh-keys/id_rsa /usr/local/openunison/.ssh/
chmod go-rwx /usr/local/openunison/.ssh/id_rsa
ssh-keyscan -H $GIT_HOST > /usr/local/openunison/.ssh/known_hosts

git clone $GIT_URL $SRC_DIR

cd $SRC_DIR

git config user.email "$GIT_EMAIL"
git config user.name "$GIT_USERNAME"


/usr/local/openunison/createfiles.sh $SECRET_DIR $SRC_DIR

git add *

git status

git commit -m "$GIT_COMMIT_MSG"
git push
