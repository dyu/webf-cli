#!/bin/bash
[ "$1" != "" ] || { echo '1st arg (path/to/main.js) is required.'; exit 1; }

abs_path() {
    # generate absolute path from relative path
    # $1     : relative filename
    # return : absolute path
    if [ -d "$1" ]; then
        # dir
        (cd "$1"; pwd)
    elif [ ! -f "$1" ]; then
        echo "$1"
    elif [[ $1 = /* ]]; then
        echo "$1"
    elif [[ $1 == */* ]]; then
        echo "$(cd "${1%/*}"; pwd)/${1##*/}"
    else
        echo "$(pwd)/$1"
    fi
}

BIN=webf_example
CURRENT_DIR=$PWD

F=$BASH_SOURCE
[ -n "$F" ] || F=$0
F=`abs_path $F`
BIN_DIR=`dirname $F`
cd $BIN_DIR

while [ -h "$F" ]; do
    [ -e "$BIN" ] && break
    F=`readlink $F`
    F=`abs_path $F`
    BIN_DIR=`dirname $F`
    cd $BIN_DIR
done

[ -e "$BIN" ] || { echo "$PWD/$BIN not found."; exit 1; }

BIN_REL=`readlink $BIN`
BIN_ABS=`abs_path $BIN_REL`

cd $CURRENT_DIR
case "$1" in
    http*)
    export WEBF_BUNDLE_URL=$1
    ;;
    *)
    export WEBF_BUNDLE_PATH=`abs_path $1`
    ;;
esac

$BIN_ABS