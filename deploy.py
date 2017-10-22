#!/usr/bin/env python3

import os
import subprocess


class DeployError(Exception):
    pass


def skip_if_exists(full_filename, target_name):
    if os.path.islink(target_name):
        print("Skipping", full_filename, "->", target_name,
                "(Target is a symlink already")
        return True
    elif os.path.isfile(target_name):
        print("Skipping", full_filename, "->", target_name,
                "(Target is an ordinary file already")
        return True
    elif os.path.isdir(target_name):
        print("Skipping", full_filename, "->", target_name,
                "(Target is a directory already")
        return True
    return False


def handle_xdg_config(full_filename, basename, configdir):
    """Symlink directory under XDG_CONFIG_HOME"""
    target_name = os.path.join(configdir, basename)
    if skip_if_exists(full_filename, target_name):
        return
    print("Symlinking", full_filename, target_name)
    os.symlink(full_filename, target_name)


def handle_xdg_sublink(full_filename, basename, configdir):
    """Symlink directory contents under XDG_CONFIG_HOME directory"""
    target_name = os.path.join(configdir, basename)
    # We're okay with the directory existing, actually, we care more
    # about its files
    if os.path.isdir(target_name):
        print("Target", target_name, "exists")
    else:
        if skip_if_exists(full_filename, target_name):
            return
        else:
            print("Creating target", target_name)
            os.makedirs(target_name)

    print("Recursing into", full_filename)
    xdg_iterator = os.scandir(full_filename)
    for entry in xdg_iterator:
        if not entry.name.startswith("."):
            sub_full_filename = os.path.join(full_filename, entry.name)
            sub_target_name = os.path.join(target_name, entry.name)
            if skip_if_exists(sub_full_filename, sub_target_name):
                # Skipping
                continue
            # Skipped if it existed, now symlink
            print("Symlinking", sub_full_filename, sub_target_name)
            os.symlink(sub_full_filename, sub_target_name)


def handle_symlink(full_filename, basename, configdir):
    """Symlink file under HOME"""
    # Add full stop to basename
    target_name = os.path.join(configdir, ".{}".format(basename))
    if skip_if_exists(full_filename, target_name):
        return
    print("Symlinking", full_filename, target_name)
    os.symlink(full_filename, target_name)


def main():
    HOME = os.getenv("HOME")
    if HOME is None:
        raise DeployError("No home directory found, can't continue")
    print("Home dir:", HOME)

    XDG_CONFIG_HOME = os.getenv("XDG_CONFIG_HOME", os.path.join(HOME, ".config"))
    print("Config dir:", XDG_CONFIG_HOME)

    dotfiles_dir = os.path.dirname(os.path.realpath(__file__))
    print("Dotfiles dir:", dotfiles_dir)

    os.chdir(dotfiles_dir)
    print("Changed dir to dotfiles, carrying on")

    # Update git stuff
    subprocess.run(["git", "submodule", "init"]);
    subprocess.run(["git", "submodule", "sync"]);
    subprocess.run(["git", "submodule", "update", "--recursive"]);


    subdirs = []
    # This can be updated to:
    # with os.scandir(dotfiles_dir) as dotfiles_iterator:
    # in python 3.6
    dotfiles_iterator = os.scandir(dotfiles_dir)
    for entry in dotfiles_iterator:
        if not entry.name.startswith(".") and entry.is_dir():
            subdir = os.path.join(dotfiles_dir, entry.name)
            print("Found subdirectory", subdir)
            subdirs.append(subdir)

    installers = []
    for subdir in subdirs:
        print("Entering", subdir)
        subdir_iterator = os.scandir(subdir)
        for entry in subdir_iterator:
            if not entry.name.startswith("."):
                full_filename = os.path.join(subdir, entry.name)
                basename, extension = os.path.splitext(entry.name)

                if entry.is_dir():
                        # Only directories are the XDG things
                    if extension == ".xdg_config":
                        print("XDG dir found:", full_filename)
                        handle_xdg_config(full_filename, basename, XDG_CONFIG_HOME)
                    elif extension == ".xdg_sublink":
                        print("XDG dir (subfile link) found:", full_filename)
                        handle_xdg_sublink(full_filename, basename, XDG_CONFIG_HOME)

                # symlinks can be either directories or files
                if extension == ".symlink":
                    print("Symlink found:", full_filename)
                    handle_symlink(full_filename, basename, HOME)

                # For now, only support install.sh files as before
                if entry.name == "install.sh":
                    print("Installer found:", full_filename)
                    installers.append((subdir, full_filename))

                # If none of these match, just do nothing

    # Run installers last
    for subdir, installer in installers:
        print("Running", installer, "in", subdir)
        os.chdir(subdir)
        subprocess.run(["/bin/sh", installer])

    # Change back to dotfiles in case we still need to do something bc
    # otherwise I will never remember to add this here
    os.chdir(dotfiles_dir)


if __name__ == "__main__":
    main()
