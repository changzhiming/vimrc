# vimrc
设置git 

```
git config --global http.postBuffer 524288000
git config --list

git config --global core.compression -1 
```

```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

```
vim
然后安装插件
PluginInstall

" Brief help
" :PluginList - lists configured plugins
" :PluginInstall - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean - confirms removal of unused plugins; append `!` to auto-approve removal
```

#youcompleteme

```
sudo apt-get install build-essential cmake python-dev  python3-dev clang
git submodule update --init --recursive
git clone --recursive https://github.com/ycm-core/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
python3 ./install.py --system-libclang --clang-completer

cp third_party/ycmd/examples/.ycm_extra_conf.py ~/.vim/

```
