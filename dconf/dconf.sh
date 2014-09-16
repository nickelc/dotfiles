#!/usr/bin/bash

SCRIPT_PATH=$(dirname $(readlink -f $0))

function die() {
    echo $1; exit 1
}

function _load() {
    [ ! -f $SCRIPT_PATH/$2 ] && die "$2 does not exists."
    echo "load $2 to $1"
    cat $SCRIPT_PATH/$2 | dconf load $1
}

function _save() {
    echo "save $1 to $2"
    dconf dump $1 > $SCRIPT_PATH/$2
}

function _dump() {
    dconf dump $1
}

function _diff() {
    if [ -f $SCRIPT_PATH/$2 ]; then
        dconf dump $1 | diff -u $SCRIPT_PATH/$2 -
    else
        dconf dump $1 | diff -u /dev/null -
    fi
}

COMMAND=$(echo $1 | grep '^[a-z]*$')
PROFILE=$(echo $2 | grep '^[a-z]*$')

[ -f $SCRIPT_PATH/profiles/$PROFILE ] && \
            . $SCRIPT_PATH/profiles/$PROFILE \
            || die "Profile \"$PROFILE\" not found."

FUNC="${PROFILE}_${COMMAND}"

declare -f -F $FUNC > /dev/null

[ $? -eq 0 ] && $FUNC || die "Command \"$COMMAND\" not found in \"$PROFILE\"."

exit 0
