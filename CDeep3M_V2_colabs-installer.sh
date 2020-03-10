#!/bin/bash
#@ Install dependencies
echo "Installing dependencies: Expected runtime 3-5 min."
apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    wget \
    ssh \
    apt-utils \
    python-dev \
    python-numpy \
    python-pip \
    python3-pip \
    python-setuptools \
    python3-setuptools \
    python-opencv \
    libblas-dev \
    liblapack-dev\
    libatlas3-base\
    libatlas-base-dev\
    libprotobuf-dev \
    libleveldb-dev \
    libsnappy-dev \
    libopencv-dev \
    libboost-all-dev \
    libhdf5-serial-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    liblmdb-dev \
    protobuf-compiler \
    libboost-all-dev \
    build-essential \
    cmake \
    git \
    pkg-config \
    libjpeg8-dev \
    libgtk2.0-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libv4l-dev \
    gfortran \
    libleveldb1v5 \
    libleveldb-dev \
    python3-leveldb \
    time \
    unzip \
    zip \
    nano \
    mlocate \
    graphicsmagick \
    graphicsmagick-dbg \
    parallel \
    octave-pkg-dev && \
	apt-get remove --yes --purge --autoremove equivs && \
	rm -rf /var/lib/apt/lists/*

# BATS Install
echo "Installing Bats: Expected runtime 2 min."
mkdir -p /home/nd_sense/ /home/nd_sense/BATS
cd /home/nd_sense/BATS && \
    git clone https://github.com/bats-core/bats-core.git && \
    cd bats-core && \
    ./install.sh /usr/local

# Build CAFFE
echo "Updating python packages for CAFFE: Expected runtime 3 min."
pip install --upgrade pip
pip2 install wheel
pip2 install joblib requests Cython>=0.19.2 numpy>=1.16.5 scipy>=0.13.2 scikit-image>=0.9.3 matplotlib>=2.0.0 ipython>=5.5.0 h5py>=2.2.0 networkx==1.8.1 nose==1.3.7 pandas==0.24.0 python-dateutil==2.5 protobuf>=2.5.0 python-gflags==2.0 pyyaml>=4.2b1 Pillow==4.3.0 six==1.12
#!pip2 install -r /home/nd_sense/requirements.txt
pip3 install --upgrade pip
sed -i 's/from pip import main/from pip._internal import main/g' /usr/bin/pip3
pip3 install wheel
#!pip3 install -r /home/nd_sense/requirements3.txt
pip3 install h5py joblib requests Cython numpy scipy matplotlib scikit-image ipython leveldb networkx nose pandas python-dateutil protobuf python-gflags pyyaml Pillow six
find . -type f -exec sed -i -e 's^"hdf5.h"^"hdf5/serial/hdf5.h"^g' -e 's^"hdf5_hl.h"^"hdf5/serial/hdf5_hl.h"^g' '{}' \;
cd /usr/lib/x86_64-linux-gnu && \
    ln -s libhdf5_serial.so.8.0.2 libhdf5.so && \
    ln -s libhdf5_serial_hl.so.8.0.2 libhdf5_hl.so
cd  /home/nd_sense/
echo "Downloading CAFFE: Expected runtime 1 min."
git clone https://github.com/haberlmatt/caffe_nd_sense_segmentation
echo "Building CAFFE: Expected runtime 10-15 min."
cd /home/nd_sense/caffe_nd_sense_segmentation/
cp Makefile.config.example Makefile.config
make all -j $(($(nproc) + 1)) && \
    make test -j $(($(nproc) + 1)) && \
    make pycaffe -j $(($(nproc) + 1)) && \
    make distribute -j $(($(nproc) + 1)) && \
    cp -r distribute/bin/* /usr/bin/ && \
    cp -r distribute/include/* /usr/include/ && \
    cp -r distribute/lib/* /usr/lib/ && \
    mkdir -p /content/caffe_nd_sense_segmentation/.build_release && \
    ln -s /content/caffe_nd_sense_segmentation/distribute/bin /content/caffe_nd_sense_segmentation/.build_release/tools    
 echo "Building CAFFE completed"
###########################
# Install CDeep3M V1.6.3
###########################
"""
cd /home
rm -r /home/cdeep3m

#!git clone git@github.com:CRBS/cdeep3m.git /home/cdeep3m
git clone https://github.com/CRBS/cdeep3m.git /home/cdeep3m
cd /home/cdeep3m
ls /home/cdeep3m
"""

###########################
# Install CDeep3M V2.1.0
###########################
echo "Installing CDeep3M V2.1: Expected runtime 3 min."
mkdir /home/temp
cd /home/temp
wget https://www.dropbox.com/s/nievvzwu4sslaqg/cdeep3m_v210.zip?dl=0
unzip /home/temp/cdeep3m_v210.zip?dl=0 -d /home/
rm /home/temp/*
mv /home/cdeep3m_py3-master /home/cdeep3m
#!ls /home/cdeep3m
#%cd /home/cdeep3m/
#!ls /home/cdeep3m/requirements
cd /home/cdeep3m/
pip2 install -r /home/cdeep3m/requirements/py2_cdeep3m_reqs.txt
pip3 install -r /home/cdeep3m/requirements/py3_cdeep3m_reqs.txt
chmod 777 /home/cdeep3m/*
os.environ['PATH'] += ":/home/cdeep3m/"

echo "Installation of CDeep3M complete"
