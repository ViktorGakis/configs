```bash
[ -d ~/.config_temp/ ] && rm -rf ~/.config_temp/

git clone --depth 1 https://github.com/ViktorGakis/dotfiles.git ~/.config_temp/

bash ~/.config_temp/setup.sh
```

# TODO

1. add tabufline
1. add theme switcher
1. Fix python debugger
1. Add harpoon v2
1. Add jsx support
1. Make eslint_d work
1. Reconfig nvimtree keymaps
