#!/bin/sh

if [ -z "$ANDROID_NDK_HOME" ]; then
    echo "Please set ANDROID_NDK_HOME first, exiting."
    exit
fi

if [ -z $TARGET_ARCH ] || [ -z $HOST_COMPILER ]; then
    echo "Please use android-[arch].sh, exiting"
    exit 1
fi

if [ ! -f ./configure ]; then
    echo "Can not find ./configure, exiting"
    exit 1
fi

if [ -z "$TOOLCHAIN_DIR" ]; then
  export TOOLCHAIN_DIR="$(pwd)/android-toolchain-${TARGET_ARCH}"
  export MAKE_TOOLCHAIN="${ANDROID_NDK_HOME}/build/tools/make-standalone-toolchain.sh"

  if [ -z "$MAKE_TOOLCHAIN" ]; then
    echo "Can not find make-standalone-toolchain.sh, exiting"
    exit 1
  fi
  
  $MAKE_TOOLCHAIN --platform="${NDK_PLATFORM:-android-23}" \
                  --arch="${TARGET_ARCH}" \
                  --toolchain="${TOOLCHAIN_NAME:-arm-linux-androideabi-4.9}" \
                  --install-dir="${TOOLCHAIN_DIR}"

fi

export PREFIX="$(pwd)/arm_out"
export SYSROOT="${TOOLCHAIN_DIR}/sysroot"
export PATH="${PATH}:${TOOLCHAIN_DIR}/bin"

# Clean up before build
#rm -rf "${PREFIX}"

export CFLAGS="${CFLAGS} -I${SYSROOT}/usr/include -fPIC -D__ANDROID__ -std=c99"
export CPPFLAGS="${CPPFLAGS} ${CFLAGS}"
export LDFLAGS="${LDFLAGS} -L${SYSROOT}/usr/lib"

export CC="${TOOLCHAIN_DIR}/bin/arm-linux-androideabi-gcc" 
export CXX="${TOOLCHAIN_DIR}/bin/arm-linux-androideabi-cpp"
export AR="${TOOLCHAIN_DIR}/bin/arm-linux-androideabi-ar"
export RANLIB="${TOOLCHAIN_DIR}/bin/arm-linux-androideabi-ranlib"
export LD="${TOOLCHAIN_DIR}/bin/arm-linux-androideabi-gcc"
export NM="${TOOLCHAIN_DIR}/bin/arm-linux-androideabi-nm"
export AS="${TOOLCHAIN_DIR}/bin/arm-linux-androideabi-as"


./configure --host-os="${HOST_COMPILER}" \
            --prefix="${PREFIX}" \
            --sysroot="${SYSROOT}" \
            --sysinclude="${SYSROOT}/usr/include" \
            --target-os="linux" \
            --arch="arm" \
            --cc="${CC}" \
            --cxx="${AS}" \
            --ar="${AR}" \
            --ranlib="${RANLIB}" \
            --ld="${LD}" \
            --nm="${NM}" \
            --as="${AS}" \
            --enable-shared \
            --ranlib="${RANLIB}" \
            --enable-cross-compile \
            --enable-version3 \
            --enable-gpl \
            --enable-nonfree \
            --disable-stripping \
            --disable-ffmpeg \
            --disable-ffplay \
            --disable-ffserver \
            --disable-ffprobe \
            --disable-encoders \
            --disable-muxers \
            --disable-devices \
            --disable-protocols \
            --disable-network \
            --disable-avdevice \
            --disable-asm \
            --enable-decoder=h264 \
            --enable-swscale  \
            --disable-shared \
            --enable-jni 

make &&
make install

