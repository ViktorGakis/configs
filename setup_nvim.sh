# If ~/.config/nvim exists, remove it
[ -d ~/.config/nvim/ ] && rm -rf ~/.config/nvim/
[ -d ~/.local/share/nvim/ ] && rm -rf ~/.local/share/nvim/
[ -d ~/.config/vscode/ ] && rm -rf ~/.config/vscode/
[ -d ~/.config/.git ] && rm -rf ~/.config/.git


# Clone the entire repo directly into ~/.config
[ -d ~/.config_temp/ ] && rm -rf ~/.config_temp/
git clone --depth 1 https://github.com/ViktorGakis/dotfiles.git ~/.config_temp/

# Move all the content from the temp cloned directory to ~/.config+
[ -d ~/.config/ ] &&  mkdir -p ~/.config/
mv ~/.config_temp/* ~/.config_temp/.[!.]* ~/.config/

# Remove the temporary directory
rm -rf ~/.config_temp/
