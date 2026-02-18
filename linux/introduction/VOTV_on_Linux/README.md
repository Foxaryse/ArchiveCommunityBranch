# Basics:
## Installing and running via Lutris
### Video: 
- Watch video: [**Youtube**](https://youtu.be/2kMQBnCn6eQ)
- Download: [**Google Drive**](https://drive.google.com/file/d/11npOZPIhTXN4jOrNDKQOC_vKgtWjIHuG/view?usp=sharing) 

### Step by step:
- Open Lutris and press on the + button on the top left

![](ressources/images/installing/lutris/1.png)

Click on “Search the Lutris website for installers”

![](ressources/images/installing/lutris/2.png)

Search “Voices of the Void”

![](ressources/images/installing/lutris/3.png)

Select either “Stable” or “Test” (if available)
Latest Stable Build is, as the name suggests the latest stable version
Latest Test Build are public test build, they have the latest features but are to be used at your own discretion as bug or issues may occur

![](ressources/images/installing/lutris/4.png)

Choose where you want the game to be installed

![](ressources/images/installing/lutris/5.png)

On this screen it is recommended to use the “Download” source, so you download the latest version

![](ressources/images/installing/lutris/6.png)

After that, just wait for the game to download, extract and install.

![](ressources/images/installing/lutris/7.png)

![](ressources/images/installing/lutris/8.png)

![](ressources/images/installing/lutris/9.png)

## Installing via YeetPatcher
Yeetpatcher is the official launcher for updating or installing VOTV downloadable here
The linux flavor will give you a shell (.sh) script which you need to use the terminal to run.
Open a new terminal from the folder where the YeetPatchscript is located and run the following:
```
./YeetPatch.sh
```
After doing that this screen should show up

![](ressources/images/installing/yeetpatch/1.png)

Before running this script it is important to configure it (such as setting the install directory and cache directory).

![](ressources/images/installing/yeetpatch/2.png)

After those are set you can run the script with the “install” argument.
It will show you a list of versions to choose from, versions marked as [UNSTABLE] are public test builds.

![](ressources/images/installing/yeetpatch/3.png)

After selecting a version a recap will be shown to you
Make sure everything is correct then enter “y” to proceed with the installation.

![](ressources/images/installing/yeetpatch/4.png)

After that follow either the Using Steam & Proton (recommended) or Using Wine to learn how to launch the game on Linux.

![](ressources/images/installing/yeetpatch/5.png)

## Running Voices of The Void on a Linux system.
There are 3 main methods of running VotV on linux, Either use Wine and run the game with the -vulkan argument, using the Lutris launcher to both install and run VotV, or what’s generally considered the best method, Steam’s compatibility layer called “Proton”. However since Voices of The Void is not on steam currently, you’ll have to add it to your library manually.

Why Proton you may ask ? Well it seems Proton has better support for Dx11 & Dx12 support, which is the default API that is used by VotV when you boot up the game.
### Using Steam & Proton
Make sure you’ve already downloaded and extracted a copy of Voices of the Void using 7zip, or used the dedicated installer YeetPatcher.

Now open Steam and click “Games” on the top left of the Steam App and hit “Add a Non-Steam Game to My Library…”

![](ressources/images/running/steam/proton/1.png)

This will open up a separate window, you’ll need to hit “Browse…” in the bottom left.

![](ressources/images/running/steam/proton/2.png)

This will open a file browser, you’ll now need to navigate to “?/a09d_0004/WindowsNoEditor/VotV.exe” with ‘?’ being where you’ve installed it. For me that would be “/home/slepdepriv/Programs/a09d_0004/WindowsNoEditor/VotV.exe”

![](ressources/images/running/steam/proton/3.png)

Once found click on it then hit “Open” (or “Select” or so forth, as it may differ based on the Distro you use). This will close the file browser and add “VotV.exe” to the bottom of the list shown in the “Add Non-Steam Game” window. Make sure it’s checkmarked shown in the image below, then hit “Add Selected Programs”

![](ressources/images/running/steam/proton/4.png)

This will add “Votv.exe” to your Steam Library like it was any other game.

![](ressources/images/running/steam/proton/5.png)

Now you’ll need to tell Steam to launch Votv.exe with Proton. Right click on Votv.exe in the list and go to “Properties…”

![](ressources/images/running/steam/proton/6.png)

Then click "Compatibility" in the opened window.

![](ressources/images/running/steam/proton/7.png)

Then click “Force the use of the specific Steam Play compatibility tool” and select the newest Proton version from the dropdown list below, at the time of writing that would be “Proton 10.0-4”

![](ressources/images/running/steam/proton/8.png)

And that’s the bare minimum required, there’s more you can do to fix additional issues as documented in the Issues part of this page along with some additional optimization, but this is enough to just make the game run.

And as a tip, you can rename “Votv.exe” in the “Shortcut” area of the properties menu, and add a custom icon from your computer by clicking the blank square next to the name, though you’ll need to restart steam for the icon to take effect. You can also add custom images in the “Customization” area to display in various places in steam when viewing the game.

### Using Wine
Perhaps the most direct way of playing VotV on Linux but lacks the robustness something like Steam & Proton or even Lutris can provide, however it’s a completely viable option.

Assuming you already have wine installed on your device, if you don’t I’d recommend looking up specific instructions for your Distro. With wine installed, open your terminal and cd into the WindowsNoEditor folder in your votv’s install location, for me that would be “cd /home/slepdepriv/Programs/a09d_0004/WindowsNoEditor/”. Then simply run “wine Votv.exe -vulkan, Votv should shortly launch and you’ll be ready to play.”

![](ressources/images/running/wine/1.png)

It’s worth noting that you can run Votv without the -vulkan option, at the cost of reduced performance.

## Using Custom Assets
Voices of The Void features the ability to add custom assets (Custom Paintings, Posters, Radio Songs, TV Videos, etc) to be used in-game by placing them in a dedicated “Assets” folder. By default Votv expects this folder to be in a windows installation’s appdata/local/votv location, which Linux doesn’t have.

There’s a couple solutions to this: The compatibility layer used to launch Votv (either Wine or Proton) will actually make a fake windows file system including a appdata/local/votv location that the Assets folder will be made in, though finding it can be tricky. You can also tell Votv to use an alternative location on your file system for Assets, however this can cause some issues.

### Method 1: Finding the Assets folder
Using wine it’s by far the easiest find as it’s simply located at: “/home/<YOURNAME>/.wine/drive_c/users/<YOURNAME>/AppData/Local/VotV/Assets”

However using Proton it’s a tad more complicated, first make sure you’ve launched Votv at least once from steam, then you’ll need to find your Steam folder location. For most it should be at: “/home/<YOURNAME>/.steam/steam/” though if you can’t find it there also look for “/home/.local/share/steam”

Then from steam you’ll need to navigate to “/Steam/steamapps/compatdata/” which should be filled with folders with seemingly random numbers for names, now comes the annoying part, you’ll need to figure out which of these numbered folders steam assigned to Votv by mostly guess work. I’d recommend setting your file explorer to sort by last modified or last created, then assuming you’ve added Votv recently it should appear as the first folder in the list.

Assuming you’ve gotten the right one, you’ll find the asset folder at “Steam/steamapps/compatdata/<SOME NUMBERS>/pfx/drive_c/users/steamuser/AppData/Local/VotV/Assets” if you can’t find it there, then you’ve picked the number folder and need to try again.

I’d recommend adding the asset folder to your file browser’s places/bookmarks/favorites/etc to avoid having to hunt it down again.

### Method 2: Setting a custom Assets folder location
First you’ll need to make a folder somewhere on your computer to act as the Assets folder, for me I’ll use “/home/slepdepriv/VotvAssets” though it can be put anywhere and named anything you want.

Then you’ll need to open Voices of The Void and go to Settings then Extras, there you’ll find this batch of options shown below.

![](ressources/images/customassets/customlocation/1.png)

Unfortunately you can’t just paste the folder location into the bar without some issues due to how Unreal and Wine/Proton handle the file system, instead you need to find the “window-ized” version of the folder path that Wine/Proton tricks Votv into believing exists.

Luckily this is fairly easy, first click the “Open “Assets” folder” button which should open up a fairly dated looking file browser with the default assets folder open.

![](ressources/images/customassets/customlocation/2.png)

This however isn’t a normal file browser but instead a Wine/Proton specific browser that displays what Votv thinks the file system looks like, which is exactly what we need. Click on “My Computer” and search through the single letter folders until you find the linux file system, for me it’s Z.

![](ressources/images/customassets/customlocation/3.png)

From there find the folder you created earlier to be the Assets Folder, for me that’s “/home/slepdepriv/VotvAssets” then in the location bar the top click in the empty space and copy the path.

![](ressources/images/customassets/customlocation/4.png)

With it copied you can close the file browser and then paste the path into the “Asset folder location” text box

![](ressources/images/customassets/customlocation/5.png)

Then just click “Apply” in the bottom right of settings, if it works you should see Votv generate a bunch of folders in your designated Asset folder.

For more information on how to use the custom asset folder please see the Hints and tips menu in-game and search for “custom” or the community wiki guide on the subject https://voicesofthevoid.wiki.gg/wiki/Guides/Custom_Content

## Custom Resolutions
Using Gamescope you can make Voices of The Void use any custom resolution you desire, this is required if you’re playing on a Steam Deck since it requires a resolution of 1280x800 which Votv doesn’t support by default. You can install Gamescope from these repos https://repology.org/project/gamescope/versions or if you’re on Steam Deck it’s pre-installed.

Gamescope can also be used for more things like additional setting for running Voices of the Void in a window or as a boardless window, visit https://github.com/ValveSoftware/gamescope for more info.

### Using Gamescope with Steam
If you’re playing Voices of The Void through Steam you can simply add “gamescope -W 1280 -H 800 -- %command%” to the game’s laugh options, replace the 1280 and 800 with the Width and Height desired.

### Using Gamescope with Lutris
With Voices of The Void selected on Lutris you can click the little arrow next to play and hit Configure

![](ressources/images/customresolution/gamescope/lutris1.png)

Then in the opened window go to “System options”

![](ressources/images/customresolution/gamescope/lutris2.png)

Then hit the little slider to enable it.

![](ressources/images/customresolution/gamescope/lutris3.png)

Enter the resolution desired like so.

![](ressources/images/customresolution/gamescope/lutris4.png)

### Using Gamescope with Wine
Instead of directly using wine in a terminal you can launch it through gamescope by doing “gamescope  -W 1280 -H 800  -- wine path/to/Votv.exe”, replace the 1280 and 800 with the Width and Height desired.



# Issues:
## TV not working
One of the most common issues when playing Voices of The Void on a Linux system is the TV not working, the exact way this issue appears can vary heavily based on factors like Distro.

The most common appearance of this issue is when you select the video to play from the TV menu, it simply stays black with no signs of life:

![](ressources/images/issue_tvnotworking.png)

Though for some it will show “none”, “error”, or “loading” when selecting a video in the TV Menu.

### Solution 1: Use Proton 10
The best way to get the TV working is by using the Steam/Proton method of running Voices of The Void, as Proton is the more developed compatibility layer for gaming and thus has the most fixes available while using it.

Assuming you’re running Voices of The Void through steam, double check that you’re using Proton 10 by right-clicking Votv in your library, hitting properties, then going to "Compatibility" in the menu it opens up, if everything is correct you should see:

<!-- re-using this image cause its literally the same thing lol -->
![](ressources/images/running/steam/proton/8.png)

If it’s not set to Proton 10, please set it to Proton 10. With any luck this alone will be enough to make TVs work, however it’s highly likely you’ll need to combine it with Solution 2.
### Solution 1.5: Use Proton GE
Instead of using Proton 10 made by Valve themselves, there’s also a custom community version of Proton out there known as “Proton-GE” which often includes even more fixes and compatibility when it comes to running games. Which may or may not be better for running Voices of The Void compared to Proton 10.

To install Proton GE you can visit the official github: https://github.com/GloriousEggroll/proton-ge-custom or use an installer like ProtonPlus https://protonplus.vysp3r.com/ or ProtonUp-Qt https://davidotek.github.io/protonup-qt/ to quickly install it without much fuss, both should be available on Flathub.

After installing it and restarting steam, it should appear alongside the rest of the Proton options in the Compatibility section to be selected:

![](ressources/images/issues/tvnotworking/solution1/1.png)


### Solution 2: Custom Launch Option
Often times just using Proton 10 (or GE) isn’t enough, so another common fix paired with it is adding:
```
WINE_DO_NOT_CREATE_DXGI_DEVICE_MANAGER=1 %command%
```

To the launch options of your game. To do so right-click Votv in your library, hit properties, then in the Shortcut area paste in the Launch Option above into the “Launch Options” text box, once done it should look like this:

![](ressources/images/issues/tvnotworking/solution2/1.png)

This for most people should be enough to fix the TV, however in the rare cases where it is not you can try Solution 3.
### Solution 3: Lav Filters
This is the least tested of the solutions and its validity is questionable, it’s still listed here just in-case. The fix in question involves using a program called ProtonTricks to install a windows component called LavFilters for Votv to use.

First install ProtonTricks from Flathub https://flathub.org/en/apps/com.github.Matoking.protontricks or it’s official github https://github.com/Matoking/protontricks

Once installed, launch it from the start menu/app launcher. Once open you should see a menu something like this:

![](ressources/images/issues/tvnotworking/solution3/1.png)

It should show every game on steam you’re using Proton for, including the the Non-Steam shortcut added for Voices of The Void. Select it and press OK:

![](ressources/images/issues/tvnotworking/solution3/2.png)

Another menu should popup, in this one just make sure “Select the default wineprefix” is selected, then hit OK.

![](ressources/images/issues/tvnotworking/solution3/3.png)

Again, another menu. Select the top option “Install a Windows DLL or component” and hit OK again.

![](ressources/images/issues/tvnotworking/solution3/4.png)

This will open a giant list of various Windows components to download, scroll down until you find “lavfilters” and click on it, then ofcourse hit OK.

![](ressources/images/issues/tvnotworking/solution3/5.png)

This will open an installer, don’t worry about the file path just hit Next.

![](ressources/images/issues/tvnotworking/solution3/6.png)

Make sure all options are selected, then hit Next again.

![](ressources/images/issues/tvnotworking/solution3/7.png)

Next again.

![](ressources/images/issues/tvnotworking/solution3/8.png)

Again.

![](ressources/images/issues/tvnotworking/solution3/9.png)

Select every checkbox in this menu then hit Next again.

![](ressources/images/issues/tvnotworking/solution3/10.png)

And finally, hit Install.

![](ressources/images/issues/tvnotworking/solution3/11.png)

After waiting a bit for it to install, hit Finish.

![](ressources/images/issues/tvnotworking/solution3/12.png)

You can now close ProtonTricks and open Voices of The Void to check if the issue has been fixed, if not you may be out of luck/

## Streamed videos on the tv not working:

### Description:
This is an issue that is yet to have been resolved officially

### Fix:
A work around has been found via the use of a script to dynamically copy sections of the streamed media, convert them into a normal mp4 file with a specific duration  targeted via file:// and works by setting it to “sequence”.

## 3D printable objects not showing up while other custom assets do:

### Description:
This issue happens when trying to load 3D printable objects, the 3D prints won’t show up while other custom assets such as TV videos, Radio audio, custom poster, etc.. will.

### Fix:
User the “Open Assets Folder” button.

![](ressources/images/issues/3dprint/1.png)

This window should open:

![](ressources/images/issues/3dprint/2.png)

Click and copy the path:

![](ressources/images/issues/3dprint/3.png)

Paste the path the in “Asset folder location”  setting and press refresh:

![](ressources/images/issues/3dprint/4.png)

Your 3D prints should now show up

## Black screen when loading into save:

### Description:
When loading into any save your screen will go black, you can still press buttons and hear yourself move around but you’ll see nothing. Pausing will allow you to see but only while you’re paused

### Fix:
Turn off “Automatic screen res” in the Graphics>Display section of settings and restart the game

![](ressources/images/issues/blackscreen/1.png)


