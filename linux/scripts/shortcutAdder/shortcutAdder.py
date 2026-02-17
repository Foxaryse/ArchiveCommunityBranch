"""
Hello,

This is the second version of this script, 
I rewrote most of it to be an actual usable script rather then the proof of concept that it was.

I fairly happy as to how it turned out and might be updated in the future.

Thanks to SlepDepriv for making the compatibility setting section of it.

For now this script is LINUX ONLY (mainly tested on Bazzite), windows will be supported later
I'm sorry Mac users but I have no clue how to help yall lmfao

Discord: doctorkrazy
"""

try:
    import vdf
except ImportError:
    print("ERROR: vdf module not found.\n\nSolution:\nPlease install it using: \npip install vdf\n\n(This may depend on your system)")
    exit(1)

import os
import shutil
import argparse
import sys
from pathlib import Path

#
# Global Variables
#

# The app id that will be used for the shortcut, it MUST be in the negative to avoid clashing with other games
# Only modify this IF NECESSARY
APPID = -69420

# DO NOT TOUCH THIS, IF YOU TOUCH THIS YOU DIE (I'm lying but for real, please don't touch this, it's REALLY important)
CALCULATED_APP_ID = (2**32)+APPID

# Path to steam
steam_path = Path.home()/".steam/steam"

# Fucking abomination, but it works
steamuser_path = (lambda steamPath: steamPath / "userdata" / [d for d in os.listdir(steamPath / "userdata") if d.isdigit()][0])(Path.home() / ".steam" / "steam")

#
# Functions made to organize the code a bit
#

# Copies all the images from the shortcutAdder folder into the grid folder of steam.
# This is purely for the customization purposes
def addCustomizations(grid_path):
    images_dir = Path(__file__).parent/"images"

    if images_dir.exists():
        for file in os.listdir(images_dir):
            if file.lower().endswith((".png")):
                prevfile = file
                file = file.replace("APPID", str(CALCULATED_APP_ID))

                if "_widecover" in file:
                    file = file.replace("_widecover", "")
                if "_cover" in file:
                    file = file.replace("_cover", "p")
                
                shutil.copy(images_dir / prevfile, grid_path / file)
                print(f"Copying {file} to {grid_path}")

def removeBackup(backupName):
    if backupName.strip().lower() == "shortcuts":
        backup_shortcutPath = steamuser_path/"config/backup_shortcuts.vdf"
        if backup_shortcutPath.exists():
            backup_shortcutPath.unlink()   
            print("Removed backup_shortcuts.vdf")
        else:
            print("Could not find backup_shortcuts.vdf")

    elif backupName.strip().lower() == "config":
        backup_configPath = steam_path/"config/backup_config.vdf"
        if backup_configPath.exists():
            backup_configPath.unlink()   
            print("Removed backup_config.vdf")
        else:
            print("Could not find backup_config.vdf")


# Function to restore the shortcuts.vdf file
def restoreShortcut(shortcuts_path):
    try:
        backup_path = shortcuts_path.parent/"backup_shortcuts.vdf"
        if backup_path.exists():
            shutil.copy(backup_path, shortcuts_path)  
            print("Restored shortcuts.vdf from backup_shortcuts.vdf")

        else:
            print("backup_shortcuts.vdf file not found.")

        return
    
    except Exception as e:
        # A fucky wucky has happened, abandon ship
        print(f"Restoration failed unexpectedly, exiting program\n{e}")
        exit(1)

def restoreConfig(steam_path):
    config_path = steam_path/"config/config.vdf"
    try:
        backup_path = config_path.parent/"backup_config.vdf"
        if backup_path.exists():
            shutil.copy(backup_path, config_path)  
            print("Restored config.vdf from backup_config.vdf")

        else:
            print("backup_config.vdf file not found.")

        return
    
    except Exception as e:
        # A fucky wucky has happened, abandon ship
        print(f"Restoration failed unexpectedly, exiting program\n{e}")
        exit(1)

#
# Main function running the main operation of the file (damn who could've possibly guessed)
#

