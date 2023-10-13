```bash

:# If ~/.config/nvim exists, remove it

[ -d ~/.config/nvim ] && rm -rf ~/.config/nvim

# Clone the entire repo directly into ~/.config

git clone --depth 1 https://github.com/ViktorGakis/dotfiles.git ~/.config_temp

# Move all the content from the temp cloned directory to ~/.config

mv ~/.config*temp/* ~/.config*temp/.[!.]* ~/.config/

# Remove the temporary directory

rm -rf ~/.config_temp

```

# TODO

1. fix tabufline
2. theme switcher
3. fix raindow indent
4. fix indent key map
5. configure properly ruff_lsp
