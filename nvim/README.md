```bash

[ -d ~/.config_temp] && rm -rf ~/.config_temp
# Clone the entire repo directly into ~/.config
$ git clone --depth 1 https://github.com/ViktorGakis/dotfiles.git ~/.config_temp
$ bash ~/.config_temp/setup.sh
```

# TODO

1. adapt tabufline
2. add switcher
3. fix raindow indent
4. configure java
5. configure tmux settings
