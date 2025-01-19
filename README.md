# dotfiles
Configuration files for unix systems

## Contents

Contains configuration files for applications used in unix environments:
Arch/Debian linux, MacOS, WSL, Git Bash on Windows

Also includes an `./install.sh` script which can safely install (check for existing installations and warn for overwrites) dotfiles and package dependencies.

## Installation
To setup dotfiles on a new machine:  
```
git clone git@github.com:charlestytler/dotfiles.git $HOME/dotfiles
cd $HOME/dotfiles && ./install.sh
```  

*To install only a subset of config files:*
Provide --include or --exclude flags when calling install script, see `install.sh --help` for details.

### Config file for Installer

The installation is updated by editing the installConfig.cfg file.

*Use the following formatting:*
- Sections
  - `[<name>]`: Section - A named installation step that can optionally be skipped by user.
  - `[:<OS>]`: Subsection - A subsection that specifies the OS for the installation step.
    -   where `<OS>` is one of: `LINUX`, `MAC`, `WIN`

- Keys and Values
  - `pkgs = <package1> <package2> ...` - List of packages to install.
  - `include = "<string>" <file>` - Include the string (i.e. echo >>) in the specified file.
  - `symlink = <source> <destination>` - Symlink the source file to the destination.
- cmd = <command> - Bash command to run.
