#!/usr/bin/env bash
set -e

WORKDIR="$(pwd)"
KERNEL_OUT="$WORKDIR/kernel_source/out/arch/arm64/boot"
OUTPUT_DIR="$WORKDIR/output"
ANYKERNEL_DIR="$WORKDIR/AnyKernel3"

if [ ! -d "$ANYKERNEL_DIR" ]; then
 git clone https://github.com/osm0sis/AnyKernel3.git "$ANYKERNEL_DIR"
fi

cd "$ANYKERNEL_DIR"

# Copy kernel image
if [ -f "$KERNEL_OUT/Image.lz4-dtb" ]; then
 cp "$KERNEL_OUT/Image.lz4-dtb" ./Image.lz4-dtb
elif [ -f "$KERNEL_OUT/Image" ]; then
 cp "$KERNEL_OUT/Image" ./Image
else
 echo "Error: No kernel image found in $KERNEL_OUT"
 exit 1
fi

# Configure anykernel.sh
sed -i 's/kernel.string=.*/kernel.string=Kali NetHunter Kernel for Galaxy S10+ by Muhammad Fikri/' anykernel.sh
sed -i 's/device.name1=.*/device.name1=beyond2lte/' anykernel.sh
sed -i 's/device.name2=.*/device.name2=SM-G975F/' anykernel.sh
sed -i 's/device.name3=.*/device.name3=SM-G975FD/' anykernel.sh

ZIP_NAME="NetHunter-Kernel-beyond2lte-lossixteen-$(date +%Y%m%d-%H%M).zip"
zip -r9 "$OUTPUT_DIR/$ZIP_NAME" * -x .git README.md *placeholder

echo "Created Flashable ZIP: $OUTPUT_DIR/$ZIP_NAME"
