# EasySyntaxTree

A [Visual Studio Code](https://code.visualstudio.com) usage environment for [rsyntaxtree](https://github.com/yohasebe/rsyntaxtree).

## Installation

> **NOTE**: Everything in this repository assumes you are on Mac or Linux. I don't believe anything in this repository will work correctly on Windows, other than some simple Python scripts.

1. Install [Visual Studio Code](https://code.visualstudio.com).
2. Once installed, click Command+Shift+P, then paste `Shell Command: Install 'code' command in PATH` into the text field, then click enter.
3. Open up a terminal on your Mac (if you don't know how, just type Command+Spacebar, then type in 'terminal' and the app will be the first result).
4. In the terminal, type `git --version`, then click enter. If you simply get an output like `git version 2.30.0`, then continue to step 5. I assume that you will get an installer popup though, so go through the steps for that installation.
5. Now that `git` is installed, type `git clone https://github.com/camball/EasySyntaxTrees` in the terminal, and click enter.
6. In the terminal, type `bash rst-install.sh`, then click enter (this may take a couple minutes; just let it run).

> **NOTE**: These instructions are for those lacking technical knowledge/experience working in a Unix Environment. If you know what you are doing, feel free to pick apart the installation script and manually install things. The script assumes you have a fresh install of vscode on your computer, and may do unwanted actions to your settings.json if you already have vscode installed.

## Usage

1. With an `stree` file open in vscode, click "Run Code". This will produce a png file of the syntax tree for the current `stree` file. The png will have the same name as the current `stree` file as well.

## Motivation & Explanation

I found `rsyntaxtree` to be a great tool, but it was lacking two major features that were absolutely necessary for me to use it:

1. A way to provide file input
2. A way to name output files

Without file input, this tool was essentially useless to me. I wouldn't be able to save and manage my syntax trees without this. The way rsyntaxtree is set up is entire syntax tree needs to be provided as command line arguments, which I find incredibly counterintuitive. It also killed me that the tool would only output files called `syntree.*`, depending on the specified output file type.

So, to fix these problems, I thought to set up vscode as a remedy. My methodology was the following:

- Define a custom text file type to store syntax trees in. This way vscode knows when we are dealing with a syntax tree file. I decided on the file extension `.stree`.
- Customise [Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner) so that when I click 'Run Code' from an `stree` file in vscode, the png image is produced without any hassle.
- Rename the output png file from rsyntaxtree to have the same name as the `stree` file. The user can set up a system for organising their syntax trees this way.

I also wanted to be able to use developer tools that I would use for regular software development, like syntax highlighting and bracket matching. For this, I made sure to configure vscode to do this for the `stree` file type.

I found that it was still cumbersome to type lots of syntax trees, though. So to help, I created a few Python scripts to handle some repetitive tasks:

- Take in a list of sentences from a text file and put them into their own `stree` files.
- Surround each word in each `stree` file in a directory with brackets. This cuts down the amount of boilerplate work the user has to do.
- A combination of the above tasks.

There are many more helpful things I would like to add, but they probably aren't worth my time. I can think of all sorts of helpful things, though, if someone else wants to develop them. Namely...

- A way for vscode to syntax check your `stree` files, like it would for most programming languages.
- A way to define a "formal, natural language", meaning a set of phrase structure rules for a specific natural language (like English or French) that vscode could use to perform a semantic check of your `stree` files. The power of this would be "extended" syntax checking, where vscode could tell you when your tree is in violation of the rules of a natural language (e.g., you put a preposition after a noun phrase in a prepositional phrase (assuming English language), even if your tree is syntactically correct).
- Auto-complete for constituents. This would make typing bracket-diagrams for long sentences *much* easier. For example, the user could type "VP" then use the up/down arrow keys to select options containing pre-formatted dominated constituents according to the phrase structure rules for the natural language they are working in.
