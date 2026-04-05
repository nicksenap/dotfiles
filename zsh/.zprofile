

# Added by Toolbox App
export PATH="$PATH:/Users/nicksenap/Library/Application Support/JetBrains/Toolbox/scripts"


eval "$(/opt/homebrew/bin/brew shellenv)"

# Setting PATH for Python 3.11
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:${PATH}"
export PATH

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# >>> coursier install directory >>>
export PATH="$PATH:/Users/nicksenap/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<
