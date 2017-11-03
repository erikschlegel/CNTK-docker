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
        apt-utils \
    # For Open MPI
        sudo \
	gcc \
        g++ \
        make \
    # For Image Reader
        libjasper1 \
        libjpeg8 \
        libpng12-0 \
    # For Kaldi Reader
        libgfortran3 \
        && \
    # Clean-up
    apt-get -y autoremove \
        && \
    rm -rf /var/lib/apt/lists/*

# Get CNTK Binary Distribution
RUN CNTK_VERSION_DASHED=$(echo $CNTK_VERSION | tr . -) && \
    CNTK_SHA256="81d2409c1b72e835f941de302d8ce0f21c59c637cf7ff23814ff97a1700e8ddb" && \
    wget -q https://cntk.ai/BinaryDrop/CNTK-${CNTK_VERSION_DASHED}-Linux-64bit-GPU.tar.gz && \
    echo "$CNTK_SHA256 CNTK-${CNTK_VERSION_DASHED}-Linux-64bit-GPU.tar.gz" | sha256sum --check --strict - && \
    tar -xzf CNTK-${CNTK_VERSION_DASHED}-Linux-64bit-GPU.tar.gz && \
    rm -f CNTK-${CNTK_VERSION_DASHED}-Linux-64bit-GPU.tar.gz && \
    /bin/bash /cntk/Scripts/install/linux/install-cntk.sh --py-version 34 --docker

WORKDIR /root
#ENV DEBIAN_FRONTEND=noninteractive

#RUN apt-get update && apt-get install -y nvidia-375
#RUN apt-get install -y nvidia-modprobe
#RUN apt-get install -y nvidia-cuda-toolkit
#RUN apt-get install -y cmake && apt-get update
RUN apt-get update && apt-get install -y python-pip
ADD requirements.txt requirements.txt
RUN pip install -r requirements.txt
#RUN apt-get update && apt-get install -y libblkid-dev e2fslibs-dev libboost-all-dev libaudit-dev
