#!/bin/bash
# NOTE: This script is intended for installation on macOS. I cannot guarantee it will work on other OS's.

# We want to install rsyntaxtree, but first we need to 
# install and configure the ruby programming language and 
# the gem package manager. We'll install brew first to
# make getting the dependencies super easy.

# if rsyntaxtree is already installed, don't attempt installation
if [ "$(command -v rsyntaxtree)" = "" ]; then
    cd # make sure we are in the home directory

    command -v brew >/dev/null 2>&1 || { echo >&2 "Attempting to install brew..."; curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh; }

    # make sure the above installation succeeded
    if [ "$(command -v brew)" = "" ]; then
        echo "brew installation failed... aborting"
        exit 1;
    fi

    # install dependencies if they aren't installed
    brew list ruby || brew install ruby
    brew list rbenv || brew install rbenv
    brew list imagemagick || brew install imagemagick

    # test that everything actually got installed, lol
    brew list ruby || exit 1
    brew list rbenv || exit 1
    brew list imagemagick || exit 1

    # now all the dependencies have been installed

    # if user doesn't have gem set up, then set it up for their specific shell
    if [ -z "$GEM_HOME" ]; then
        usrShell="$(basename $SHELL)"

        if [ "$usrShell" = "zsh" ]; then
            echo "export GEM_HOME=\"$HOME/.gem\"" >> .zshrc
            echo "export PATH=\"/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH\"" >> ~/.zshrc
            source ~/.zshrc
        elif [ "$usrShell" = "bash" ]; then
            echo "export GEM_HOME=\"$HOME/.gem\"" >> .bashrc
            echo "export PATH=\"/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH\"" >> ~/.bashrc
            source ~/.bashrc
        elif [ "$usrShell" = "fish" ]; then
            echo "set -x GEM_HOME \"$HOME/.gem\"" >> .config/fish/config.fish
            echo "set -x PATH \"/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH\"" >> ~/.config/fish/config.fish
            source ~/.config/fish/config.fish
        else
            echo "\"$SHELL\" not recognised... modify your shell's startup script to add ruby to your \$PATH and set \$GEM_HOME."
        fi;
    fi;

    # finally we can install rsyntaxtree (hopefully) without issue
    gem install rsyntaxtree
fi

# make sure the above installation succeeded
if [ "$(command -v rsyntaxtree)" = "" ]; then
    echo "rsyntaxtree installation failed... aborting"̦
    exit 1;
fi

# now rsyntaxtree is installed and we're good to go. Now let's set up vscode.

# first, install Code Runner
code --install-extension formulahendry.code-runner

# now we need to customise our settings in settings.json
# we'll use `fx` to manipulate the json
brew list fx || brew install fx # install fx if it isn't installed
brew list fx || exit 1          # test that it actually got installed

# I can't get fx to accept paths with spaces in them, so we'll just cd there first
cd "$HOME/Library/Application Support/Code/User/"

SETTINGS_FILE="settings.json"

if [ ! -f "$SETTINGS_FILE" ]; then
    touch $SETTINGS_FILE
fi

# followed guide at https://medium.com/@antonmedv/discover-how-to-use-fx-effectively-668845d2a4ea
fx $SETTINGS_FILE '{...this, "code-runner.executorMapByFileExtension": { ".stree": "bash -c \"rsyntaxtree \\\"\\$(<$fileName)\\\"\" && mv syntree.png $fileNameWithoutExt.png" }}' save
fx $SETTINGS_FILE '{...this, "files.associations": { "*.stree": "txt" }}' save
fx $SETTINGS_FILE '{...this, "editor.guides.bracketPairsHorizontal": true}' save
fx $SETTINGS_FILE '{...this, "editor.bracketPairColorization.enabled": true}' save
fx $SETTINGS_FILE '{...this, "editor.guides.bracketPairs": "active"}' save
fx $SETTINGS_FILE '{...this, "[plaintext]": { "editor.language.colorizedBracketPairs": [["[", "]"]], "editor.guides.bracketPairsHorizontal": true, "editor.bracketPairColorization.enabled": true, "editor.guides.bracketPairs": "active" }}' save
