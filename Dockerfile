FROM ubuntu:latest

# Install aptitude stuff
RUN apt update
RUN --mount=type=cache,target=/var/cache/apt \
    apt install -y \
    cmake \
    gcc-arm-none-eabi \
    git

# Switch to non-root user
RUN adduser docker
USER docker
