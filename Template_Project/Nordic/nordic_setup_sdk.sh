#!/bin/bash
# Set up Nordic nRF5 SDK
SDK_VERSION_ZIP=nRF5_SDK_15.2.0_9412b96.zip
SDK_VERSION=nRF5_SDK_15.2.0_9412b96
SDK_URL="https://developer.nordicsemi.com/nRF5_SDK/nRF5_SDK_v15.x.x/$SDK_VERSION_ZIP"
SDK_DIRECTORY="libs/nRF5_SDK/"

if [[ $(uname) = "Darwin" ]]; then
    echo Setting up for MacOS...
    OS=MacOS
elif [[ $(uname) = "Linux" ]]; then
    echo Setting up for Linux...
    OS=Linux
else
    >&2 echo "OS Unknown: $(uname)"
    exit 1
fi

#create folders
echo Create Source Folder
mkdir source
echo Create Include Folder
mkdir include
echo Create Libs Folder
mkdir libs
mkdir libs/nRF5_SDK
echo Create Tools Folder
mkdir tools
mkdir tools/toolchain

cd $SDK_DIRECTORY
echo Downloading $SDK_VERSION
curl -OJL $SDK_URL
if [[ $OS = MacOS ]]; then
  echo tar: Extracting $SDK_DIRECTORY/$SDK_VERSION_ZIP to $SDK_DIRECTORY ...
       tar --extract --file=$SDK_VERSION_ZIP
       rm $SDK_VERSION_ZIP
fi

cd ../../
echo Copy GCC toolchain
cp -R libs/nRF5_SDK/$SDK_VERSION/components/toolchain/gcc tools/toolchain

echo Copy Linker file and Makefile from BLE APP Template Example
cp libs/nRF5_SDK/$SDK_VERSION/examples/ble_peripheral/ble_app_template/pca10040/s132/armgcc/ble_app_template_gcc_nrf52.ld .
cp libs/nRF5_SDK/$SDK_VERSION/examples/ble_peripheral/ble_app_template/pca10040/s132/armgcc/Makefile .

echo copy SDK Config 
cp libs/nRF5_SDK/$SDK_VERSION/examples/ble_peripheral/ble_app_template/pca10040/s132/config/sdk_config.h include

echo copy Main.c 
cp libs/nRF5_SDK/$SDK_VERSION/examples/ble_peripheral/ble_app_template/main.c source

echo Modify Makefile structure
#Delete 7 first lines
sed -i -e '1,7d' Makefile
#add some extras lines
echo 'SDK_CONFIG_FILE := $(INCLUDE_ROOT)/sdk_config.h' | cat - Makefile > temp && mv temp Makefile
echo 'TEMPLATE_PATH := tools/gcc' | cat - Makefile > temp && mv temp Makefile
echo '$(INCLUDE_ROOT)/ \' | cat - Makefile > temp && mv temp Makefile
echo '$(SOURCE_ROOT)/main.c \' | cat - Makefile > temp && mv temp Makefile
echo 'SDK_ROOT := libs/nRF5_SDK/$(SDK_VERSION)' | cat - Makefile > temp && mv temp Makefile
echo 'INCLUDE_ROOT := include' | cat - Makefile > temp && mv temp Makefile
echo 'SOURCE_ROOT := source' | cat - Makefile > temp && mv temp Makefile
echo 'SDK_VERSION= '$SDK_VERSION | cat - Makefile > temp && mv temp Makefile
