# mydotfile

All files (except iTerm2-profile.json, which needs to be imported into iTerm2) can be directly copied to ~/ and will be effective

### brew install
* wget
* autojump
* thefuck
* tig
* git
* python
* macvim
* bat
* shellcheck
* tldr
* tmux

### vim plugin
To install all plugins

1. `vim ~/.vimrc`
2. `:PlugInstall`

To install a new plugin:

1. `vim ~/.vimrc`
2. add `Plug` between `call plug#begin('~/.vim/plugged')` and `call plug#end()`
3. `:w`
4. `:source %`
5. `:PlugInstall`


### tmux plugin
There is no tmux plugin XD!
