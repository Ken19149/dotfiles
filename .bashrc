#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias vim='nvim'
alias vi='nvim'

alias minecraft='xmcl'
alias mc='xmcl'

alias genshin='an-anime-game-launcher'

alias sleep='systemctl suspend && hyprlock && hyprctl reload && hyprctl reload'


alias colemak='systemctl start keyd.service'
alias qwerty='systemctl stop keyd.service'

alias rpi-imager='xhost + && DISPLAY=:0 sudo rpi-imager'

alias hyprlock='hyprlock && hyprctl reload && hyprctl reload'

alias upgrade-all="yay -Syu && hyprpm update && nvim --headless '+Lazy! sync' +qa"

alias clock='clocktemp -tf 24'

export HYPRSHOT_DIR="/path/to/your/folder"


# pnpm
export PNPM_HOME="/home/ken/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
