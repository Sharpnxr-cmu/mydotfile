# mydotfile

* ITerm2-profile.json needs to be imported into iTerm2
* coc-settings.json should be copied to ~/.vim/
* everything else can be directly copied to ~/ and will be effective
* Remember first install zsh and oh-my-zsh (https://xiaozhou.net/learn-the-command-line-iterm-and-zsh-2017-06-23.html)

### font

* [powerline](https://github.com/powerline/fonts)
* [DroidSansMono](https://github.com/ryanoasis/nerd-fonts)

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
* ack

### vim plugin
To install all plugins

1. `vim ~/.vimrc`
2. `:PlugInstall`
3. [coc](https://github.com/neoclide/coc.nvim) needs to install the needed language-support plugins
4. [vim-go](https://github.com/fatih/vim-go) needs to install the go binary
5.  `Ack` needs `brew install ack`

To install a new plugin:

1. `vim ~/.vimrc`
2. add `Plug` between `call plug#begin('~/.vim/plugged')` and `call plug#end()`
3. `:w`
4. `:source %`
5. `:PlugInstall`


### tmux plugin
There is no tmux plugin XD!

Note: If using tmux locally and remotely at the same time, `<C-a>` is the prefix of local, `<C-aa>` is the prefix of remote. So if it is needed to use tmux remotely, it may be more convenient to not use tmux locally