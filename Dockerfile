FROM debian:bookworm-slim as debian-base


RUN apt-get update && \
    apt-get install -y \
    autoconf \
    automake \
    build-essential \
    ca-certificates \
    curl \
    git \
    libftdi-dev \
    libjim-dev \
    libtool \
    libusb-1.0-0-dev \
    pkg-config \
    python3-pip \
    texinfo \
    wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*



RUN mkdir -p /tempbuild

WORKDIR /tempbuild

RUN git clone https://github.com/espressif/openocd-esp32.git

WORKDIR /tempbuild/openocd-esp32


RUN ./bootstrap && \
    ./configure --enable-esp-usb-jtag && \
    make -j && \
    make install

WORKDIR /
RUN rm -rf /tempbuild



COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

FROM debian:bookworm-slim
COPY --from=debian-base / /




ENTRYPOINT ["/entrypoint.sh"]

