#/bin/bash

VERSION=android-simulcast
BASE_DIR=$(cd $(dirname $0)/../../; pwd)
CONFIG_DIR=$BASE_DIR/config/$VERSION
BUILD_DIR=$BASE_DIR/build/$VERSION
SDK_DIR=$BUILD_DIR/src/sdk/android
DIST_DIR=$1

pushd $CONFIG_DIR/src
cp BUILD.gn $SDK_DIR
cp SimulcastVideoEncoder*.java $SDK_DIR/api/org/webrtc
cp simulcast_video_encoder.h $SDK_DIR/src/jni
cp simulcast_video_encoder.cc $SDK_DIR/src/jni
popd

pushd $BASE_DIR
make $VERSION-nofetch
if [ "$DIST_DIR" != "" ]; then
  echo "cp $BUILD_DIR/libwebrtc.aar $DIST_DIR"
  cp $BUILD_DIR/libwebrtc.aar "$DIST_DIR"
fi


