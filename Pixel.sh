#!/bin/bash

# Remove the local manifests directory if it exists (cleanup before repo initialization)
rm -rf .repo/local_manifests/
# remove device
rm -rf device/xiaomi/mojito
rm -rf device/xiaomi/sm6150-common
# remove kernel
rm -rf kernel/xiaomi/mojito
# remove hardware
rm -rf hardware/xiaomi
# remove vendor
rm -rf vendor/xiaomi/mojito
rm -rf vendor/xiaomi/sm6150-common
# Initialize ROM manifest
repo init -u https://github.com/Project-PixelStar/manifest -b 14-qpr3 --git-lfs
# repo sync
/opt/crave/resync.sh
# cloning DT
# remove vendor/pixelstar
rm -rf vendor/pixelstar
# device tree
git clone https://github.com/StarOS9/device_xiaomi_mojito.git --depth 1 -b mojito-universe device/xiaomi/mojito
git clone https://github.com/StarOS9/android_device_xiaomi_sm6150-common.git --depth 1 -b mojito-universe device/xiaomi/sm6150-common
# kernel tree
git clone https://github.com/StarOS9/kernel_xiaomi_mojito.git --depth 1 -b inline-rom kernel/xiaomi/mojito
# vendor tree
git clone https://gitlab.com/Sepidermn/android_vendor_xiaomi_mojito.git --depth 1 -b 14 vendor/xiaomi/mojito
git clone https://gitlab.com/Sepidermn/android_vendor_xiaomi_sm6150-common.git --depth 1 -b 14 vendor/xiaomi/sm6150-common
# hardware tree
git clone https://github.com/StarOS9/android_hardware_xiaomi.git --depth 1 -b mojito hardware/xiaomi
# add vendor/pixelstar
git clone https://github.com/StarOS9/vendor_pixelstar.git --depth 1 -b 14-qpr3 vendor/pixelstar
# set build environment
. build/envsetup.sh
# lunch
lunch pixelstar_mojito-userdebug
# bacon
mka bacon
