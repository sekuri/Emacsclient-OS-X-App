# Create a mac os x application (.app) to launch graphical emacsclient
### 2015-06-05
by: Sekuri

## Introduction
This is a guide to build a Mac OS X application to run emacs as a daemon and emacsclient in graphical mode instead of in the terminal.

There are 3 files: document.wflow.applescript, myemacs_bash and edit.
- document.wflow.applescript: This is the applescript that should be pasted in the Automator applescript action window to replace "(* Your script goes here *)". The application can be called MyEmacs.app
- my_emacs_bash: This is a bash script that sets necessary variables. It can be sourced from, or simply pasted into, .bashrc/.bash_profile.
- edit: This is a bash script that calls the graphical emacsclient.

## Installation
This has been tested on Yosemite and (Cocoa) Emacs.app v24.5.1
### document.wflow.applescript
- Create an app with Automator called, e.g. MyEmacs.app, that will launch a graphical emacsclient
- Select Applescript action
- Paste this applescript in the Automator applescript action window to replace "(* Your script goes here *)".
- It looks for the application iTerm2 to execute the "myemacs" alias. If it doesn't find it, it defaults to the Terminal application.

### edit

"edit" is a bash script that will be called by the alias "myemacs" command in the app created in Automator. Save it in, e.g., in $HOME/Documents/github/4668e6779c1aaf1feb64/edit

This script can also be launched from the command line, accepts filename(s) as input and runs in the background. It will launch an Emacs daemon if one is not running already (by the alternate-editor="" option). The $PATH is modified only in this shell to launch the GUI-supporting Cocoa version of the Emacs daemon. If no filename input is provided an Emacs client GUI will launch (-c option) with the scratch buffer active. If multiple filenames are provided, all files are loaded into buffer and each can be made visible by selection with C-x b. If an emacsclient is already launched, new files will be loaded as buffers in the existing client GUI. Change the path to Emacs.app with the correct one.

### myemacs_bash

"myemacs_bash" is a bash script that can be sourced from, or simply pasted into, .bashrc or .bash_profile.It defines "myemacs" as an alias for convenience to launch from command line, e.g. myemacs filename(s), and by the app created in Automator. Change the path to the "edit" script with the correct one. 

