# Doom Emacs Configuration

![Supported versions](https://img.shields.io/badge/Supports-Emacs_26.3_--_27.1-blueviolet.svg?style=flat-square&logo=GNU%20Emacs&logoColor=white)

This is my personal configuration for [Doom Emacs](https://github.com/hlissner/doom-emacs), mostly focused towards programming and org-mode.

## How to use

1. [Install Doom Emacs](https://github.com/hlissner/doom-emacs#install)
2. Clone this repository:
   ```sh
   git clone https://github.com/chzerv/dotffiles
   ```
3. Copy/symlink my `config/doom` folder to either `~/.config/doom` or `~/.doom.d`.
4. Run `~/.emacs.d/bin/doom sync` to sync your Doom Emacs with my configuration.

## How is configuration structured?

I try to follow Doom's [file structure](https://github.com/hlissner/doom-emacs/blob/develop/docs/getting_started.org#writing-your-own-modules).

- Configuration for Doom's core package and for packages that are always installed can be found in `$DOOMDIR/config.el`.
- If a package's configuration requires extra packages to be installed or it's simply getting to big, I'll move it in a custom `module`. These modules can be found inside `$DOOMDIR/modules/chz/`. Note that these modules are prefixed with `chz` so they don't override the default modules.
- `$DOOMDIR/autoload/` contains autoloaded functions that provide a more generic use and don't belong to any module.

With this file structure, I have a startup time of `~1.1 seconds` on my kinda beefy desktop, and `~1.5 seconds` on my 10 years old laptop.
