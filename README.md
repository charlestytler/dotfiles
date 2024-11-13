# dotfiles
Configuration files for unix systems

### Dependency installations needed for all configs:  
VS Code: https://code.visualstudio.com/download  
  
Download and install fonts "Hack Nerd Font": https://www.nerdfonts.com/font-downloads  
  
```
brew install fish starship neovim fd ripgrep fzf
```  
```
sudo apt-get install fish starship neovim fd ripgrep fzf
```
```  
choco install fish starship neovim fd ripgrep fzf
```  


### Install Configs
To setup dotfiles on a new machine:  
```
git clone git@github.com:charlestytler/dotfiles.git ~/dotfiles
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -s ~/dotfiles/tmux ~/.config/tmux
echo "source ~/dotfiles/bash/bashrc" >> ~/.bashrc
fish -c exit && echo "source ~/dotfiles/fish/config.fish" >> ~/.config/fish/config.fish
echo -e "[include]\n    path = ~/dotfiles/git/gitconfig" >> ~/.gitconfig

if [[ "$(uname)" = "Darwin" ]]; then
    VSCODE_PATH=("$HOME/Library/Application\ Support/Code/User/")
elif [ "$(uname)" = "MINGW"* ]; then
    VSCODE_PATH=(%APPDATA%\Code\User\settings.json)
else
    VSCODE_PATH=($HOME/.config/Code/User/)
fi

ln -s ~/dotfiles/vscode/settings.json "$VSCODE_PATH"/
ln -s ~/dotfiles/vscode/keybindings.json "$VSCODE_PATH"/

```  


