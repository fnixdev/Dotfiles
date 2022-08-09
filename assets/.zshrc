# PATH TO YOUR OH-MY-ZSH INSTALLATION
export ZSH=~/.oh-my-zsh

# ZSH_THEME
ZSH_THEME="muse"

# PLUGINS
# PATH CUSTOM PLUGINS: ~/.oh-my-zsh/custom/plugins
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

# RELOAD CONFIG
source $ZSH/oh-my-zsh.sh

# MEUS ALIASES
alias pac="sudo pacman -S"
alias psyu="sudo pacman -Syyu --noconfirm"
alias pacclean="sudo pacman -Sc --noconfirm"
alias pacsearch="pacman -Sl | cut -d' ' -f2 | grep"
alias cleaning="sudo rm -rf /var/cache/pacman/pkg/*.*"
alias weather="curl https://wttr.in/itabira?mn0"
alias fetch="~/scripts/fetch.sh"
alias sysinfo="~/scripts/sysinfo.sh"
alias pipes="~/scripts/pipes.sh"
alias rain="~/scripts/rain.sh"
alias q="exit"
alias py="python3"
alias pym="python3 -m"