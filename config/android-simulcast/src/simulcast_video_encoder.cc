#include <jni.h>

#include "sdk/android/src/jni/jni_helpers.h"
#include "sdk/android/src/jni/video_encoder_factory_wrapper.h"
#include "sdk/android/src/jni/video_codec_info.h"
#include "media/engine/simulcast_encoder_adapter.h"

using namespace webrtc;
using namespace webrtc::jni;

#ifdef __cplusplus
extern "C" {
#endif

// (VideoEncoderFactory primary, VideoEncoderFactory fallback, VideoCodecInfo info)
JNIEXPORT jlong JNICALL Java_org_webrtc_SimulcastVideoEncoder_nativeCreateEncoder(JNIEnv *env, jclass klass, jobject primary, jobject fallback, jobject info) {
    JavaParamRef<jobject> primary_ref(primary);
    JavaParamRef<jobject> fallback_ref(fallback);
    JavaParamRef<jobject> info_ref(info);
    VideoEncoderFactoryWrapper primary_factory(env, primary_ref);
    VideoEncoderFactoryWrapper fallback_factory(env, fallback_ref);
    SdpVideoFormat format = VideoCodecInfoToSdpVideoFormat(env, info_ref);
    return NativeToJavaPointer(std::make_unique<SimulcastEncoderAdapter>(&primary_factory, &fallback_factory, format).release());
}

#ifdef __cplusplus
}
#endif


