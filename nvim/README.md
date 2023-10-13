```bash
[ -d ~/.config_temp/ ] && rm -rf ~/.config_temp/

git clone --depth 1 https://github.com/ViktorGakis/dotfiles.git ~/.config_temp

bash ~/.config_temp/setup.sh
```

# TODO

1. fix db on insert mode.
1. adapt tabufline
1. add switcher
1. fix raindow indent
1. configure c#
1. configure java
1. wrap up tmux settings
