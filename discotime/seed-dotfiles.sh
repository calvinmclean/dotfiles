#!/bin/sh
set -eu

# Wiring may populate home with mountpoints before Discobox checks /etc/skel.
# Resolve the provisioned account rather than assuming a Linux home path.
user=$(jq -er '.user.name' /etc/discobox/sandbox.json)
home=$(getent passwd "$user" | cut -d: -f6)
test -n "$home"

# Run as the user so new files have the right owner; preserve existing configs.
runuser -u "$user" -- cp -R --no-clobber /etc/skel/. "$home/"
