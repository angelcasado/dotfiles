alias l="ls -al"
alias trash="open ~/.Trash"
alias net="open -a \"Firefox Developer Edition\""

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

COLOR_RED="\e[0;31m"
COLOR_YELLOW="\e[0;33m"
COLOR_GREEN="\e[0;32m"
COLOR_OCHRE="\e[38;5;95m"
COLOR_BLUE="\e[0;34m"
COLOR_WHITE="\e[0;37m"
COLOR_RESET="\e[0m"

function git_color {
  local git_status="$(git status 2> /dev/null)"

  if [[ ! $git_status =~ "working directory clean" ]]; then
    echo -e $COLOR_WHITE
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_OCHRE
  fi
}

function git_symbol {
  local git_status="$(git status 2> /dev/null)"

  if [[ ! $git_status =~ "working directory clean" ]]; then
    echo -e
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_OCHRE
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "($branch)"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "($commit)"
  fi
}

PS1="${COLOR_BLUE}\u ${COLOR_RED}in \[\e[0;32m\]\W"

if [ -n $(git_branch) ]; then
  PS1+="\[\$(git_color)\]"        # colors git status
  PS1+=" \$(git_branch) \[$COLOR_RESET\]"           # prints current branch
fi

print_before_the_prompt () {
    dir=$PWD
    home=$HOME
    dir=${dir/"$HOME"/"~"}
    printf "\n $txtred%s: $bldpur%s $txtgrn%s\n$txtrst" "$HOST_NAME" "$dir" "$(vcprompt)"
}

# PROMPT_COMMAND=print_before_the_prompt

PS1+="% \[\e[0m\]"

# PROMPT_COMMAND=print_before_the_prompt
# PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# PS1="$EMOJI >"


export PATH="/opt/homebrew/bin":$PATH
eval "$(rbenv init - bash)"

