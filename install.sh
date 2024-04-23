#!/usr/bin/env bash

install_fonts() {
	echo "- Installing Maple Font..."
	fonts_dir="$HOME/Library/Fonts"
	font_url="https://github.com/subframe7536/maple-font/releases/download/v6.4/MapleMono-SC-NF.zip"
	mkdir -p "$fonts_dir"
	curl -so "$fonts_dir/MapleMono-SC-NF.zip" -L "$font_url"
	open "$fonts_dir"
	echo "Unzip the .zip file manually using a GUI application in the Fonts directory."
	read -p "Then you can delete the zip and press enter to continue..."
	fc-cache -V
	echo "Font installed at $fonts_dir!"
	echo
}

install_git_open() {
	echo "- Installing git-open..."
	curl -so "git-open" -L "https://raw.githubusercontent.com/paulirish/git-open/281dad270e02218c56c742759451ed66c6903dc2/git-open"
	chmod +x "git-open"
	mkdir -p "$HOME/.local/bin"
	mv "git-open" "$HOME/.local/bin/"
}

install_apps() {
	sudo dnf check-update
	sudo dnf upgrade -y

	# Install git, neovim, and fzf (mandatory)
	sudo dnf install -y git neovim fzf

	# Prompt the user about optional installations
	read -p "Do you want to install Alacritty, Nerd Fonts, and LazyVim (y/n)? " choice
	case "$choice" in
	y | Y)
		# Install Alacritty, Nerd Fonts, and LazyVim
		sudo dnf install -y alacritty
		install_fonts "MapleMono-SC-NF" "https://github.com/subframe7536/maple-font/releases/download/v6.4/MapleMono-SC-NF.zip"
		sudo dnf copr enable atim/lazygit
		sudo dnf install -y ripgrep fd-find make gcc-c++ lazygit
		;;
	n | N)
		# Skip optional installations
		echo "Skipping installation of Alacritty, Nerd Fonts, and LazyVim."
		;;
	*)
		echo "Invalid choice. Please enter 'y' or 'n'."
		;;
	esac
}

ensure_developer_dir() {
	if [ ! -d ~/Developer ]; then
		mkdir ~/Developer
		echo "Created the ~/Developer directory."
	else
		echo "The ~/Developer directory already exists."
	fi
}

ensure_config_dir() {
	if [ ! -d ~/.config ]; then
		mkdir ~/.config
		echo "Created the ~/.config directory."
	else
		echo "The ~/.config directory already exists."
	fi

	if [ ! -d ~/.config/zsh ]; then
		mkdir ~/.config/zsh
		echo "Created the ~/.config/zsh directory."
	else
		echo "The ~/.config/zsh directory already exists."
	fi
}

ensure_ssh_key() {
	if [[ ! -d ~/.ssh || ! -f ~/.ssh/id_ed25519.pub ]]; then
		echo "No supported SSH keys found."
	else
		echo "Found supported SSH key:"
		echo "- ~/.ssh/id_ed25519.pub"
		return 0
	fi
	read -p "Enter email address for ssh key: " email
	ssh-keygen -t "ed25519" -C "$email"
}

create_link() {
	src="$1"
	dest="$2"

	if [[ -z "$src" || -z "$dest" ]]; then
		echo "Usage: create_link src dest"
		return 1
	fi

	if [ -L "$dest" ]; then
		read -p "Link already exists at $dest. Do you want to replace it? (y/N) " -n 1 -r
		echo
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			rm "$dest"
		else
			echo "Abort..."
			return 1
		fi
	elif [ -e "$dest" ]; then
		echo "WARNING: $dest already exists and it's not a link."
		read -p "Do you want to remove it? (y/N) " -n 1 -r
		echo
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			rm -rf "$dest"
		else
			echo "Abort..."
			return 1
		fi
	fi

	ln -s "$src" "$dest"
	echo "Link created from $src to $dest."
}

create_links() {

	# zsh
	create_link "$(pwd)/config/shell/zshenv" "$HOME/.zshenv"
	create_link "$(pwd)/config/shell/zshrc" "$HOME/.config/zsh/.zshrc"
	create_link "$(pwd)/config/shell/secrets" "$HOME/.config/zsh/.secrets"

	# git and nvim
	create_link "$(pwd)/config/git" "$HOME/.config/git"
	create_link "$(pwd)/config/nvim" "$HOME/.config/nvim"

	# alacritty, lazyvim and lazygit
	create_link "$(pwd)/config/alacritty" "$HOME/.config/alacritty"
	create_link "$(pwd)/config/lazyvim" "$HOME/.config/lazyvim"
	create_link "$(pwd)/config/lazygit" "$HOME/.config/lazygit"

	# zellij
	create_link "$(pwd)/config/zellij" "$HOME/.config/zellij"

	# papis
	create_link "$(pwd)/config/papis" "$HOME/.config/papis"

	# kickstart
	create_link "$(pwd)/config/kickstart" "$HOME/.config/kickstart"

	# kickstart
	create_link "$(pwd)/config/mini" "$HOME/.config/mini"

	# Set up the default background
	# create_link /usr/share/backgrounds/default.png "$HOME/.config/sway/background.png"
}

post_install() {
	echo
	echo "Here are some other thing you want to install:"
	echo
	echo "Python"
	echo "  The suggests way is to use pyenv: https://github.com/pyenv/pyenv/tree/master"
	echo "  Remember to install dependencies for compile python, i.e."
	echo "  https://github.com/pyenv/pyenv/wiki#suggested-build-environment"
	echo "  You can also compile optimize pytohn version"
	echo "  https://github.com/pyenv/pyenv/blob/master/plugins/python-build/README.md#building-for-maximum-performance"
	echo
	echo "NodeJS"
	echo "  It's required to run Copilot in lazyvim. Install with"
	echo "  sudo dnf install nodejs"
	echo "  There in no need to install neovim package for nodejs."
}

ensure_config_dir
# ensure_developer_dir
# ensure_ssh_key
# install_apps

# TODO: ask permission
#install_fonts

# install_git_open
create_links
#post_install
