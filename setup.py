#!/usr/bin/env python
"""Setup and build vim plugin bundles. A moderately fancy vim."""

import os, glob

## Hi! #########################################################################
__author__ = "FrankyMartz"
__version__ = "1.1.0"
__status__ = "Production"

## Globals #####################################################################
HOME_DIR = os.environ["HOME"]
CURRENT_DIR = os.path.dirname(os.path.realpath(__file__))
VIMRC = os.path.join(CURRENT_DIR, ".vimrc")
VUNDLERC = os.path.join(CURRENT_DIR, ".vundlerc")

REQUIRED = ["cmake", "python", "vim", "ctags", "node", "npm"]

## Common ######################################################################
def log(arg, verbose=True):
    """Print to console with an ON/OFF switch.
    :arg: string printed to console
    :verbose: should print actions to console
    """
    if bool(verbose):
        print(arg)


def chdir(destination_path):
    """Set working directory to destination path
    :destination_path: location to set working directory
    """
    if os.path.isdir(destination_path):
        os.chdir(destination_path)


def which(program):
    """Return location of executable
    :program: parameter searched in user system
    :returns: program path or None
    """
    def is_exe(fpath):
        """Determine if file is executable and user has permission
        :fpath: program to verify
        :returns: @todo
        """
        return os.path.isfile(fpath) and os.access(fpath, os.X_OK)

    fpath = os.path.dirname(program)
    if fpath:
        if is_exe(program):
            return program
    else:
        for path in os.environ["PATH"].split(os.pathsep):
            path = path.strip('"')
            exe_file = os.path.join(path, program)
            if is_exe(exe_file):
                return exe_file
    return None


def symlink(source_path, destination_path, verbose=True):
    """Create a symbolic link to sourcePath at destinationPath.
    :source_path: file referenced when open operation is performed on link.
    :destination_path: symbolic link referencing sourcePath.
    :verbose: should print actions to console
    :returns: Boolean describing function success.
    """
    if source_path == destination_path:
        log("==> Error: Paths are equivalent", verbose)
        return False
    if os.path.lexists(destination_path):
        filename = os.path.basename(destination_path)
        log("==> '%s' symlink already exists!" % filename, verbose)
        log("==> Removing '%s'..." % destination_path, verbose),
        os.remove(destination_path)
        log("[DONE]")
    if not os.path.isfile(source_path):
        log("==> Error: Source file does not exist.", verbose)
        return False

    basename = os.path.basename(source_path)
    log("==> Symlinking '%s'..." % basename, verbose),
    os.symlink(source_path, destination_path)
    log("[DONE]")
    return True


## Installation ################################################################
def vundle(verbose=True):
    """Install the vundle package into .vim
    :verbose: Boolean specifying verbosity of actions
    """
    log("==> Installing Vundle...", verbose)
    destination = os.path.join(HOME_DIR, ".vim/bundle/vundle")
    vundle_git_dir = "https://github.com/gmarik/vundle.git"
    os.system("git clone %s %s" % (vundle_git_dir, destination))
    log("[DONE]")


def bundles(verbose=True):
    """Install and clean Vundle Bundles
    :verbose: Boolean specifying verbosity of actions
    :returns: Boolean describing function success.
    """
    def clean():
        """Purge any unmanaged bundles from the bundle dir"""
        log("==> Cleaning unmanaged bundles...", verbose),
        os.system("vim +BundleClean +qall")
        log("[DONE]")


    def install():
        """Install all vim plugin bundles"""
        log("==> Installing all Vundle-managed plugins...", verbose),
        os.system("vim +BundleInstall +qall")
        log("[DONE]")

    def ycm():
        """Install YouCompleteMe engine"""
        log("==> Compiling YouCompleteMe component...")
        chdir(os.path.join(HOME_DIR, ".vim/bundle/YouCompleteMe"))
        os.system("./install.sh --clang-completer")
        log("[DONE]")

    def tern():
        """Install tern through node npm"""
        log("==> Installing Tern Server...")
        chdir(os.path.join(CURRENT_DIR, "bundle/tern_for_vim"))
        os.system("npm install")
        log("[DONE]")

    install()
    clean()
    ycm()
    tern()
    return True


def caveats():
    """Print post-install instructions."""
    log("==> Cavents")

    ##  Splice
    log("""
    [+ Splice +]
    Splice and Fugitive do not play well together. If you try to use Splice
    as a git mergetool while you have Fugitive installed it may segfault Vim,
    even if you're not using any Fugitive features.

    Add the following lines to ~/.gitconfig:

        [merge]
        tool = splice

        [mergetool \"splice\"]
        cmd = \"mvim -f $BASE $LOCAL $REMOTE $MERGED -c 'SpliceInit'\"
        trustExitCode = true

    Note: replace mvim with vim to keep editor in console.\n\n
    """)

    ## YCM
    log("""
    [+ YouCompleteMe +]
    YCM is a plugin with a compiled component. If you update YCM using Vundle
    and the ycm_support_libs library APIs have changed (happens rarely), YCM
    will notify you to recompile it. You should then run:

        cd ~/.vim/bundle/YouCompleteMe
        ./install.sh
    \n\n
    """)

    ## Tern
    log("""
    [+ Tern +]
    Tern uses '.tern-project' files to configure loading libraries and plugins
    for a project. See the Tern docs for details.

    http://ternjs.net/doc/manual.html#configuration
    \n\n
    """)


def cleanup(verbose=True):
    """Removes all the files in '~/.vim/view' directory
    :verbose: Boolean specifying verbosity of actions
    """
    view_dir = os.path.join(CURRENT_DIR, "view")
    if os.path.exists(view_dir):
        log("==> CleanUp '%s'..." % view_dir, verbose),
        view_dir = os.path.join(view_dir, "*")
        for i in glob.glob(view_dir):
            os.remove(i)
        log("[DONE]", verbose)


def setup(verbose=True):
    """Proper setup.py module install.
    :verbose: Boolean specifying verbosity of actions
    :returns: Boolean describing function success
    """
    # Verify dependencies are installed
    log("==> Verify Dependencies Resolved...", verbose),
    for exe in REQUIRED:
        if not which(exe):
            log("\n==> Hmm, can't find '%s'" % exe, verbose)
            return False
    log("[DONE]", verbose)

    # Check setup.py is correct directory
    vim_config_dir = os.path.join(HOME_DIR, ".vim/")
    if CURRENT_DIR != vim_config_dir:
        log("==> Tsk tsk, setup.py live here -> '%s'" % vim_config_dir, verbose)
        return False

    symlink(VIMRC, os.path.join(CURRENT_DIR, ".vimrc"), verbose)
    symlink(VUNDLERC, os.path.join(CURRENT_DIR, ".vundlerc"), verbose)
    vundle(verbose)
    bundles(verbose)
    caveats()
    return True


## Execution ###################################################################
SUCCESS = setup()
if not SUCCESS:
    print("""
==> Error: Unable to Complete Installation

    Please refer to suggestions.

    If you're unable to successfully install thereafter, please draw new
    issue on github.

    https://github.com/FrankyMartz/vimrc/issues/new
    """)
else:
    print("...Success!")

