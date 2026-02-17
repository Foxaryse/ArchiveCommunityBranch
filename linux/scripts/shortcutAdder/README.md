# Description
This script adds Voices of the Void as a customized shortcut to steam with the necessary settings to run it and customization.

By default it sets the compatibility to Proton 10, but it may be changed to your suit your own preferences.
# Features
```py        
-h, --help                  Help menu
-e, --exe                   Path to the folder containing VotV.exe
-rs, --restoreShortcut      Restores shortcuts.vdf from backup_shortcuts.vdf.
-rc, --restoreConfig        Restores config.vdf from backup_config.vdf.
-rb, --removeBackup         Deletes the backup files.
```
# Usage
## In a terminal:
```
python shortcutAdder.py
```
- Executing the script without arguments will trigger an "interactive" mode.

- You will be prompted to add the path to the folder containing VotV.exe
- When you do it will then install it as a shortcut in steam automatically
- Start/Restart steam and it should show up in "Uncategorized"

```
python shortcutAdder.py -e path/to/folder/of/VotV.exe
```
- Upon execution it will automatically create the shortcut in steam

- Start/Restart steam and it should show up in "Uncategorized"
