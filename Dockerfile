FROM ubuntu:latest

# Change aptitude rules so we can cache .deb files
RUN rm /etc/apt/apt.conf.d/docker-clean
RUN echo ' \
    Binary::apt::APT::Keep-Downloaded-Packages "true"; \
    APT::Keep-Downloaded-Packages "true"; \
' >> /etc/apt/apt.conf.d/99-keep-deb

# Install aptitude stuff
RUN apt update
RUN --mount=type=cache,dst=/var/cache/apt \
    apt install -y \
    clang-15 \
    clang-format \
    cmake \
    gcc-arm-none-eabi \
    git \
    libclang-15-dev \
    lld \
    pip

# Install pip stuff
RUN --mount=type=cache,dst=/root/.cache/pip \
    pip install cmakelang

# Make python3 default
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 0

# Make clang-15 default
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-15 0
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-15 0

# Compile and install IWYU
WORKDIR /root
RUN git clone --depth=1 -b clang_15 https://github.com/include-what-you-use/include-what-you-use
WORKDIR /root/include-what-you-use
RUN --mount=type=cache,dst=/root/include-what-you-use/build \
    cmake -B build -DCMAKE_PREFIX_PATH=/usr/lib/llvm-15
RUN --mount=type=cache,dst=/root/include-what-you-use/build \
    cmake --build build -t install -j4
RUN ln -s /usr/local/bin/include-what-you-use /usr/bin/iwyu
RUN mv iwyu_tool.py /usr/bin/

# Remove uncached build stuff
RUN rm -rf /root/*

# Switch to non-root user
RUN adduser docker
USER docker
