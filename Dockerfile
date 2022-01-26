#installation of ROOT with python 3.6
FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

#python 3.6 and 2.7 installation
RUN apt-get update -y && \
    apt install software-properties-common -y && \
    add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get update -y && \
    apt-get install python3.6 python3.6-dev python2.7 python2.7-dev -y 

RUN apt-get update -y && \
    apt-get install wget python3-pip git -y 

RUN pip3 install --no-cache --upgrade pip && \
    pip install --no-cache notebook jupyterlab && \
    pip install numpy

#ROOT required packages
RUN apt-get install dpkg-dev cmake g++ gcc binutils libx11-dev \ 
    libxpm-dev libxft-dev libxext-dev libssl-dev -y
#ROOT other packages
RUN apt-get install gfortran libpcre3-dev \
    xlibmesa-glu-dev libglew1.5-dev libftgl-dev \
    libmysqlclient-dev libfftw3-dev libcfitsio-dev \
    graphviz-dev libavahi-compat-libdnssd-dev \
    libldap2-dev libxml2-dev libkrb5-dev \
    libgsl0-dev -y

#installation of ROOT 
RUN ROOT_VERSION=6.22.08 && \
    wget https://root.cern/download/root_v$ROOT_VERSION.source.tar.gz && \
    tar -xzvf root_v$ROOT_VERSION.source.tar.gz && \
    rm root_v$ROOT_VERSION.source.tar.gz && \
    CURRENT_PATH=`pwd` && \
    #mkdir ~/root && \
    cd ~/ && \
    mkdir root_$ROOT_VERSION-build root_$ROOT_VERSION-install && \
    cd root_$ROOT_VERSION-build && \
    cmake -DCMAKE_INSTALL_PREFIX=../root_$ROOT_VERSION-install -Dmathmore=ON -Droofit=ON -Dminuit2=ON -Dpyroot=ON -DPython3_EXECUTABLE=/usr/bin/python3.6 -DPython2_EXECUTABLE=/usr/bin/python2.7 $CURRENT_PATH/root-$ROOT_VERSION && \
    #cmake -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -build . -target install -j1 && \
    cmake --build . --target install -- -j10 && \
    cd .. && \
    rm -rf  root_$ROOT_VERSION-build && \
    cd $CURRENT_PATH && \
    rm -rf root-$ROOT_VERSION && \
    echo "source /root/root_$ROOT_VERSION-install/bin/thisroot.sh" >> ~/.bashrc 


ENV ROOTSYS="/root/root_6.22.08-install" 
ENV LD_LIBRARY_PATH="${ROOTSYS}/lib:${LD_LIBRARY_PATH}" 
ENV PYTHONPATH="${ROOTSYS}/lib:${PYTHONPATH}"

RUN apt-get update -y && \
    apt-get install python -y 

#make a copy of aanet
COPY aanet.tar.gz .
RUN tar -xvf aanet.tar.gz && \
    rm -rf aanet.tar.gz

RUN /bin/bash -c "source ${ROOTSYS}/bin/thisroot.sh && \
    cd /aanet && \
    source ./setenv.sh && \
    python3.6 ./make.py"

RUN echo "source /aanet/setenv.sh" >> ~/.bashrc

