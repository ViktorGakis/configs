# If ~/.config/nvim exists, remove it
[ -d ~/.config/nvim ] && rm -rf ~/.config/nvim
[ -d ~/.local/share/nvim ] && rm -rf ~/.local/share/nvim
[ -d ~/.config/vscode ] && rm -rf ~/.config/vscode
[ -d ~/.config/.git ] && rm -rf ~/.config/.git

[ -d ~/.config_temp/nvim ] && rm -rf ~/.config_temp/nvim
[ -d ~/.config_temp/vscode ] && rm -rf ~/.config_temp/vscode
[ -d ~/.config_temp/.git ] && rm -rf ~/.config_temp/.git

# Clone the entire repo directly into ~/.config
git clone --depth 1 https://github.com/ViktorGakis/dotfiles.git ~/.config_temp

# Move all the content from the temp cloned directory to ~/.config
mv ~/.config_temp/* ~/.config_temp/.[!.]* ~/.config/

# Remove the temporary directory
rm -rf ~/.config_temp
