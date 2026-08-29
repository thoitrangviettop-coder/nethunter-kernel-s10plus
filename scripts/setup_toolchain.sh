#!/usr/bin/env bash
set -e

TOOLCHAIN_DIR="$(pwd)/toolchains"
mkdir -p "$TOOLCHAIN_DIR"

if [ ! -d "$TOOLCHAIN_DIR/clang" ]; then
 echo "Cloning Proton Clang..."
 git clone --depth=1 https://github.com/kdrag0n/proton-clang.git "$TOOLCHAIN_DIR/clang"
fi

if [ ! -d "$TOOLCHAIN_DIR/gcc64" ]; then
 echo "Cloning GCC64..."
 git clone --depth=1 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9.git "$TOOLCHAIN_DIR/gcc64"
fi

if [ ! -d "$TOOLCHAIN_DIR/gcc32" ]; then
 echo "Cloning GCC32..."
 git clone --depth=1 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9.git "$TOOLCHAIN_DIR/gcc32"
fi

echo "Toolchains ready."
