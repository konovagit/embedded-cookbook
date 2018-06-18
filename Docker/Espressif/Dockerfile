
FROM ubuntu:16.04

# Create some directories
RUN mkdir -p /esp/project

# This is the directory where our project will show up
WORKDIR /esp/project

# Install build dependencies (and vim + picocom for editing/debugging)
RUN apt-get -qq update \
    && apt-get install -y git wget make libncurses-dev flex bison gperf python python-serial vim picocom \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Get the ESP32 toolchain and extract it to /esp/xtensa-esp32-elf
RUN wget -O /esp/esp-32-toolchain.tar.gz https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-73-ge28a011-5.2.0.tar.gz \
    && tar -xzf /esp/esp-32-toolchain.tar.gz -C /esp \
    && rm /esp/esp-32-toolchain.tar.gz

# Get the latest release of ESP-IDF from github and install it
RUN git clone -b v3.0-rc1 --recursive https://github.com/espressif/esp-idf.git /esp/esp-idf

# A "cool" prompt
RUN echo "PS1='(esp32) \\w\\a$ '" >> /root/.bashrc

# Add the toolchain binaries to PATH
ENV PATH /esp/xtensa-esp32-elf/bin:$PATH

# Setup IDF_PATH
ENV IDF_PATH /esp/esp-idf

CMD [ "/bin/bash" ]
