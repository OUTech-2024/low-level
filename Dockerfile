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
    clang-format \
    cmake \
    gcc-arm-none-eabi \
    git \
    pip

# Install pip stuff
RUN --mount=type=cache,dst=/root/.cache/pip \
    pip install cmakelang

# Switch to non-root user
RUN adduser docker
USER docker
