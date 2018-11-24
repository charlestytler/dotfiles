# dotfiles
Configuration files for unix systems

To clone dotfiles:
`git clone git@github.com:charlestytler/dotfiles.git ~/dotfiles`  

To create symlinks to files within dotfiles folder:  
```
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
```  

To source bashrc while retaining computer-specific settings:  
`echo "source ~/dotfiles/bashrc" >> ~/.bashrc`  

To include file in .gitconfig add the following:
```
[include]
    path = ~/dotfiles/gitconfig
```

Dependency installations needed for all functions:  
https://github.com/sharkdp/fd  
https://github.com/junegunn/fzf#installation  
https://github.com/BurntSushi/ripgrep  
https://github.com/Valloric/YouCompleteMe  
