#!/usr/bin/bash

declare -A COLORS

COLORS=(
    ["red"]='\e[0;31m'
    ["yellow"]='\e[0;33m'
)

SCRIPT_PATH=$(dirname $(readlink -f $0))
CONFIG_FILE="$SCRIPT_PATH/config.json"

jsawk="jsawk -j /usr/bin/js24"

function die() {
    echo $1; exit 1
}

function colored() {
    local color="${2:-yellow}"
    local nc='\e[0m'

    echo -e "${COLORS["$color"]}$1${nc}"
}

function config_filter() {
    local filter="return this.name.match(/^${1//\//\\\/}/) ? this : null;"
    $jsawk -i $CONFIG_FILE "$filter" | $jsawk -n "out(this.key + '|' + this.file)"
}

function _load() {
    local configs=( $(config_filter $1) )

    for config in "${configs[@]}"; do
        local key="${config%%|*}"
        local file="${config##*|}"
        [ ! -f $SCRIPT_PATH/$file ] && continue

        echo "load $(colored $file) to $(colored $key red)"
        if [[ "${key: -1}" == "/" ]]; then
            cat $SCRIPT_PATH/$file | dconf load $key
        else
            dconf write $key "$(cat $SCRIPT_PATH/$file)"
        fi
    done
}

function _save() {
    local configs=( $(config_filter $1) )

    for config in "${configs[@]}"; do
        local key="${config%%|*}"
        local file="${config##*|}"
        local cmd="read"

        if [[ "${key: -1}" == "/" ]]; then
            cmd="dump"
        fi

        echo "save $(colored $key red) to $(colored $file)"
        dconf $cmd $key > $SCRIPT_PATH/$file
    done
}

function _dump() {
    local configs=( $(config_filter $1) )

    for config in "${configs[@]}"; do
        local key="${config%%|*}"
        local file="${config##*|}"
        local cmd="read"

        if [[ "${key: -1}" == "/" ]]; then
            cmd="dump"
        fi

        dconf $cmd $key
    done
}

function _diff() {
    local configs=( $(config_filter $1) )

    for config in "${configs[@]}"; do
        local key="${config%%|*}"
        local file="${config##*|}"
        local cmd="read"

        if [[ "${key: -1}" == "/" ]]; then
            cmd="dump"
        fi

        if [[ -f $SCRIPT_PATH/$file ]]; then
            dconf $cmd $key | diff -u $SCRIPT_PATH/$file -
        else
            dconf $cmd $key | diff -u /dev/null -
        fi
    done
}

COMMAND=$(echo $1 | grep '^[a-z]*$')
FILTER=$(echo $2 | grep '^[a-z/]*$')
FUNC="_${COMMAND}"

[[ -f $CONFIG_FILE ]] || die "Configuration \"config.json\" not found."

declare -f -F $FUNC > /dev/null

[[ $? -eq 0 ]] || die "Command \"$COMMAND\" not found."

$FUNC "$FILTER"

exit 0
