# CleanUp-Steam-Fixer ( Windows Only )
Delete old unused Steam Files, fix steam Service, implement various fixes for VAC Authentication Error in CSGO, check Windows for inconsistencies ( And fix them ) and Updates.

# What's the use?
Steam becomes corrupted and bulky with the passing of time ( Either by Updates, wrong system shutdowns, system errors, friends -or ourself- changing profile picture too much and so on ). Sometimes we get ["VAC AUTHENTICATION ERROR"](https://support.steampowered.com/kb_article.php?ref=2117-ILZV-2837) on CSGO - Don't know about other games.
In order to make it easier for users I collected all the possible fixes from Steam Support page ( Of course it won't be uninstalling any programs as the Page suggest ) and added a few of my own.

## Explained
It consist in two parts. Part 1 with 7 steps, and Part 2 with 3.

### Part 1
Defining Steam Folder - I manage to make it automatically, but some test on different PCs went totally wrong deletting every file on the "DOWNLOADS" folder, so I made the user define the path in order to make it safe ( Including a check for "Steam.exe", just in case )
**Step 1** : Closes Steam.
**Step 2** : Clean Steam folder ( Deletes everything except "config", "steamapps", "userdata", "steam.exe", "uninstaller.exe" and two "ssfn*" files ( one of them is hidden ).
**Step 3** : [Reset boot settings to default](https://support.steampowered.com/kb_article.php?ref=2117-ILZV-2837#default).
**Step 4-7** : [Scan Windows for corruption and fix it](https://support.steampowered.com/kb_article.php?ref=2117-ILZV-2837#files) - SFC needs this 3 previous steps to work properly ( Steps 4-6 ), finally is executed in step 7.
After that, it restart the PC on command so fixes take place.

### Part 2
**Step 1** : Flushing DNS
**Step 2** : Repairing Steam Service - You **MUST** to open Steam first in order for it to work. Once you open it and let it start, press any key for the program to continue.
**Step 3** : Updates Windows - Sometimes Windows Updates can fix some steam problems ( And yes, updates are necessaries for better - or for worst ).

# Ok, but HOW DO I USE IT?
Step 1 : [Download the .bat file](../../releases/latest).
Step 2 : Run it as Administrator ( Anywhere you like )
Step 3 : Select language.
Step 4 : Insert Steam Installation folder. Default in 32 bits OS **%PROGRAMFILES%\Steam**, Default in 64 bits OS **%PROGRAMFILES(X86)%\Steam**.
Step 5 : Press "N" and wait to restart once ( Press any key at the end ).
Step 6 : Do steps 2-4 again.
Step 7 : Press "S" and wait for the console to tell you when to open Steam. Let it **FULLY** open ( It will need to redownload its files ) and then press any key.
Step 8 : Enjoy your gaming.
