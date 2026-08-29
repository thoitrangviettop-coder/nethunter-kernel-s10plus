#!/usr/bin/env bash
# =================================================================
# Kali NetHunter Kernel Automated Build Script for Samsung S10+
# Target: beyond2lte (Exynos 9820)
# =================================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}===================================================================${NC}"
echo -e "${GREEN} 🐉 Samsung Galaxy S10+ (beyond2lte) NetHunter Kernel Builder ${NC}"
echo -e "${BLUE}===================================================================${NC}"

WORKDIR="$(pwd)"
TOOLCHAIN_DIR="$WORKDIR/toolchains"
KERNEL_DIR="$WORKDIR/kernel_source"
OUTPUT_DIR="$WORKDIR/output"

mkdir -p "$TOOLCHAIN_DIR" "$OUTPUT_DIR"

# 1. Setup Toolchains
echo -e "${YELLOW}[1/5] Setting up compiler toolchains (Proton-Clang & GCC)...${NC}"
bash "$WORKDIR/scripts/setup_toolchain.sh"

# 2. Clone Kernel Source
if [ ! -d "$KERNEL_DIR/.git" ]; then
 echo -e "${YELLOW}[2/5] Cloning NetHunter Exynos 9820 source tree...${NC}"
 git clone --recurse-submodules https://github.com/v0lk3n/nethunter_kernel_samsung_exynos9820.git -b nethunter-lineage-23.2 "$KERNEL_DIR"
else
 echo -e "${GREEN}[OK] Kernel source directory exists.${NC}"
fi

# 3. Setup Environment Variables
echo -e "${YELLOW}[3/5] Setting up compilation environment variables...${NC}"
export ARCH=arm64
export SUBARCH=arm64
export CC=clang
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=aarch64-linux-android-
export CROSS_COMPILE_ARM32=arm-linux-androideabi-

export PATH="$TOOLCHAIN_DIR/clang/bin:$TOOLCHAIN_DIR/gcc64/bin:$TOOLCHAIN_DIR/gcc32/bin:$PATH"

OUT_DIR="$KERNEL_DIR/out"
mkdir -p "$OUT_DIR"
cd "$KERNEL_DIR"

DEFCONFIG="exynos9820-beyond2lte_defconfig"
if [ ! -f "arch/arm64/configs/$DEFCONFIG" ]; then
 DEFCONFIG="lineageos_beyond2lte_defconfig"
fi

echo -e "${YELLOW}[4/5] Generating config ($DEFCONFIG) and compiling kernel...${NC}"
make O="$OUT_DIR" mrproper
make O="$OUT_DIR" "$DEFCONFIG"

make -j$(nproc --all) O="$OUT_DIR" CC="$CC" CLANG_TRIPLE="$CLANG_TRIPLE" CROSS_COMPILE="$CROSS_COMPILE" CROSS_COMPILE_ARM32="$CROSS_COMPILE_ARM32" Image.lz4-dtb || make -j$(nproc --all) O="$OUT_DIR" CC="$CC" CLANG_TRIPLE="$CLANG_TRIPLE" CROSS_COMPILE="$CROSS_COMPILE" CROSS_COMPILE_ARM32="$CROSS_COMPILE_ARM32" Image

# 5. Package with AnyKernel3
echo -e "${YELLOW}[5/5] Packaging flashable AnyKernel3 ZIP...${NC}"
cd "$WORKDIR"
bash "$WORKDIR/scripts/package_anykernel.sh"

echo -e "${GREEN}===================================================================${NC}"
echo -e "${GREEN} 🎉 Build Complete! Output available in: ${OUTPUT_DIR} ${NC}"
echo -e "${GREEN}===================================================================${NC}"
