# dotfiles

Personal dotfiles, managed with [chezmoi](https://www.chezmoi.io).

## Managed

- `~/.config/nvim` — external, cloned from [guisaez/nvim-config](https://github.com/guisaez/nvim-config)
- `~/.config/ghostty/config.ghostty` — tracked directly in this repo
- `~/.config/ghostty/shaders` — external, cloned from [sahaj-b/ghostty-cursor-shaders](https://github.com/sahaj-b/ghostty-cursor-shaders)
- `~/.tmux.conf` — tracked directly in this repo

## Usage

```sh
chezmoi init --apply guisaez/dotfiles
```
