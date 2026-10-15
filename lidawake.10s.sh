#!/bin/bash
# <swiftbar.hideAbout>true</swiftbar.hideAbout>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>
# <swiftbar.hideLastUpdated>true</swiftbar.hideLastUpdated>
# Toggle "stay awake with the lid closed" (pmset disablesleep). SwiftBar plugin + CLI.
state() { pmset -g | awk '/SleepDisabled/{v=$2} END{print v+0}'; }  # key absent = 0

if [ "$1" = toggle ]; then
  new=$(( 1 - $(state) ))
  sudo -n /usr/bin/pmset -a disablesleep "$new" || { echo "sudo rule missing, rerun install.sh" >&2; exit 1; }
  [ -t 1 ] && { [ "$new" = 1 ] && echo "lid closed: stays AWAKE" || echo "lid closed: sleeps (normal)"; }
  exit 0
fi

if [ "$(state)" = 1 ]; then
  echo "| sfimage=sun.max.fill"
  echo "---"
  echo "Awake with lid closed"
  echo "Let it sleep again | bash='$0' param1=toggle terminal=false refresh=true"
else
  echo "| sfimage=moon.zzz"
  echo "---"
  echo "Sleeps with lid closed (normal)"
  echo "Keep awake with lid closed | bash='$0' param1=toggle terminal=false refresh=true"
fi
