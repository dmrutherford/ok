__ok_completion() {
  COMPREPLY=()
  local cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=($(compgen -W "$(ls .ok | sed 's/.sh//')" -- $cur))
}

complete -F __ok_completion ok
