#!/bin/bash
LOG_FILE="claude_clicker.log"

echo "Starting Claude permission auto-clicker at $(date)" > $LOG_FILE

while true; do
  echo "Checking for Allow button at $(date)" >> $LOG_FILE

  OUTPUT=$(osascript -e '
tell application "System Events"
    if exists process "Claude" then
        log "Claude process found"
        tell process "Claude"
            if exists button "Allow for This Chat" of group 2 of group 1 of group 2 of group 1 of UI element "Claude" of group 1 of group 1 of group 1 of group 1 of window "Claude" then
                click button "Allow for This Chat" of group 2 of group 1 of group 2 of group 1 of UI element "Claude" of group 1 of group 1 of group 1 of group 1 of window "Claude"
                return "Button clicked"
            else
                return "Button not found"
            end if
        end tell
    else
        return "Claude not running"
    end if
end tell
  ')

  echo "$OUTPUT" >> $LOG_FILE
  sleep 1
done
