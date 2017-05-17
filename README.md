# Create a mac os x application (.app) to launch graphical emacsclient
### 2015-06-05
by: Sekuri

## Introduction
This is a guide to build a Mac OS X application to run emacs as a daemon and emacsclient in graphical mode instead of in the terminal.

There are 4 files: document.wflow.applescript, myemacs_bash, myemacs and Emacs.icns.
- document.wflow.applescript: This is the applescript that should be pasted in the Automator applescript action window to replace "(* Your script goes here *)". The application can be called MyEmacs.app
- myemacs: This is a bash script that calls the graphical emacsclient.
- my_emacs_bash: This is a bash script that can be sourced from, or simply pasted into, .bashrc or .bash_profile.
- Emacs.icns: This is the icons file that you can use instead of the default from Apple's Automator in the Resources directory of the app.

## Installation
This has been tested on Yosemite and Emacs v25
### document.wflow.applescript
- Launch Automator to create an app.
- Select Applescript action.
- Paste this applescript in the Automator applescript action window to replace "(* Your script goes here *)".
- Call this app, e.g. MyEmacs.app. It will launch a graphical emacsclient.

### myemacs

"myemacs" is a bash script that can be called from the command line. $PATH can be modified to point to it. It is also called from within the Automator app created. Save it in, e.g., in $HOME/Documents/github/myemacsclient/myemacs.

This script can be launched from the command line. It accepts filenames as input and runs in the background. It will launch an Emacs daemon if one is not running already (by the alternate-editor="" option). If no filename input is provided an Emacs client GUI will launch (-c option) with the scratch buffer active. If multiple filenames are provided, all files are loaded into buffer and each can be made visible by selection with C-x b. 

Special consideration is given if the parent process user is root, e.g. when using sudoedit. In this case, a separate  emacsclient frame is launched and shell is not released until frame is killed.

### myemacs_bash

"myemacs_bash" is a bash script that can be sourced from, or simply pasted into, .bashrc or .bash_profile. Here, it defines "myemacs" as an alias for convenience to launch from command line, e.g. myemacs filename(s). This would not be necessary if your $PATH points to "myemacs" script. It also sets environment variables $EDITOR and $VISUAL to default to emacsclient (this is not necessary). Change the path to the "myemacs" script with the correct one. 

### Emacs.icns

Use to give the app the familiar Emacs set of icons to its appearance in Finder. Rename it to "AutomatorApplet.icns" and replace the default one in the Contents/Resources folder of the app. 
