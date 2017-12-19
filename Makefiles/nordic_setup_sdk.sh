#!/bin/bash
# Set up Nordic nRF5 SDK
SDK_VERSION_ZIP=nRF5_SDK_14.2.0_17b948a.zip
SDK_URL="https://developer.nordicsemi.com/nRF5_SDK/nRF5_SDK_v14.x.x/nRF5_SDK_14.2.0_17b948a.zip"
SDK_DIRECTORY="libs/nRF5_SDK/"

if [ ! -d $SDK_DIRECTORY ]; then
  # Control will enter here if $SDK_DIRECTORY doesn't exist.
  if [ ! -d "libs/" ]; then
  echo Create libs folder
    mkdir libs
    mkdir $SDK_DIRECTORY
  else
  echo Create $SDK_DIRECTORY folder
    mkdir $SDK_DIRECTORY
  fi
fi
cd $SDK_DIRECTORY
curl -OJL $SDK_URL
if [[ $OS = MacOS ]]; then
  echo tar: Extracting $SDK_DIRECTORY/$SDK_VERSION_ZIP to $SDK_DIRECTORY ...
       tar --extract --file=$SDK_VERSION_ZIP
       rm $SDK_VERSION_ZIP
fi
