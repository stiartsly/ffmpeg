#!/bin/bash
source config_common.sh
PREBUILT=/home/yalin/android-ndk-r10b/toolchains/arm-linux-androideabi-4.6/prebuilt/linux-x86 
PLATFORM=/home/yalin/android-ndk-r10b/platforms/android-9/arch-arm 
NDK_ROOT=/home/yalin/android-ndk-r10b
./configure --target-os=linux \
--arch=arm \
--extra-cflags="-I${NDK_ROOT}/platforms/android-9/arch-arm/usr/include -fPIC -DANDROID -std=c99" \
--disable-everything \
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
--enable-swscale \
--enable-cross-compile \
--cc=$PREBUILT/bin/arm-linux-androideabi-gcc \
--cross-prefix=$PREBUILT/bin/arm-linux-androideabi- \
--strip=$PREBUILT/bin/arm-linux-androideabi-strip \
--extra-cflags="-fPIC -DANDROID" \
--extra-ldflags="-Wl,-T,$PREBUILT/arm-linux-androideabi/lib/ldscripts/armelf_linux_eabi.x -Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib $PREBUILT/lib/gcc/arm-linux-androideabi/4.6/crtbegin.o $PREBUILT/lib/gcc/arm-linux-androideabi/4.6/crtend.o -lc -lm -ldl"

