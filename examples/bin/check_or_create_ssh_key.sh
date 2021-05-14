#!/bin/bash

# Checks for the existence of the default RSA keys. If neither exist, it creates them.
# If the state is unknown, then it throws an error.

# If one or other of the files does not exist, then
if { [[ -a ~/.ssh/id_rsa ]] && [[ ! -a ~/.ssh/id_rsa.pub ]]; } || { [[ ! -a ~/.ssh/id_rsa ]] && [[ -a ~/.ssh/id_rsa.pub ]]; }
then
  echo "One of .ssh/id_rsa and .ssh/id_rsa.pub exists, and one does not. Cannot continue"
  exit 1
fi

# If neither file exists, create a key
if [[ ! -a ~/.ssh/id_rsa ]] && [[ ! -a ~/.ssh/id_rsa.pub ]]
then
  ssh-keygen -b 2048 -t rsa -N "" -f ~/.ssh/id_rsa -q
fi
