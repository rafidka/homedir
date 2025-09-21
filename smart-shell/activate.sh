export SMARTSHELL_HOME=~/smart-shell
export SMARTSHELL_PLUGINS=${SMARTSHELL_HOME}/plugins

case $SHELL in
*zsh)
    # Assume Zsh shell
    export SMARTSHELL_SHELLTYPE=zsh
    source ${SMARTSHELL_HOME}/smart-shell.zsh
    ;;
*bash)
    # Assume Bash shell
    export SMARTSHELL_SHELLTYPE=bash
    source ${SMARTSHELL_HOME}/smart-shell.bash
   ;;
*)
    # Assume something else
    echo "smart-shell: Unsupported shell: ${SHELL}"
esac
