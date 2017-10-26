# Ubuntu 16.04, CUDA 9.0
FROM nvidia/cuda:8.0-runtime-ubuntu16.04
RUN mkdir /mnt/images
VOLUME /mnt/images

LABEL maintainer "MICROSOFT CORPORATION" \
      com.microsoft.cntk.version="2.2"

ENV CNTK_VERSION="2.2"

RUN apt-get update && apt-get install -y --no-install-recommends \
    # General
        ca-certificates \
        wget \
        && \
    # Clean-up
    apt-get -y autoremove nvidia-375 nvidia-modprobe \
        && \
    rm ./app/requirements.txt \
    rm -rf /var/lib/apt/lists/*

# Get CNTK Binary Distribution
RUN CNTK_VERSION_DASHED=$(echo $CNTK_VERSION | tr . -) && \
    CNTK_SHA256="81d2409c1b72e835f941de302d8ce0f21c59c637cf7ff23814ff97a1700e8ddb" && \
    wget -q https://cntk.ai/BinaryDrop/CNTK-${CNTK_VERSION_DASHED}-Linux-64bit-GPU.tar.gz && \
    echo "$CNTK_SHA256 CNTK-${CNTK_VERSION_DASHED}-Linux-64bit-GPU.tar.gz" | sha256sum --check --strict - && \
    tar -xzf CNTK-${CNTK_VERSION_DASHED}-Linux-64bit-GPU.tar.gz && \
    rm -f CNTK-${CNTK_VERSION_DASHED}-Linux-64bit-GPU.tar.gz && \
    /bin/bash /cntk/Scripts/install/linux/install-cntk.sh --py-version 34 --docker

ADD requirements.txt ./app/requirements.txt
RUN apt-get install openmpi-bin nvidia-375 nvidia-modprobe nvidia-cuda-toolkit cuda && \
    apt-get install libqt4-core libqt4-dev libqt4-gui qt4-dev-tools graphviz && \
    pip install -r /app/requirements.txt

WORKDIR /root
