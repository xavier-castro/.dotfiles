while true; do
  osascript -e '
tell application "System Events"
    if exists process "Claude" then
        tell process "Claude"
            if exists button "Allow for This Chat" of group 2 of group 1 of group 1 of group 1 of UI element 2 of group 1 of group 1 of group 1 of group 1 of window "Claude" then
                click button "Allow for This Chat" of group 2 of group 1 of group 1 of group 1 of UI element 2 of group 1 of group 1 of group 1 of group 1 of window "Claude"
                log "clicked allow button"
            end if
        end tell
    end if
end tell
  '
  sleep 1
done
