#!/usr/bin/env zsh

preexec() {
    typeset -g prompt_timestamp=$EPOCHSECONDS
}

precmd() {
    # https://github.com/sindresorhus/pretty-time-zsh
    integer elapsed
    (( elapsed = EPOCHSECONDS - ${prompt_timestamp:-$EPOCHSECONDS} ))
    local human
    local days=$(( elapsed / 60 / 60 / 24 ))
    local hours=$(( elapsed / 60 / 60 % 24 ))
    local minutes=$(( elapsed / 60 % 60 ))
    local seconds=$(( elapsed % 60 ))
    (( days > 0 )) && human+="${days}d "
    (( hours > 0 )) && human+="${hours}h "
    (( minutes > 0 )) && human+="${minutes}m "
    human+="${seconds}s"

    # date time
    PROMPT="$prompt_newline%F{yellow}%*%f "
    # path
    PROMPT+="%F{blue}%~%f "
    # exec time
    PROMPT+="%F{yellow}${human}%f"
    PROMPT+="$prompt_newline"
    [[ -n "$STY" ]] && PROMPT+="%F{242}${STY%.*}%f "
    [[ -n "$VIRTUAL_ENV" ]] && PROMPT+="%F{242}${VIRTUAL_ENV:t}%f "
    PROMPT+="%(?.%F{magenta}.%F{red})"
    [[ "$SSH_CONNECTION" != "" ]] && PROMPT+="%n@%m"
    PROMPT+="» %f"
}


prompt() {
    export PROMPT_EOL_MARK=''
    export VIRTUAL_ENV_DISABLE_PROMPT=1

    prompt_opts=(subst percent)
    # borrowed from promptinit, sets the prompt options in case pure was not
    # initialized via promptinit.
    setopt noprompt{bang,cr,percent,subst} "prompt${^prompt_opts[@]}"
    if [[ -z $prompt_newline ]]; then
        typeset -g prompt_newline=$'\n%{\r%}'
    fi


    zmodload zsh/datetime

    autoload -Uz add-zsh-hook

    add-zsh-hook precmd  precmd
    add-zsh-hook preexec preexec
}

prompt
