### global variables
export ENV_BASE_PATH=~/env
source $ENV_BASE_PATH/.global_export
source $ENV_BASE_PATH/.alias

if [[ -f ~/.alias ]]; then
    source ~/.alias
fi
