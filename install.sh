#! /bin/bash

install_zsh_history_substring_search () {

    printf "installing zsh-history-substring-search\n"
    wget https://github.com/zsh-users/zsh-history-substring-search/archive/refs/heads/master.zip\
    && unzip master.zip \
    && rsync -av --exclude=".git" "./zsh-history-substring-search-master/" "$HOME/.config/zsh/plugins/zsh-history-substring-search/" \
    && rm -r master.zip* zsh-history-substring-search-master

}

install_zsh_syntax_highlighting () {
    
    printf "installing zsh-syntax-highlighting\n"
    wget https://github.com/zsh-users/zsh-syntax-highlighting/archive/refs/heads/master.zip \
    && unzip master.zip \
    && rsync -av --exclude=".git" "./zsh-syntax-highlighting-master/" "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/" \
    && rm -r master.zip* zsh-syntax-highlighting-master

}

install_zsh_autosuggestions () {

    printf "installing zsh-autosuggestions\n"
    wget https://github.com/zsh-users/zsh-autosuggestions/archive/refs/heads/master.zip \
    && unzip master.zip \
    && rsync -av --exclude=".git" "./zsh-autosuggestions-master/" "$HOME/.config/zsh/plugins/zsh-autosuggestions/" \
    && rm -r master.zip* zsh-autosuggestions-master

}

install_zsh_plugins () {

    mkdir "$HOME/.config/zsh/plugins" 

    if [[ -e "$HOME/.config/zsh/plugins" ]]; then

    install_zsh_history_substring_search
    install_zsh_syntax_highlighting
    install_zsh_autosuggestions

    fi

}

install_vimplug () {
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}

#checking that the system is run inide the dotfiles repository
if [[ "$PWD" != "$(git rev-parse --show-toplevel)" ]]; then
    echo "Error present working directory does not coincide with dotfiles2!"
    exit 5
fi

# checks that the destination folder exists and eventually creates it
if [[ ! ( -e "$HOME/.config" ) ]]; then
    echo "directory \"$HOME/.config\" does not exists. Proceeding to create it"
    mkdir "$HOME/.config"  
else 
    echo "directory \"$HOME/.config\" already exists"
fi

# installing dotfiles
install_zsh_plugins

# copying alacritty settings
rsync -av "alacritty" "$HOME/.config/"

# copying alacritty settings
rsync -av "emacs" "$HOME/.config/"

# copying alacritty settings
rsync -av "i3" "$HOME/.config/"

# installing VimPlug and neovim settings
install_vimplug
rsync -av "nvim" "$HOME/.config/"

# copying shell-independent terminal settings
rsync -av "terminal" "$HOME/.config/"

# copying tmux settings
rsync -av "tmux" "$HOME/.config/"

# copying zsh settings
rsync -av "zsh" "$HOME/.config/"
