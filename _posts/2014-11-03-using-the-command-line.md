---
layout: post
title: What Is The Command Line? 
categories: beginners-series unix
---

The "command line" or "shell" is a text-based interface to your
computer. All computers - whether they run Chrome OS, Apple OSX, or
Windows - have a shell. There are essentially two flavors of shells,
though - the UNIX shell and the Windows shell. This tutorial will
focus only on the UNIX shell; the structure of the Windows shell is
similar but there are some critical differences that are beyond the
scope of this tutorial to explain.

# Running A Shell

On an Apple OSX machine, you can start a shell by running an app called `Terminal`. We recommend instead using another shell application called `iTerm` which has more customization options.

If you don't have an OSX machine, we recommend you use the browser-based interface to a UNIX machine provided by the [Nitrous.io](nitrous.io) web service. The free tier will suffice for this tutorial.

# The Shell Prompt

When you start your shell application, the first thing you'll see is a message, followed by a cursor which is either a blinking underscore or a solid block. The message might look like:

    Last login: Sat Nov  1 09:41:41 on ttys001
    You have mail.
    ~#

The characters at the beginning of the last line, where your cursor is, is called the **shell prompt**. The prompt is an indication that the shell is ready to accept keyboard input from you.

# Files and Folders

The files and folders on your computer are arranged in a _hierarchical_ fashion - this means that each file is a _child_ of some folder, and so is each folder. The parent-child relationship between a folder and a file or another folder is depicted using the `/` character. So if the file `update.txt` is in the folder `docs`, then the location of that file can be written as `docs/update.txt`, denoting the parent-child relationship. [^1]

There is one (and only one) folder that has no parent (if that weren't the case, you would follow an infinite chain of parent folders!) This folder is called the system's **root folder** and is denoted by the character `/`

When you start a shell, you are placed in your _home folder_. The location of your home folder will depend on the system you are using. To find the location of the folder you are in, type `pwd` at the shell prompt after you start the shell. For example you might see something like this:

    ~# pwd
    /Users/sameer

Note that the prompt here shows the location of the current folder you are in - because it's the home folder, the prompt has the character `~` in it. Conventionally, `~` represents the home folder.

To change a folder, you use the command `cd`:

    ~# cd Desktop
    Desktop# pwd
    /Users/sameer/Desktop

If you change the folder using `cd`, and check the current folder you
are in again by typing in `pwd`, you will see that the output
changes. The folder that you are in at any point is called the
_current working directory_, the _present working directory_ or,
simply, the _working directory_.[^2]

# Some Special Folders

As mentioned before, the `~` character represents your home folder. So if you want to switch to your home folder from wherever you are currently, you type in `cd ~`.

Also, every folder has a parent folder - this is represented by the special name `..` (two consecutive periods, or _dots_) So to go one level up in the folder hierarchy, you have to type in `cd ..`

# Listing Files

To list the files in a folder, type in the command `ls`. Here, we have a folder with two files in it: `a.txt` and `b.txt`

    ~# ls
    a.txt    b.txt



# Homework

You might need to research on the Internet to answer these questions.

## UNIX Shell Basics

* How do you get a list of files in a folder, sorted by the last modified time? How do you reverse the order of sorting (most recently modified first, vs last)?
* We learned that the shell prompt is set by the value of the variable `PS1`. The common default on an OSX machine (in the `Terminal` app) is something like `\h:\W \u# ` This causes the current working folder to be shown, without showing its full path from the root folder. What should the value of `PS1` be, to show the full path instead?
* We learned that the character `~` stands for the home directory - `cd ~` will make the home directory your current directory. What shell (environment) variable tells you the full path to the home directory?
* The "shell," which takes your input from the keyboard and executes commands, etc. is actually itself an application. There are many "shell" applications you can use - the most common ones are probably the applications `bash`, `tcsh` and `zsh`. How can you find out what shell application you are running on our system?

## Regular Expressions

* What's a regular expression that matches only valid US zip codes?
  * How about one that matches only valid Japanese postal codes?
* Given a text file, how would you check the number of lines that end in the letter _z_? **Hint:** you need to learn the special operator for matching at the end of a line.
* Find all text (ending in `.txt` or `.text`) files in the current folder and any of its descendant folder. **Hint:** the `du` command is a useful way of doing a recursive listing of files, starting from the current folder.
* List the files in a folder that were created after 8PM. `ls` by itself does not have an option to filter a file list, so you'll have to do this with regular expressions and the `-l` option to `ls`.
* Print the number of files in a folder that are larger than 1KB.
  * Just by using `grep`, your solution might not work under certain circumstances. Feel free to propose a "good enough" solution that has some limitations - in that case, list what those limitations are.
* Continuing to use `grep`, how can you figure out how many files are at least two levels deep, starting from the current folder? (That is, they are in a sub-folder of a sub-folder of the current working folder.) **Hint:** You probably want to use `du` again

That's it - have fun!

[^1]: Here's one difference between UNIX shells and Windows shells.
[^2]: Note that the terms _directory_ and _folder_ will be used interchangeably in this tutorial.