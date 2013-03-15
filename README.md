# VIM Setup
Hi, here is my personal .vim setup. Feel free to clone. :)

## Installation
**NOTE**: If you have existing files in `$HOME/.vim` or `$HOME/.vimrc`, make sure you take appropriate backups before performing any of the following steps.

 - First clone this respository into your `$HOME` directory.

```sh
$ git clone git://github.com/frankymartz/vimrc.git ~/.vim && cd ~/.vim
```

 - Next, run the following `rake` tasks:
    - `rake vim:setup` Symlinks .vimrc to `$HOME/.vimrc` and creates tmp directory for VIM .swp files
    - `rake vundle:install` Install [Vundle](https://github.com/gmarik/vundle)
    - `rake` Installs vim plugins specified in the .vimrc file and snipmate-snippets.

That is it!

**NOTE**: If you have Vim running don't forget to source the install `:source $MYVIMRC` from inside vim or just restart.


Magic stuff originally came from [scrogson](https://github.com/scrogson).