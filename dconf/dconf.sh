#!/usr/bin/bash

SCRIPT_PATH=$(dirname $(readlink -f $0))

function die() {
    echo $1; exit 1
}

function _load() {
    for dir in "${!dconf_dirs[@]}"; do
        local file="${dconf_dirs["$dir"]}"
        [ ! -f $SCRIPT_PATH/$file ] && continue

        echo "load $file to $dir"
        if [[ "${dir: -1}" == "/" ]]; then
            cat $SCRIPT_PATH/$file | dconf load $dir
        else
            dconf write $dir "$(cat $SCRIPT_PATH/$file)"
        fi
    done
}

function _save() {
    for dir in "${!dconf_dirs[@]}"; do
        local file="${dconf_dirs["$dir"]}"
        local cmd="read"

        if [[ "${dir: -1}" == "/" ]]; then
            cmd="dump"
        fi

        echo "save $dir to $file"
        dconf $cmd $dir > $SCRIPT_PATH/$file
    done
}

function _dump() {
    for dir in "${!dconf_dirs[@]}"; do
        local file="${dconf_dirs["$dir"]}"
        local cmd="read"

        if [[ "${dir: -1}" == "/" ]]; then
            cmd="dump"
        fi

        dconf $cmd $dir
    done
}

function _diff() {
    for dir in "${!dconf_dirs[@]}"; do
        local file="${dconf_dirs["$dir"]}"
        local cmd="read"

        if [[ "${dir: -1}" == "/" ]]; then
            cmd="dump"
        fi

        if [ -f $SCRIPT_PATH/$file ]; then
            dconf $cmd $dir | diff -u $SCRIPT_PATH/$file -
        else
            dconf $cmd $dir | diff -u /dev/null -
        fi
    done
}

COMMAND=$(echo $1 | grep '^[a-z]*$')
CONFIG=$(echo $2 | grep '^[a-z]*$')

[[ -f $SCRIPT_PATH/config/$CONFIG ]] && \
            . $SCRIPT_PATH/config/$CONFIG \
            || die "Configuration \"$CONFIG\" not found."

[[ -z "${!dconf_dirs[@]}" ]] && die "No dconf_dirs found."

FUNC="_${COMMAND}"

declare -f -F $FUNC > /dev/null

[[ $? -eq 0 ]] || die "Command \"$COMMAND\" not found."

$FUNC

exit 0
