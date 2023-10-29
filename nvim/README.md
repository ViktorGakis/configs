```bash
[ -d ~/.config_temp/ ] && rm -rf ~/.config_temp/

git clone --depth 1 https://github.com/ViktorGakis/dotfiles.git ~/.config_temp/

bash ~/.config_temp/setup_nvim.sh
bash ~/.config_temp/setup_tmux.sh
```

# TODO

1. add tabufline
1. add theme switcher
1. searching
   - https://github.com/ggreer/the_silver_searcher
   - https://github.com/BurntSushi/ripgrep
1. [fix raindow indent](https://github.com/TheGLander/indent-rainbowline.nvim/issues/1)
1. configure c#

   - https://github.com/returntocorp/semgrep
   - https://www.youtube.com/watch?v=KpudmVmMWx4kk

1. Configure Java
1. Fix python debugger
