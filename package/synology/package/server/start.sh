#!/bin/sh

export FILEBOT_NODE_HOST="0.0.0.0" # bind to all interfaces
export FILEBOT_NODE_AUTH="SYNO"

export FILEBOT_NODE_HTTP="YES"
export FILEBOT_NODE_HTTP_PORT="5452"

export FILEBOT_NODE_HTTPS="YES"
export FILEBOT_NODE_HTTPS_PORT="5453"
export FILEBOT_NODE_HTTPS_KEY="/usr/syno/etc/certificate/system/default/privkey.pem"
export FILEBOT_NODE_HTTPS_CRT="/usr/syno/etc/certificate/system/default/cert.pem"


export USER="admin"                                                                           # set admin as filebot user
export JAVA_OPTS=`free | awk -vm=1024 -vp=0.7 '/Mem:/ {printf "-Xmx%dm", ($2*p)/m; exit}'`    # set -Xmx to 0.7 of physical memory


export FILEBOT_CMD="filebot"
export FILEBOT_CMD_CWD="$SYNOPKG_PKGDEST_VOL"
export FILEBOT_CMD_UID=`id -u $USER`
export FILEBOT_CMD_GID=`cat /etc/group | grep 'administrators' | cut -d: -f3`                 # cannot use `id -u $USER` because the result is 100:users but we need 101:administrators because users don't have execute permissions

export FILEBOT_NODE_CLIENT=""                                                                 # serve client-side code via DSM only


# set working dir
cd "$SYNOPKG_PKGDEST"

# --max_executable_size (max size of executable memory (in Mbytes))
# --optimize_for_size (Enables optimizations which favor memory size over execution speed.)
# --use_idle_notification (Use idle notification to reduce memory footprint.)
node --max_executable_size=16 --optimize_for_size --use_idle_notification "server/app.js"
