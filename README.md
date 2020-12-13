## .dotfiles in a bare Git repository

My current config [nickelc/dotfiles@bare][bare] :rocket: and the [old config][oldstyle] :skull:.

[bare]: https://github.com/nickelc/dotfiles/tree/bare
[oldstyle]: https://github.com/nickelc/dotfiles/tree/oldstyle

### Starting from scratch

```bash
# Create a new bare repository
git init --bare $HOME/.cfg

# Define the alias in the current shell scope
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Don't show untracked files for `git status`
config config --local status.showUntrackedFiles no

# Save config alias in `.zshrc` or `.bashrc`
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.zshrc

config add .vimrc
config commit -m "Add vimrc"

config add .zshrc
config commit -m "Add zshrc"
```

### Setup new system

```bash
# Clone the dotfiles into a bare repository.
git clone --bare <git-repo-url> $HOME/.cfg

# Define the alias in the current shell scope
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Don't show untracked files for `config status`
config config --local status.showUntrackedFiles no

# Checkout the actual content from the bare repository to your $HOME
config checkout
```
