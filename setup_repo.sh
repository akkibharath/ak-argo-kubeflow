#!/bin/bash

# Perform a simple recursive find-and-replace on all variables defined in setup.conf
export SETUP_CONF_PATH=$1 # location of the setup config
export DISTRIBUTION_PATH=./distribution # folder where the distribution's YAML files are to be found
# While loop that will perform simple parsing. On each line MY_VAR=123 will be read into PLACEHOLDER=MY_VAR, VALUE=123
while IFS="=" read PLACEHOLDER VALUE
do
  # recursively look for $PLACEHOLDER in all files in the $DISTRIBUTION_PATH and replace it with $VALUE
  VALUE=$(echo "${VALUE////$'\/'}") # escape forward slashes (needed for sed to work correctly)
  grep -rli ${PLACEHOLDER} ${DISTRIBUTION_PATH}/* | xargs -i@ sed -i "s/${PLACEHOLDER}/${VALUE}/g" @ # perform recursive replace
done <${SETUP_CONF_PATH} # pass the setup config into the while loop
