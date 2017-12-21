Step 1: execute nordic_setup_sdk.sh (you can edit manualy the SDK target)
Step 2: go to the example folder of Nordic SDK and choose a project appropriate with your need.
	Example:
		libs/nRF5_SDK/nRF5_SDK_15.0.0_a53641a/examples/ble_peripheral/ble_app_template
Step 3: depend on your target nrf52832, nr52840 .... copy the linker file and the makeflie to your root directory
	Example:
		libs/nRF5_SDK/nRF5_SDK_15.0.0_a53641a/examples/ble_peripheral/ble_app_template/pca10056/s140/armgcc 
	copy ble_app_template_gcc_nrf52.ld and Makefile

Step 4: copy sdk_config.h to your include folder 
	Example:
		libs/nRF5_SDK/nRF5_SDK_15.0.0_a53641a/examples/ble_peripheral/ble_app_template/pca10056/s140/config

Step 5: copy main.c to your source folder
	Example:
		libs/nRF5_SDK/nRF5_SDK_15.0.0_a53641a/examples/ble_peripheral/ble_app_template

Step 6: copy nordic gcc toolchain folder into your tools/arm-gcc folder
	Example:
		libs/nRF5_SDK/nRF5_SDK_15.0.0_a53641a/components/toolchain/gcc

Step 6: your project should now look like this
	ble_app_template_gcc_nrf52.ld
	include/sdk_config.h
	libs/
	Makefile
	nordic_setup.sdk.sh
	source/main.c
	tools/

Step 7: Modify the Makefile
	Add:	
		SDK_VERSION= nRF5_SDK_15.0.0_a53641a		
		SOURCE_ROOT := source
                INCLUDE_ROOT := include
	Replace:
		SDK_ROOT := ../../../../../..
		$(PROJ_DIR)/main.c \
		../config \
		TEMPLATE_PATH := $(SDK_ROOT)/components/toolchain/gcc
		SDK_CONFIG_FILE := ../config/sdk_config.h
	By:
		SDK_ROOT := libs/nRF5_SDK/$(SDK_VERSION)
		$(SOURCE_ROOT)/main.c \
		$(INCLUDE_ROOT)/ \
		TEMPLATE_PATH := tools/arm-gcc
		SDK_CONFIG_FILE := $(INCLUDE_ROOT)/sdk_config.h
	Remove:
		PROJ_DIR := ../../..
