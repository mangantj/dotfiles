## Setup a new machine

1. Install desired packages

    ```sh
    git
    tmux
    vim
    zsh
    # etc...
    ```

1. Install oh-my-zsh

  Follow instructions at: https://github.com/robbyrussell/oh-my-zsh

1. Setup dotfiles

    ```sh
    git clone git@github.com:coderberry/cf-dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    ./bin/symlink_dotfiles
    ```

1. Install plug for vim: https://github.com/junegunn/vim-plug

    Then run `vim --not-a-term +PlugInstall +qall`

    or `:PlugInstall` after launching neovim.

1. Install Powerline fonts: https://github.com/powerline/fonts

    ```sh
    git clone https://github.com/powerline/fonts.git ~/fonts
    ~/fonts/.install.sh
    ```

1. Setup tmux config: https://github.com/gpakosz/.tmux

    ```sh
    git clone https://github.com/gpakosz/.tmux.git ~/.tmux
    ln -s -f ~/.tmux/.tmux.conf ~/.tmux.conf
    ```


### Additional Installations

- raycast.com
- spotify.com

