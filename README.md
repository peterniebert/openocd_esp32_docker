# Docker wrapper for [openocd-esp32](https://github.com/espressif/openocd-esp32)

This docker image is supposed to be run on a machine with an ESP32 dev board connected via USB.
It is aimed to separate the OpenOCD installation from the development environment.

I configured this for my own use, in particular for Zephyr development with ESP32 boards without
the need of installing ESP-IDF on the machine hosting the development board.

## Building the image:

Simply run `docker compose build`

## Running the container:

Connect your development board to the host via USB. Configure  `OPENOCD_INTERFACE`, `OPENOCD_TARGET`
and `HOST_IP` in docker-compose.yaml as needed, then run `docker compose up`. There is no point in running
the container detached (`-d`) since it might and should crash when the USB connection drops.

OpenOCD by default only allows connections from localhost, which by default would be the container itself. In
the containerized setup, all connections are "remote", so it is necessary to bind OpenOCD to a host IP address.
This can be done with `HOST_IP` in docker-compose.yaml. If there is no risk, you can set this to `0.0.0.0`. You cannot set it to "127.0.0.1" because that would only allow connections from the container itself. You can set it to the IP address of the docker bridge interface, though.

To test, start the container and connect with telnet:

```
telnet localhost 4444
```
