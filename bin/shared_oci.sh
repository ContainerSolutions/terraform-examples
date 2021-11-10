#!/bin/bash

set -o errexit
set -o pipefail


if [ -z "$OCI_CLI_CONFIG_FILE" ]
then
  OCI_CLI_CONFIG_FILE="${HOME}/.oci/config"
  echo "By default we look for oci config file in ${OCI_CLI_CONFIG_FILE}"
  echo "To use a custom oci config path, run 'export OCI_CLI_CONFIG_FILE=<YOUR_OCI_CLI_CONFIG_FILE>'"
  if [ ! -f "$OCI_CLI_CONFIG_FILE" ]
  then
    echo "No config file was found"
    echo "Make sure oci-cli is initialised, by running: 'oci setup config'"
    echo "More info available here: https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm#configfile__setupdialog"
  fi
fi
if [ -z "$TF_VAR_config_file_profile" ]
then
  TF_VAR_config_file_profile="DEFAULT"
  echo "By default we use profile: ${TF_VAR_config_file_profile}"
  echo "To use a custom profile, run 'export TF_VAR_config_file_profile=<YOUR_CONFIG_FILE_PROFILE>'"
  echo "More info avaiable at: https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformproviderconfiguration.htm#terraformproviderconfiguration_topic-SDK_and_CLI_Config_File"
fi

set -o nounset

export OCI_CLI_CONFIG_FILE
export TF_VAR_config_file_profile
