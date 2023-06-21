#!/bin/bash

HOSTS_FILE="/etc/hosts"
START_LINE="# @@@ PRODUCTIVITY BOOSTER @@@"
END_LINE="# @@@ PRODUCTIVITY BOOSTER END @@@"

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
  echo "Run this script as root or use sudo."
  exit 1
fi

# Check if the placeholder lines exist in the hosts file
if grep -Fxq "$START_LINE" "$HOSTS_FILE" && grep -Fxq "$END_LINE" "$HOSTS_FILE"; then
  # Remove the existing block between the start and end lines
  sed -i.bak "/$START_LINE/,/$END_LINE/d" "$HOSTS_FILE"
  if [[ $? -eq 0 ]]; then
    echo "Existing PRODUCTIVITY BOOSTER lines removed successfully!"
  else
    echo "Failed to remove existing PRODUCTIVITY BOOSTER lines. Check /etc/hosts to see what's up."
    exit 1
  fi
  # We're done here.
  exit 0
elif grep -Fxq "$START_LINE" "$HOSTS_FILE" || grep -Fxq "$END_LINE" "$HOSTS_FILE"; then
  echo "PRODUCTIVITY BOOSTER lines are corrupt. Check /etc/hosts"
  exit 1
fi

# Define the entries to be added to the hosts file
ENTRIES=$(cat <<EOF
127.0.0.1    www.instagram.com instagram.com
::1    www.facebook.com facebook.com fb.com
0.0.0.0    twitter.com www.twitter.com

EOF
)

# Add the new entries between the placeholder lines
echo "$START_LINE" >> "$HOSTS_FILE"
echo "$ENTRIES" >> "$HOSTS_FILE"
echo "$END_LINE" >> "$HOSTS_FILE"

echo "New PRODUCTIVITY BOOSTER lines added successfully!"
