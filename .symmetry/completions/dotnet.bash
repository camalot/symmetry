#!/usr/bin/env bash
# https://github.com/dotnet/cli/blob/master/scripts/register-completions.bash
# bash parameter completion for the dotnet CLI

_dotnet_bash_complete()
{
  local word=${COMP_WORDS[COMP_CWORD]}
  local dotnetPath=${COMP_WORDS[1]}

  local completions=("$(dotnet complete --position ${COMP_POINT} "${COMP_LINE}")")

  COMPREPLY=( $(compgen -W "$completions" -- "$word") )
}

complete -f -F _dotnet_bash_complete dotnet
