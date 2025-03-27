FROM rust:latest

# 필요한 패키지 설치
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    lld \
    llvm \
    cmake \
    pkg-config \
    libssl-dev \
    zlib1g-dev \
    curl \
    file \
    git \
    unzip \
    nano \
    binutils-aarch64-linux-gnu \
    mingw-w64 \
    gcc-mingw-w64-x86-64 \
    libc6-dev-i386 \
    g++-multilib \
    autoconf \
    bison \
    flex \
    libtool \
    texinfo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# binutils-aarch64-linux-gnu #for strip(linux-aarch64) $ aarch64-linux-gnu-strip

# aarch64-w64-mingw32-strip. download build install. for $ aarch64-w64-mingw32-strip
RUN mkdir -p /tmp/binutils-src && cd /tmp/binutils-src && \
    curl -LO https://ftp.kaist.ac.kr/gnu/binutils/binutils-2.44.tar.gz && \
    tar -xf binutils-2.44.tar.gz && \
    mkdir binutils-build && cd binutils-build && \
    ../binutils-2.44/configure --target=aarch64-w64-mingw32 --prefix=/opt/binutils-aarch64 --disable-multilib && \
    make -j$(nproc) && \
    make install && \
    rm -rf /tmp/binutils-src

ENV PATH="/opt/binutils-aarch64/bin:$PATH"

# zig 설치
RUN curl -LO https://ziglang.org/download/0.14.0/zig-linux-x86_64-0.14.0.tar.xz
RUN tar -xf zig-linux-x86_64-0.14.0.tar.xz
RUN mv zig-linux-x86_64-0.14.0 /opt/zig
RUN ln -s /opt/zig/zig /usr/local/bin/zig
RUN rm -rf zig-linux-x86_64-*

RUN cargo install cargo-zigbuild

RUN rustup target add x86_64-unknown-linux-gnu
RUN rustup target add aarch64-unknown-linux-gnu
RUN rustup target add x86_64-apple-darwin
RUN rustup target add aarch64-apple-darwin
RUN rustup target add x86_64-pc-windows-gnu
RUN rustup target add aarch64-pc-windows-gnullvm

# rustfmt와 clippy 설치
RUN rustup component add rustfmt clippy

# 작업 디렉터리 설정 (마운트된 코드 사용할 것이므로 복사 X)
WORKDIR /workspace

# 기본 실행 명령 (컨테이너가 종료되지 않도록 tail 사용)
CMD [ "tail", "-f", "/dev/null" ]
