# Create a mac os x application (.app) to launch graphical emacsclient
### 2015-06-05
by: Sekuri

## Introduction
This is a guide to build a Mac OS X application to run emacs as a daemon and emacsclient in graphical mode instead of in the terminal.

There are 3 files: document.wflow.applescript, myemacs_bash and myemacs.
- document.wflow.applescript: This is the applescript that should be pasted in the Automator applescript action window to replace "(* Your script goes here *)". The application can be called MyEmacs.app
- myemacs: This is a bash script that calls the graphical emacsclient.
- my_emacs_bash: This is a bash script that can be sourced from, or simply pasted into, .bashrc or .bash_profile.

## Installation
This has been tested on Yosemite and (Cocoa) Emacs.app v24.5.1
### document.wflow.applescript
- Launch Automator to create an app.
- Select Applescript action.
- Paste this applescript in the Automator applescript action window to replace "(* Your script goes here *)".
- It looks for the application iTerm2 to run "myemacs" in. If it doesn't find iTerm2, it defaults to the Terminal application.
- Call this app, e.g. MyEmacs.app. It will launch a graphical emacsclient.

### myemacs

"myemacs" is a bash script that can be called from the command line. $PATH can be modified to point to it. It is also called from within the Automator app created. Save it in, e.g., in $HOME/Documents/github/4668e6779c1aaf1feb64/myemacs.

It accepts filename(s) as input and runs in the background. It will launch an Emacs daemon if one is not running already (by the alternate-editor="" option). The $PATH is modified only in this shell to launch the GUI-supporting Cocoa version of the Emacs daemon. If no filename input is provided an Emacs client GUI will launch (-c option) with the scratch buffer active. If multiple filenames are provided, all files are loaded into buffer and each can be made visible by selection with C-x b. If an emacsclient is already launched, new files will be loaded as buffers in the existing client GUI. Change the path to Emacs.app with the correct one.

### myemacs_bash

"myemacs_bash" is a bash script that can be sourced from, or simply pasted into, .bashrc or .bash_profile. Here, it defines "myemacs" as an alias for convenience to launch from command line, e.g. myemacs filename(s). This would not be necessary if your $PATH points to "myemacs" script. It also sets environment variables $EDITOR and $VISUAL to default to emacsclient (this is not necessary). Change the path to the "myemacs" script with the correct one. 