# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

- Free online [book](https://lazyvim-ambitious-devs.phillips.codes/course/chapter-1/)


## 🛠️ Installation

#### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

#### Create a new user repository from this template

Press the "Use this template" button above to create a new repository to store your user configuration.

You can also just clone this repository directly if you do not want to track your user configuration in GitHub.

#### Clone the repository

```shell
git clone https://github.com/LazyVim/LazyVim ~/.config/lazynvim
cd ~/.config/lazynvim
git remote rename origin upstream
git remote set-upl origin https://github.com/<your_user>/<your_repository>
git push origin main
```

#### Updating LazyVim core settings (if desired)

```shell
git fetch upstream
```


#### Spell file configuration

```sh
export NVIM_APPNAME=lazynvim
mkdir -p ~/.dotfiles.git/.config/${NVIM_APPNAME:-nvim}/spell
touch ~/.dotfiles.git/.config/${NVIM_APPNAME:-nvim}/spell/en.utf-8.add
nvim --headless -c "set spell" -c "qall"
nvim --headless -c "set spellfile=~/.config/${NVIM_APPNAME:-nvim}/spell/en.utf-8.add" -c "qall"
nvim --headless -c "mkspell! ~/.config/${NVIM_APPNAME:-nvim}/spell/en.utf-8.add" -c "qall"
nvim --headless -c "echo &spellfile" -c "echo &spelllang" -c "echo &spell" -c "qall"
nvim --headless -c "spellgood lazynvim" -c "qall"
```

#### Start Neovim

```shell
nvim
```

```

```

