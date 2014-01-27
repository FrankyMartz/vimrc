#General Vim Configuration

Designed with Simplicity & Functionality in mind.
 

Please, be aware that these files are always in a constant flux.


##Requirements

Don't worry most of these are pretty basic. I hate bloat and cruft too!
Please, do yourself a favor and install current versions; unless instructed otherwise.


**[Homebrew\*][brew]**
Although, *NOT* actually a requirement, save yourself the headaches of manual package installation. [Homebrew][brew] is clean and takes the nightmare out of installing, updating or uninstalling packages. Strongly Recommended!


**[MacVim][macvim]**
Install the latest version of MacVim with python2 support. Yes, MacVim. And yes, the latest.

Manual install:
If you don't use the MacVim GUI, you need to use the Vim binary inside the **MacVim.app** package (`MacVim.app/Contents/MacOS/Vim`). Copy the mvim script from the MacVim download to your local binary folder (ex. `/usr/local/bin/mvim`) and then symlink it:

```Bash
ln -s /usr/local/bin/mvim vim
```

If you're like me and you don't like hanging out in `/usr/*` just add a few alias into your `~/.bash_profile`

```Bash
echo "alias vim='mvim -v'" >> ~/.bash_profile
echo "alias vi='mvim -v'" >> ~/.bash_profile
```

Feel free to look at the rest of my [bash_profile][bash_profile]


**[Python][python]**
The OSX default python should suffice. Although, if you want to upgrade this configuration will utilize the +2.7 variant. 


**[CMake][cmake]**
 Preferably with [Homebrew][brew], but here's the [stand-alone CMake installer][cmake].


**[Node][node]**
Make sure you install with [npm].


**[Exuberant Ctags][ctags]**
 Preferably with [Homebrew][brew], this is a pain to install manually.


**[Powerline Font][fonts]**
The [Powerline][powerline] bundle requires a pre-patched font for special characters. I personally prefer a Meslo Large Regular at 11 pts because it's designed to look similar to menlo (I :heart: consistency). 

To change the default font under the **Color and Font** section in the `~/.vim/.vimrc` file.

```VimScript
set guifont=<font>:h<size>
```


##Installation

#####NOTE: If you have existing files in `$HOME/.vim` or `$HOME/.vimrc`, make sure you make appropriate backups before performing any of the following steps.

1. Quit Vim. *(Some bundles require clean starts)*

1. clone this respository into your `$HOME/.vim` directory.

    `$ git clone git://github.com/frankymartz/vimrc.git ~/.vim && cd ~/.vim`

2. Next, run the following `python` script:

    `$ ./setup.py`
    

That is it!

Well not exactly. Additional instructions will print to your terminal.


##Q&A
###I want to Contribute?
Sorry, but I use this configuration daily. I will *NOT* be accepting pull requests.


### Why not automate the entire process?
Some configuration files are not exclusive to Vim and are tightly bound to other program installations. I would rather not make any assumptions and allow you to configure these files as you deem suitable.


##Credits
Special thanks, to those fantastic people I've been shamelessly stealing from!

@scrogson @sjl @nvie

Please contact me if I'm forgetting someone.


[brew]: http://brew.sh
[macvim]: https://code.google.com/p/macvim/
[python]: http://code.google.com/p/macvim/#Download
[cmake]: http://www.cmake.org/cmake/resources/software.html
[node]: http://nodejs.org
[npm]: https://npmjs.org
[ctags]: http://ctags.sourceforge.net
[fonts]: https://github.com/Lokaltog/powerline-fonts
[powerline]: https://github.com/Lokaltog/powerline
[bash_profile]: https://gist.github.com/FrankyMartz/6207278

