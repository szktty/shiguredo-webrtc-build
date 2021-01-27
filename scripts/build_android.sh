#!/bin/bash

# usage: ./build_io.sh CONFIG_DIR

DTOOLS_DIR=$(cd $(dirname $0)/../build/depot_tools && pwd)
CONFIG_DIR=$(cd $1 && pwd)
BUILD_CONFIG_FILE=$CONFIG_DIR/CONFIG
BUILD_DIR=$(cd $(dirname $0)/../build/$(basename $CONFIG_DIR) && pwd)
GCLIENT_CONFIG_FILE=$CONFIG_DIR/GCLIENT
VERSION_CONFIG_FILE=$CONFIG_DIR/VERSION
PATCH_SCRIPT=$CONFIG_DIR/patch.sh
PATCH_DIR=$CONFIG_DIR/patch

SCRIPT_DIR=$(cd $(dirname $0) && pwd)
GEN_VERSION_CMD=$SCRIPT_DIR/generate_version_android.sh
VERSION_FILE=WebrtcBuildVersion.java
RTC_DIR=$BUILD_DIR/src
JAVA_SRC_DIR=$RTC_DIR/sdk/android/api/org/webrtc
BUILD_VERSION_FILE=$JAVA_SRC_DIR/$VERSION_FILE

BUILD_AAR_CMD=$RTC_DIR/tools_webrtc/android/build_aar.py
AAR_FILE=$BUILD_DIR/libwebrtc.aar

export PATH=$DTOOLS_DIR:$PATH

source $BUILD_CONFIG_FILE
source $VERSION_CONFIG_FILE


echo "Apply patches..."

if [ -e "$PATCH_SCRIPT" ]; then
  source $PATCH_SCRIPT
fi

echo "Generate $VERSION_FILE..."
echo "$GEN_VERSION_CMD $CONFIG_DIR > $BUILD_VERSION_FILE"
$GEN_VERSION_CMD $CONFIG_DIR > $BUILD_VERSION_FILE


echo "Build Android AAR..."

# --build_config はパッチ適用時に追加されるオプション
#BUILD_SCRIPT_OPTS="--build-dir $BUILD_DIR --output $AAR_FILE --build_config $CONFIG --arch $AAR_ARCH"
BUILD_SCRIPT_OPTS="--build-dir $BUILD_DIR --output $AAR_FILE --arch $AAR_ARCH"

pushd $RTC_DIR > /dev/null

echo python $BUILD_AAR_CMD $BUILD_SCRIPT_OPTS
python $BUILD_AAR_CMD $BUILD_SCRIPT_OPTS
