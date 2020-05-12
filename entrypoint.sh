#!/bin/sh -l

echo "Starts"
FOLDER="$1"
GITHUB_USERNAME="$2"
GITHUB_REPO="$3"
GIT_USER_EMAIL="$4"
RESET_OR_MODIFY="$5"

CLONE_DIR=$(mktemp -d)

# Setup git
git config --global user.email "$GIT_USER_EMAIL"
git config --global user.name "$GITHUB_USERNAME"
git clone "https://$API_TOKEN_GITHUB@github.com/$GITHUB_USERNAME/$GITHUB_REPO.git" "$CLONE_DIR"

ls -la "$CLONE_DIR"

# if [[ $RESET_OR_MODIFY =~ "reset"]]; then
  # Copy files into the git and deletes all git
  find "$CLONE_DIR" | grep -v "^$CLONE_DIR/\.git" | grep -v "^$CLONE_DIR$" | xargs rm -rf # delete all files (to handle deletions)
# fi

ls -la "$CLONE_DIR"

cp -r "$FOLDER"/* "$CLONE_DIR"

cd "$CLONE_DIR"

git add .
git commit --message "Update from https://github.com/$GITHUB_REPOSITORY/commit/$GITHUB_SHA)"
git push origin master
