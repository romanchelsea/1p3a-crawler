#!/usr/bin/env bash

# Run below command if you have editted this file in Windows,
# in order to convert line endings to Unix style.
# sed -i -e 's/\r$//' <filename>
#
# Usage:  ./scripts/login.sh  -u romanchelsea -p <password> -l https://www.1point3acres.com/bbs/member.php?mod=logging\&action=login\&loginsubmit=yes\&infloat=yes\&lssubmit=yesls
#
# This script makes a post request to 1point3acres.com/bbs with username and
# password, then stores the cookie locally for visiting other pages.

set -euo pipefail

# Ignore positional parameters for now
# POSITIONAL=()

while [[ $# -gt 0 ]]
do
  key="$1"

  case $key in
    -u|--username)
    L_USERNAME="$2"
    shift
    shift
    ;;
    -p|--password)
    L_PASSWORD="$2"
    shift
    shift
    ;;
    -l|--location)
    L_LOCATION="$2"
    shift
    shift
    ;;
    *)
    POSITIONAL+=("$1")
    shift
    ;;
  esac
done

# restore positional parameters
# set -- "${POSITIONAL[@]}"

echo Username is: "$L_USERNAME"
echo Location: "$L_LOCATION"
echo You must provide an non-empty password

curl -k -L -c ./cookies -d "username=${L_USERNAME}&cookietime=2592000&password=${L_PASSWORD}" ${L_LOCATION} > /dev/null
