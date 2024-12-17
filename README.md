# My Dot Files

My dotfiles, that's about it. All of them are managed by [chezmoi](https://www.chezmoi.io/).
These dotfiles include configuration for:

- A deployment script for installing (almost) everything I use with [Just](https://github.com/casey/just) and chezmoi scripts
- A home page for qutebrowser based on the one by Distro Tube (Shameless ripoff)
- Bash and bash aliases.
- KDE keyboard shortcuts.
- Krita configuration and shortcuts.
- VIM and Neovim.
- [MPV](https://mpv.io/)
- [Hyprland](https://hyprland.org/) ecosystem.
- [Qutebrowser](https://qutebrowser.org/) and vimium.
- [Kitty](https://sw.kovidgoyal.net/kitty/) terminal emulator.

## Instalation

After the dotfiles are deployed, the deployment script will kick in (only compatible with Arch Linux)
One command deploy without installing chezmoi (requires curl to be installed).

```bash
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply NickGit95
```

If chezmoi is already installed

```bash
chezmoi init --apply https://github.com/NickGit95/dotfiles.git
```
