```bash
[ -d ~/.config_temp/ ] && rm -rf ~/.config_temp/

git clone --depth 1 https://github.com/ViktorGakis/dotfiles.git ~/.config_temp/

bash ~/.config_temp/setup_nvim.sh
```

# TODO

1. add tabufline
1. add theme switcher
1. [fix raindow indent](https://github.com/TheGLander/indent-rainbowline.nvim/issues/1)
1. configure c#

   - https://github.com/returntocorp/semgrep
   - https://www.youtube.com/watch?v=KpudmVmMWx4kk

1. configure java
