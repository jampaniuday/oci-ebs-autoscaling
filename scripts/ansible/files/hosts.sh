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

ip_address=$(hostname -i)
host_name=$(hostname)
phy_domain=$(dnsdomainname)
script_dir=$1
log_domain=$2

if [ -f /home/oracle/.hosts.done ]; then
    exit 0
fi
sudo cp "${script_dir}"/hosts.orig "${script_dir}"/hosts
scan_etc_hosts="$(grep -n "$host_name"."$phy_domain" "${script_dir}"/hosts | cut -f1 -d:)"
etc_host_entry="${ip_address}   ${host_name}.${log_domain}    ${host_name}    ${host_name}.${phy_domain}      ${host_name}"

if [ ! -z "$scan_etc_hosts" ]
then
    while read -r line_number; do
        sudo sed -i "${line_number}s/.*/${etc_host_entry}/" "${script_dir}"/hosts
    done <<< "$scan_etc_hosts"
else
    echo "$etc_host_entry" | sudo tee -a "${script_dir}"/hosts > /dev/null
fi
sudo cp "${script_dir}"/hosts /etc/hosts
sudo mv "${script_dir}"/hosts "${script_dir}"/hosts.orig
touch /home/oracle/.hosts.done