def main():

    # Arguments for the script, amazing I know
    parser = argparse.ArgumentParser(description="Adds a custom non-Steam game shortcut for Voices of the Void to Steam.")

    parser.add_argument('-e', '--exe', help='Path to the folder containing VotV.exe')
    parser.add_argument('-rs', '--restoreShortcut', action='store_true', help="Restores shortcuts.vdf from backup_shortcuts.vdf.")
    parser.add_argument('-rc', '--restoreConfig', action='store_true', help='Restores config.vdf from backup_config.vdf.')
    parser.add_argument('-rb', '--removeBackup', action='store_true', help='Deletes the backup files.')

    args = parser.parse_args()

    if args.removeBackup and not (args.restoreShortcut or args.restoreConfig):
        response = input("Which backup would you like to remove (shortcuts/config/all):").strip().lower()
        if response in ('shortcuts', 'shortcut'):
            removeBackup("shortcuts")
            return
        elif response == 'config':
            removeBackup("config")
            return
        elif response == 'all':
            removeBackup("shortcuts")
            removeBackup("config")
            return

    # This is here due to being used by both restore and shortcutAdder
    shortcuts_path = steamuser_path/"config/shortcuts.vdf"

    # If the user uses the script to restore the file, we restore the file
    if args.restoreShortcut:
        restoreShortcut(shortcuts_path)
        if args.removeBackup:
            removeBackup("shortcuts")

    if args.restoreConfig:
        restoreConfig(steam_path)
        if args.removeBackup:
            removeBackup("config")

    # If the user uses the script to create the shortcut, we create the shortcut
    elif args.exe:
        exe_path = Path(args.exe)

        if not exe_path.exists():
            print("Path invalid or doesn't exist")
            return

        if exe_path.name != "VotV.exe":
            exe_path = exe_path/"VotV.exe"
            if not exe_path.exists():
                print("VotV.exe not found in the specified folder.")
                return

        game_dir = exe_path.parent

        grid_path = steamuser_path/"config/grid"
        
        #
        # SHORTCUTS.vdf EDITING
        #
        print("\n\n---------- shortcuts.vdf section ----------")
        # Check if shortcuts.vdf exists in the first place (just in case), if not we create our own
        if shortcuts_path.exists():
            with open(shortcuts_path, "rb") as f:
                data = vdf.binary_loads(f.read())
            print("shortcuts.vdf already exists, adding onto it...")
        else:
            data = {"shortcuts": {}}
            print("shortcuts.vdf not found, creating it...")

        backup_shortcuts_path = shortcuts_path.parent/"backup_shortcuts.vdf"
        try:
            with open(backup_shortcuts_path, "wb") as f:
                f.write(vdf.binary_dumps(data))
            print("Created backup_shortcuts.vdf in: " + str(shortcuts_path.parent))
        except Exception as e:
            print(f"Failed to create backup_shortcuts.vdf\n{e}")

        # Check if a shortcut for Voices of the Void already exists, if it does, prompt the user if theywant to proceed or not
        existing_shortcut = False
        for key, shortcut in data["shortcuts"].items():
            # We check the path of the exe aswell just incase theywant to have multiple versions on hand
            if shortcut.get("AppName") == "Voices of the Void" and shortcut.get("Exe") == str(exe_path):
                existing_shortcut = True
                break
        if existing_shortcut:
            response = input("A shortcut for Voices of the Void already exists. Do you want to add another one? (y/n): ").strip().lower()
            if response != 'y':
                print("Operation cancelled.")
                return

        # List the already existing keys in shortcuts.vdf, if they exist then we take the last one and +1 it
        keys = [int(k) for k in data["shortcuts"].keys() if k.isdigit()]
        next_key = str(max(keys) + 1) if keys else "0"

        # This is the json that is gonna be imported in shortcuts.vdf, don"t touch unless you know what you're doing (or you're not afraid of consequences)
        data["shortcuts"][next_key] = {
            "appid": APPID,
            "AppName": "Voices of the Void",
            "Exe": str(exe_path),
            "StartDir": str(game_dir),
            "icon": str(grid_path/f"{CALCULATED_APP_ID}_icon.png"),
            "ShortcutPath": "",
            "LaunchOptions": "WINE_DO_NOT_CREATE_DXGI_DEVICE_MANAGER=1 %command%",
            "IsHidden": 0,
            "AllowDesktopConfig": 1,
            "AllowOverlay": 1,
            "OpenVR": 0,
            "Devkit": 0,
            "DevkitGameID": "",
            "DevkitOverrideAppID": 0,
            "LastPlayTime": 0,
            "FlatpakAppID": "",
            "sortas": "",
            "tags": {}
        }

        # Save the final edit and overwrite shortcuts.vdf (I probably should make it create a backup just in case)
        with open(shortcuts_path, "wb") as f:
            f.write(vdf.binary_dumps(data))
        print("Saved shortcuts.vdf")

        #
        # CUSTOMIZATION SECTION
        #
        print("\n\n---------- Customization section ----------")
        addCustomizations(grid_path)

        #
        # CONFIG.vdf EDITING
        #
        print("\n\n---------- config.vdf section ----------")


        # (Slep) Now that we have the game added to steam and it's shortcuts, let's tell steam it should use proton
        # First let's get the path to the config...
        config_path = steam_path/"config/config.vdf"

        # Let's make sure the file exists here, if not quit because else something is *VERY* wrong
        if config_path.exists():
            with open(config_path, "r", encoding="utf-8") as f:
                config_data = vdf.load(f)
            print("config.vdf exists, adding onto it...")
        else:
            print("\n\n----------------------------------------------------------------------------\n\nWarning: \nSomething has gone wrong and the script failed to find steam's config file'\nEverything else seems to have gone correctly however, you should be able to restart steam and find the shortcut in the \"Uncategorised\" section of your library\n However you will need to go in the properties of the shortcut and set the compatibility yourself.\nA compatibility layer is REQUIRED to launch Voices of the Void on linux.\n\n----------------------------------------------------------------------------")
            exit(1)

        # Incase this fucks anything up, let's back up the config
        backup_config_path = config_path.parent/"backup_config.vdf"
        try:
            with open(backup_config_path, "w", encoding="utf-8") as f:
                vdf.dump(config_data, f, pretty=True)
            print("Created backup_config.vdf in: " + str(config_path.parent))
        except Exception as e:
            print(f"Failed to create backup_config.vdf\n{e}")

        # This is where we will be editing in the confid.vdf
        compat_map = (
            config_data["InstallConfigStore"]
                ["Software"]
                ["Valve"]
                ["Steam"]
                ["CompatToolMapping"]
        )

        # Let's add in the bit of data that tell's steam to use proton for the shortcut
        if CALCULATED_APP_ID not in compat_map:
            compat_map[CALCULATED_APP_ID] = {
                "name": "proton_10",
                "config": "",
                "priority": "250"
            }
            print("Told steam to use proton 10 for shortcut")
        else:
            print("Steam already has a entry for this shortcut, something may already be using the shortcut id!")

        with open(config_path, "w", encoding="utf-8") as f:
            vdf.dump(config_data, f, pretty=True)
        print("Saved config.vdf")

        print("\n--------------------------------------------------------------------------------------------------\n\nEverything seems to have gone correctly! You'll find the shortcut in \"Uncategorised\" in your steam library.\n\n--------------------------------------------------------------------------------------------------zn")

# Where the script starts
if __name__ == "__main__":
    # If no arguments are passed we prompt the user to put the folder path for VotV.exe (the fact no arguments = 1 angers me)
    if len(sys.argv) == 1:
        folder_path = input("Enter the folder path containing VotV.exe: ")
        exe_path = Path(folder_path)/"VotV.exe"
        if not exe_path.exists():
            print("VotV.exe not found in the specified folder.")
            exit(2)
        sys.argv.extend(['-e', str(exe_path)])

    # Runs the main script lol
    main()