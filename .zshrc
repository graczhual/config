export ZSH="/Users/changjun.zhu/.oh-my-zsh"

ZSH_THEME="robbyrussell"
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    autojump 
)
source $ZSH/oh-my-zsh.sh

alias ohmyzsh="mate ~/.oh-my-zsh"
alias ali='ssh changjun.zhu@j.graviti.cn'
alias pytest-dev='pytest --accesskey Accesskey-ec80eaaf8d3e3fad4aa0e2aea90e60f8 --url https://gas.dev.graviti.cn/'
alias pytest-uat='pytest --accesskey Accesskey-56762713d06de70459216974c06c70c0 --url https://gas.uat.graviti.cn/'
alias pytest-uat-com='pytest --accesskey ACCESSKEY-d836bbc6099e5112d904f56e413316a1 --url https://gas.uat.graviti.com/'
alias pytest-fat='pytest --accesskey Accesskey-aaba82a11da39088279333d0780817e3 --url https://gas.fat.graviti.cn/'
alias pytest-prod='pytest --accesskey Accesskey-300e653998b12912d4fb8783173f1a35 --url https://gas.graviti.cn/'
alias pytest-prod-com='pytest --accesskey ACCESSKEY-acbdb0b4e0f2fb8a98ace4f6faec17eb --url https://gas.graviti.com/'

alias ggas='python -m tensorbay.cli.cli'
alias gca='git commit --amend'



eval "$(pyenv init -)"
pyenv shell 3.9.4
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/bottles

#export GO111MODULE=on
export GOPATH=$HOME/golang
export PATH=$PATH:$GOPATH/bin
