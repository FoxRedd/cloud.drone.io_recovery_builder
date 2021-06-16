#!/bin/bash

# Just a basic script U can improvise lateron asper ur need xD 

mkdir -p /tmp/recovery

cd /tmp/recovery

sudo apt install git -y

repo init --depth=1  --partial-clone --clone-filter=blob:limit=10M -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-11 -g default,-device,-mips,-darwin,-notdefault 

repo sync -j$(nproc --all)

git clone https://github.com/hraj9258/twrp_phoenix -b a11 device/xiaomi/phoenix

rm -rf out

. build/envsetup.sh && lunch omni_phoenix-eng && export ALLOW_MISSING_DEPENDENCIES=true && export LC_ALL="C" && mka recoveryimage

# Upload zips & recovery.img (U can improvise lateron adding telegram support etc etc)

cd out/target/product/phoenix

sudo zip -r9 TWRP-phoenix-a11.zip recovery.img

curl -sL https://git.io/file-transfer | sh 

./transfer wet *.zip

./transfer wet recovery.img