ESP-32 Build Environment for Docker
===================================

**esp32env** helps you to work with Espressif IoT Development Framework without
having to install all the toolchain.

The solution is made from two components:

1. A docker image containing all the necesary dependencies to build and flash
ESP32 chip programs.

2. A shell transparently use the docker image from your own shell.


Dependencies
------------
- [Docker](https://www.docker.com/products/docker-toolbox)
- sudo


Quick Setup
-----------
- First clone this repository.
- Then ...
```bash
$ make download  # Or `make build` if you prefer to build the image locally
$ make install
```


Usage
-----

Easy as pie. You can use **any** command from the Espressif IDF documentation
but prepending the command *esp32env*. For example:

```bash
$ esp32env make menuconfig  # Instead of the traditional `make menuconfig`
$ esp32env make flash  # Instead of `make flash`
```

To get a shell inside the esp32env container just run `esp32env` without
parameters.


Acknowledgements
----------------

**esp32env** is a derived work of Brian Schwind's esp-32-build and nilp0inter/esp32env
Thanks!
