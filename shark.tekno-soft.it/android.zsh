export NDK_TOOLCHAIN_VERSION=4.7
export ANDROID_SDK=/opt/android-sdk-linux_x86/
export ANDROID_SDK_ROOT=$ANDROID_SDK
export ANDROID_NDK=/opt/android-ndk-r8d/
export ANDROID_NDK_ROOT=$ANDROID_NDK

PATH=$PATH:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_NDK_ROOT:$ANDROID_NDK_ROOT/toolchains/arm-linux-androideabi-4.7/prebuilt/linux-x86/bin
