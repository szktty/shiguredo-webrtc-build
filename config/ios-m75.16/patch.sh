#!/bin/sh

patch -buN $RTC_DIR/tools_webrtc/ios/build_ios_libs.py $PATCH_DIR/build_ios_libs.py.diff

