#!/bin/sh
export CFLAGS="-Ofast -mfloat-abi=softfp -mfpu=vfpv3-d16 -mthumb -marm -march=armv7-a"
TARGET_ARCH=arm TOOLCHAIN_NAME=arm-linux-androideabi-4.9 HOST_COMPILER=arm-linux-androideabi "$(dirname "$0")/android-build.sh"
