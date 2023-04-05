#!/bin/bash

export PROJECT_ROOT="$(pwd)"
. $PROJECT_ROOT/config

# mar 2 2023 - ver 3.14 release
# https://github.com/pantheon-systems/terminus/releases
mkdir -p ~/terminus && cd ~/terminus
curl -L https://github.com/pantheon-systems/terminus/releases/download/3.1.4/terminus.phar --output terminus
chmod +x terminus
# this will make sure you get the latest terminus version
./terminus self:update
sudo ln -s ~/terminus/terminus /usr/local/bin/terminus

# /home/runner/terminus/vendor/bin/terminus self:info
# /home/runner/terminus/vendor/bin/terminus auth:login --machine-token="$MACHINETOKEN" --email="$PANTHEONEMAIL"
# /home/runner/terminus/vendor/bin/terminus auth:whoami
# /home/runner/terminus/vendor/bin/terminus connection:set $PANTHEONSITENAME.$PANTHEONENV sftp

# /home/runner/terminus/vendor/bin/terminus art

printf "[\e[0;34mNOTICE\e[0m] Terminus Setup START!!!.\n"

echo "$PANTHEON_TERMINUS_MACHINE_TOKEN"
echo $PANTHEON_TERMINUS_MACHINE_TOKEN
echo PANTHEONEMAIL
printf "[\e[0;34mNOTICE\e[0m] Terminus Setup asdfasdffds!!.\n"
terminus self:info
terminus art
terminus auth:login --machine-token="$PANTHEON_TERMINUS_MACHINE_TOKEN"
terminus auth:whoami
#terminus connection:set $PANTHEONSITENAME.$PANTHEONENV sftp



# ~/terminus/vendor/bin/terminus self:info
# ~/terminus/vendor/bin/terminus auth:login --machine-token="$MACHINETOKEN" --email="$PANTHEONEMAIL"
# ~/terminus/vendor/bin/terminus auth:whoami
# ~/terminus/vendor/bin/terminus connection:set $PANTHEONSITENAME.$PANTHEONENV sftp

# ~/terminus/vendor/bin/terminus art