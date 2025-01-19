# FINALLY - CODE UPGRADE

A rework on the code has gone through. It's been upgraded to PowerShell 5.1 ( Which is installed by default on Win 10 ) - Proved ( Lower versions needs to be tested ).
It also includes the new way on how steam handles account signatures.

Note: Batch file SHOULD work fine, will test if it doesn't fail while testing if CMD has elevated rights.

If in need, you can always install the latest version of "[PowerShell](https://learn.microsoft.com/es-es/powershell/scripting/install/installing-powershell-on-windows)". Current latest PowerShell version: 7.4.6.

Note 2: PowerShell 5.1 requieres to launch the `Start.bat` which is beside it.

# CleanUp-Steam-Fixer ( Windows Only )

Delete old unused Steam Files, fix steam Service, implement various fixes for VAC Authentication Error in CSGO, check Windows for inconsistencies ( And fix them ) and Updates.

## Will it FULLY FIX my problem?

While it is not 100% guarantee it will fix your problem, it is definitely one of the easiest ways to check multiple problems at once. But most of the cases are contained here, so I am confident it will be fixed.

# What's the use?

Steam becomes corrupted and bulky with the passing of time ( Either by Updates, wrong system shutdowns, system errors, friends -or ourself- changing profile picture too much and so on ).
Sometimes we get [&#34;VAC AUTHENTICATION ERROR&#34;](https://support.steampowered.com/kb_article.php?ref=2117-ILZV-2837) on CSGO - Don't know about other games.
In order to make it easier for users I collected all the possible fixes from Steam Support page ( Of course it won't be uninstalling any programs as the Page suggest ) and added a few of my own.

## Explained

It consist in two parts. Part 1 with 7 steps, and Part 2 with 3.

### Part 1

Defining Steam Folder - I manage to make it automatically, but some test on different PCs went totally wrong deletting every file on the "DOWNLOADS" folder, so I made the user define the path in order to make it safe ( Including a check for "Steam.exe", just in case )

**Step 1** : Closes Steam.

**Step 2** : Clean Steam folder ( Deletes everything except "config", "steamapps", "userdata", "steam.exe", "uninstaller.exe" and "steam.signatures" files ( Old version used to work with "ssfn" files ).

**Step 3** : [Reset boot settings to default](https://support.steampowered.com/kb_article.php?ref=2117-ILZV-2837#default) - Won't work if SecureBoot is enabled ( Will make it Skip this in case SecureBoot is On ).

**Step 4-6** : [Scan Windows for corruption and fix it](https://support.steampowered.com/kb_article.php?ref=2117-ILZV-2837#files) - SFC needs this 2 previous steps to work properly ( Steps 4-5 ), finally is executed in step 6.

After that, it restart the PC on command so fixes take place.

### Part 2

**Step 1** : Flushing DNS

**Step 2** : Repairing Steam Service - It will open Steam for you, you **MUST** let it fully open first in order for it to work. Once it opens and let it start, press any key for the program to continue.

**Step 3** : Updates Windows - Sometimes Windows Updates can fix some steam problems ( And yes, updates are necessaries for better - or for worst ). - Note : Won't wait till it finish.

# Ok, but HOW DO I USE IT?

Step 1 : Download the [PowerShell zip](../../releases/latest/download/Steam-Cleaner-Checker-Fixer-UserDefined.bat) or the .bat file you want [Manual](../../releases/latest/download/Steam-Cleaner-Checker-Fixer-UserDefined.bat) or [Automatic](../../releases/latest/download/Steam-Cleaner-Checker-Fixer.bat).

Step 2 : Right click the downloaded file and click on Properties, then click "Unlock" on the bottom right corner and accept.

Step 3 : Now run it as Administrator ( Right click the file ).

For Batch : Step 4 : Select language.

For PowerShell when it doesn't find the installation folder or Batch Manual :Step 5 : Insert Steam Installation folder. Default in 32 bits OS "**%PROGRAMFILES%\Steam**", Default in 64 bits OS "**%PROGRAMFILES(X86)%\Steam**" .

Step 6 : Press "N" and wait to restart once ( Press any key at the end ).

Step 7 : Do steps 2-4 again.

Step 8 : Press "S" and wait for Steam to open. Let it **FULLY** open ( It will need to redownload its files ) and then press any key.

Step 9 : Hope for the best.

# How do I know it is safe?

PowerShell Scripts and Batch files are nothing more than a bunch of default windows commands put all together. You can read my file by doing right click on it and selecting "Edit", you can even change it yourself. If you do change it and send it to others, remember to commend me on your program.
