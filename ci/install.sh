#!/bin/bash

set -e

LIBSODIUM_VERSION=1.0.16

echo "Installing libsodium"
wget -q https://github.com/jedisct1/libsodium/releases/download/$LIBSODIUM_VERSION/libsodium-$LIBSODIUM_VERSION.tar.gz
tar -xzf libsodium-$LIBSODIUM_VERSION.tar.gz
(
    cd libsodium-$LIBSODIUM_VERSION/
    ./configure
    make
    sudo make install
)

echo "Install go dependencies"
go get -t ./...

echo "Build libsodium-go dependency"
(
  cd $GOPATH/src/github.com/GoKillers/libsodium-go/
  # clang can't compile this Oo
  export CC=gcc CXX=g++
  ./build.sh
  go install -v ./...
)