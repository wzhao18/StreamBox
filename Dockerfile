FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y \
    g++ \
    libtbb-dev \
    automake \
    autoconf \
    autoconf-archive \
    libtool \
    libboost-all-dev \
    libevent-dev \
    libdouble-conversion-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    liblz4-dev \
    liblzma-dev \
    libsnappy-dev \
    zlib1g-dev \
    binutils-dev \
    libjemalloc-dev \
    libssl-dev \
    libpcre3-dev \
    cmake \
    make

COPY . /home

RUN cd /home/folly && \
    mkdir _build && \
    cd _build && \
    cmake .. && \
    make -j$(nproc) && \
    make install

RUN cd /home/re2 && \
    mkdir _build && \
    cd _build && \
    cmake -DCMAKE_CXX_FLAGS="-std=c++11" .. && \
    make -j$(nproc) && \
    make install

RUN cd /home/streambox && \
    mkdir _build && \
    cd _build && \
    cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_CXX_FLAGS="-std=c++11" \
        -G "CodeBlocks - Unix Makefiles" \
        .. && \
    make -j$(nproc)