#!/bin/sh
# Starts Cobbler
#
# Normally this script is invoked by newPhysServer.pl
# 
if [ $# -ne 1 ]; then
  echo Usage: $0 new_server_hostname
  exit 1
fi
#set -x

# identifies the server in the cobbler system
new_server=$1
new_fqdn=$1.serv.example.net
# get the internal IP
new_IP=`dig +short $new_fqdn`

# config nagios 
ssh nagios.serv.example.net 'cd /etc/nagios3/servers/hw/tools; ./generate $new_server; /etc/init.d/nagios3 reload'

# Insert the new_server_fqdn in the cobbler settings file.
# The proper soluton is to have cobbler manage multiple profiles or systems, but this is simpler
sed -i[sav] -e "s/^hostname: .*\$/hostname: $new_fqdn/" /etc/cobbler/settings
sed -i[sav] -e "s/^hostIP: .*\$/hostIP: $new_IP/" /etc/cobbler/settings

service cobblerd restart
cobbler sync

# remove all old certs just in case we are re-installing a server
puppet cert clean --all
service puppetmaster restart

echo Ready to install $new_server at $new_IP
echo Start PXE by booting the new server
exit 0
#------------ end ------------------
