#!/bin/sh

# | FILENAME
# |   hosts.sh
# |
# | DESCRIPTION
# |   This script is used for updating host file for EBS configuration.
# |
# |
# |
# | LOCATION
# |
# | Usage:
# |
# | PLATFORM
# |   Unix Generic
# |

#
# Check if the user running the config script is the oracle user
#
CURRENT_USER=$(whoami)

if [ "$CURRENT_USER" != "oracle"  ]
then
    printf "\n"
    printf "\n=================================================="
    printf "\n This script can only be executed by the oracle user"
    printf "\nPlease login as the oracle user and re-run this script.";
    printf "\n======================================================="
    printf "\n"
    exit;
fi

FULL_HOST_NAME=$(hostname -f)
HOST_NAME=$(echo "$FULL_HOST_NAME" | cut -d "." -f1)

PRIMARY_HOST=$1
SCRIPT_BASE=$2
addnode_pairs_file="${SCRIPT_BASE}/addnodepairs_${HOST_NAME}.txt"
addnode_pairs_file_src="${SCRIPT_BASE}/appspairs.txt"
sed -r '/s_admhost|s_atName/!s/'"$PRIMARY_HOST"'/'"$HOST_NAME"'/g' "$addnode_pairs_file_src" > "$addnode_pairs_file"
sed -i "s/s_ohs_instance=.*/s_ohs_instance=EBS_web_$HOST_NAME/" "$addnode_pairs_file"