#!/bin/bash

ls
cd $PROJECT_ROOT
ls

# deploy pantheon yml files
rsync -rLvzc --size-only --ipv4 --progress -e 'ssh -p 2222' ./pantheon.yml --temp-dir=~/tmp/ $PANTHEONENV.$PANTHEONSITEUUID@appserver.$PANTHEONENV.$PANTHEONSITEUUID.drush.in:code/ --exclude='*.git*' --exclude node_modules/ --exclude gulp/ --exclude source/
printf "[\e[0;34mNOTICE\e[0m] Deployed pantheon.yml file\n"

# deploy wp cli yml file
rsync -rLvzc --size-only --ipv4 --progress -e 'ssh -p 2222' ./wp-cli.yml --temp-dir=~/tmp/ $PANTHEONENV.$PANTHEONSITEUUID@appserver.$PANTHEONENV.$PANTHEONSITEUUID.drush.in:code/ --exclude='*.git*' --exclude node_modules/ --exclude gulp/ --exclude source/
printf "[\e[0;34mNOTICE\e[0m] Deployed wp-cli.yml file\n"

# deploy vendor folder
rsync -rLvzc --ipv4 --progress -e 'ssh -p 2222' ./vendor/. --temp-dir=~/tmp/ $PANTHEONENV.$PANTHEONSITEUUID@appserver.$PANTHEONENV.$PANTHEONSITEUUID.drush.in:code/vendor/ --update
printf "[\e[0;34mNOTICE\e[0m] Deployed vendor folder\n"

# deploy private folder for quicksilver scripts
rsync -rLvzc --ipv4 --progress -e 'ssh -p 2222' ./web/private/. --temp-dir=~/tmp/ $PANTHEONENV.$PANTHEONSITEUUID@appserver.$PANTHEONENV.$PANTHEONSITEUUID.drush.in:code/web/private/ --exclude='*.git*' --exclude node_modules/ --exclude gulp/ --exclude source/
printf "[\e[0;34mNOTICE\e[0m] Deployed private folder for quicksilver scripts\n"

# deploy plugins and themes
rsync -rLvzc --size-only --ipv4 --progress -e 'ssh -p 2222' ./web/wp-content/. --temp-dir=~/tmp/ $PANTHEONENV.$PANTHEONSITEUUID@appserver.$PANTHEONENV.$PANTHEONSITEUUID.drush.in:code/web/wp-content/ --exclude='*.git*' --exclude node_modules/ --exclude gulp/ --exclude source/
printf "[\e[0;34mNOTICE\e[0m] Deployed plugin and themes\n"

# deploy core via rsync + wp-config
# rsync -rLvzc --size-only --ipv4 --progress -e 'ssh -p 2222' ./web/wp/. --temp-dir=~/tmp/ $PANTHEONENV.$PANTHEONSITEUUID@appserver.$PANTHEONENV.$PANTHEONSITEUUID.drush.in:code/web/wp/ --exclude='*.git*' --exclude node_modules/ --exclude wp-content/ --exclude gulp/ --exclude source/

#dont forget to elete the config to avoid redirect loop
rm $PROJECT_ROOT/web/wp/wp-config.php

# deploy core and root files
rsync -rLvzc --size-only --ipv4 --progress -e 'ssh -p 2222' ./web/. --temp-dir=~/tmp/ $PANTHEONENV.$PANTHEONSITEUUID@appserver.$PANTHEONENV.$PANTHEONSITEUUID.drush.in:code/web/ --exclude='*.git*' --exclude node_modules/ --exclude wp-content/ --exclude gulp/ --exclude source/

terminus art

MSG1="$GH_REF2"
export MSG1
DEPLOYMSG="Complete rebuild. Deployed from GitHub $MSG1"
export DEPLOYMSG
echo "$DEPLOYMSG"
#echo ::set-env name=PULL_NUMBER::$(echo "$GH_REF2" | awk -F / '{print $3}')

terminus env:commit --message "$DEPLOYMSG" --force -- $PANTHEONSITENAME.$PANTHEONENV

printf "[\e[0;34mNOTICE\e[0m] Deployed core and wp-config\n"

# setup backstop script
# sh $PROJECT_ROOT/scripts/github/setup-backstop