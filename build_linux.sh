#!/bin/bash

ROOT=$(pwd)

clean() {
  rm -rf $ROOT/build/linux
  rm -rf build
  rm -f $ROOT/bin/webf_run
}

build_release() {
  cd $ROOT/app
  flutter clean
  flutter build linux --release
  ARCH=$(arch)
  if [[ "$ARCH" == "x86_64" ]]; then
    cd $ROOT/app/build/linux/x64/release
    cp -r $ROOT/app/bin .
    ln -s ../bundle/webf_example bin/webf_example
    tar -zcvf $ROOT/platforms/cli-linux/app.tar.gz ./bundle ./bin
    ln -s ../app/build/linux/x64/release/bin/webf_run.sh $ROOT/bin/webf_run
  else
    echo "Only x86_64 support from now on, maybe someone can add more archs."
    exit 1
  fi
}

clean
build_release

