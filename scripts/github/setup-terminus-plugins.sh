#!/bin/bash

export PROJECT_ROOT="$(pwd)"
. $PROJECT_ROOT/config

terminus self:plugin:install terminus-rsync-plugin