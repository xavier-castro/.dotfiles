-- AppleScript to open file in Neovim inside Ghostty
--
-- Source:
-- Modified from https://github.com/kovidgoyal/kitty/issues/4460#issuecomment-2677434820
-- 
-- Open Automator, create a Quick Action (must later be saved in "~/Library/Services"), and select the "Run AppleScript" workflow action before pasting this script with the following configuration:
-- 
-- - Workflow receives: files or folders
-- - In: Finder.app

on run {input, parameters}
    set thePath to POSIX path of input
    set q to quoted form of thePath
    set parentPath to do shell script "dirname " & q
    set q1 to quoted form of parentPath
    set filename to do shell script "basename " & q
    set q2 to quoted form of filename
    
    -- Check if Ghostty is running
    tell application "System Events"
        set isGhosttyRunning to (exists (processes where name is "ghostty"))
    end tell
    
    tell application "ghostty"
        activate
        
        delay 0.5
        
        -- Create a new tab only if Ghostty is already running
        if isGhosttyRunning then
            tell application "System Events"
                keystroke "t" using command down
            end tell
            delay 0.5
        end if
        
        -- Send commands as keystrokes
        tell application "System Events"
            keystroke "cd " & q1 & " && nvim " & q2
            keystroke return
        end tell
    end tell
end run

-- Finally, go to System Settings > Keyboard > Keyboard Shortcuts > Services > Files and Folders and assign a keyboard shortcut to your Quick Action workflow.