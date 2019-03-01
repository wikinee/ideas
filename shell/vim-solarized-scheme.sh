#!/usr/bash
# maybe you are using zsh,fix the first line.
# Program:
#   This program include:
#   - add auto change vim colorscheme to solarized.
#   - install Vundle.vim
# History:
# Dec.16, 2015  wikinee First release
echo "This script need wget, ssh, github-key, and unzip?"
echo "Sure you have those?Enter continue or quit: "
read base_env
if [ ! "$base_env" == "" ]; then
    echo "Please install them and run script again."
else
    vimrcPath="$HOME/.vimrc"
    vimColorPath="$HOME/.vim/colors"
    vimPluginPath="$HOME/.vim/bundle"
    echo "===============test exist and touch file==============="
    if [ ! -x "$vimrcPath" ]; then
      touch "$vimrcPath"
    fi

    mkdir -p "$vimColorPath"
    wget https://github.com/altercation/vim-colors-solarized/archive/master.zip && unzip master.zip && cp vim-colors-solarized-master/colors/solarized.vim $HOME/.vim/colors
    rm -rf vim-colors-solarized-master
    rm master.zip
    cd $HOME

    echo -e "\" ===============solarized settings=================" >> $vimrcPath
    echo "Chose you scheme? y:light(default),n:dark"
    read chose_scm
    if [ "$chose_scm" == "n" ]; then
        usr_chs_scm="dark"
    fi

    echo -e "syntax on\nset nu\nset t_Co=256\nlet g:solarized_termcolors=256\n\
    set background=${usr_chs_scm:=light}\ncolorscheme solarized" >> $vimrcPath
fi
echo "finish solarized, install Vundle?Enter yes or other quit"
read Install_vundle
if [ ! "$Install_vundle"=="" ]; then
    exit 0
else
    echo "==================install Vundle==================="
    mkdir -p "$vimPluginPath"
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    echo "\"==============Vundle Settings============="
    echo -e "\n\
    set nocompatible              \" be iMproved, required\n
    filetype off                  \" required\n
    \" set the runtime path to include Vundle and initialize\n
    set rtp+=~/.vim/bundle/Vundle.vim\n
    call vundle#begin()\n
    \" alternatively, pass a path where Vundle should install plugins\n
    \"call vundle#begin('~/some/path/here')\n

    \" let Vundle manage Vundle, required\n
    Plugin 'gmarik/Vundle.vim'\n

    \" The following are examples of different formats supported.\n
    \" Keep Plugin commands between vundle#begin/end.\n
    \" plugin on GitHub repo\n
    Plugin 'tpope/vim-fugitive'\n
    \" plugin from http://vim-scripts.org/vim/scripts.html\n
    Plugin 'L9'\n
    \" Git plugin not hosted on GitHub\n
    Plugin 'git://git.wincent.com/command-t.git'\n
    \" git repos on your local machine (i.e. when working on your own plugin)\n
    Plugin 'file:///home/gmarik/path/to/plugin'\n
    \" The sparkup vim script is in a subdirectory of this repo called vim.\n
    \" Pass the path to set the runtimepath properly.\n
    Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}\n
    \" Avoid a name conflict with L9\n
    Plugin 'user/L9', {'name': 'newL9'}\n
    \" All of your Plugins must be added before the following line\n
    call vundle#end()            \" required\n
    filetype plugin indent on    \" required\n
    \" To ignore plugin indent changes, instead use:\n
    \"filetype plugin on
    \"
    \" Brief help
    \" :PluginList          - list configured plugins
    \" :PluginInstall(!)    - install (update) plugins
    \" :PluginSearch(!) foo - search (or refresh cache first) for foo
    \" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
    \"
    \" see :h vundle for more details or wiki for FAQ
    \" Put your non-Plugin stuff after this line" >> $vimrcPath

    echo "===================Have Fun====================="
fi
exit 0