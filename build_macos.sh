ROOT=$(pwd)

clean() {
    rm -rf $ROOT/build/darwin/debug/
    rm -rf $ROOT/build/darwin/release/
    rm -f $ROOT/bin/webf_run
}

build_release() {
    cd $ROOT/app
    flutter clean
    flutter build macos --release
    cd $ROOT/app/build/macos/Build/Products/Release
    cp -r $ROOT/app/bin .
    ln -s ../app.app/Contents/MacOS/app bin/webf_example
    tar -zcvf $ROOT/platforms/cli-macos/app.tar.gz ./app.app ./bin
    ln -s ../app/build/macos/Build/Products/Release/bin/webf_run.sh $ROOT/bin/webf_run
}

clean
build_release

