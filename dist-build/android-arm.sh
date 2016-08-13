#!/bin/sh
export CFLAGS="-Ofast -mthumb -marm -march=armv6"

#you need android-ndk-r12b
TARGET_ARCH=arm TOOLCHAIN_NAME=arm-linux-androideabi-4.9 HOST_COMPILER=arm-linux-androideabi "$(dirname "$0")/android-build.sh"
