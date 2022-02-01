#installation of ROOT with python 3.6
FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

#settings for Mybinder
ARG NB_USER=your_user
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

#maybe copy is not necessary
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
ENV PATH=$PATH:${HOME}/.local/bin


#python 3.6 and 2.7 installation
RUN apt-get update -y && \
    apt install software-properties-common -y && \
    add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get update -y && \
    apt-get install python3.6 python3.6-dev python2.7 python2.7-dev -y 

RUN apt-get update -y && \
    apt-get install wget python3-pip git -y 


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

RUN apt-get update -y && \
    apt-get install python -y 
    
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 10

USER ${NB_USER}

RUN pip3 install --no-cache --upgrade pip && \
    pip install --no-cache-dir notebook jupyterlab && \
    pip install numpy matplotlib && \
    pip install --no-cache-dir jupyterhub

ENV ROOT_VERSION=6.22.08

#installation of ROOT 
RUN cd ${HOME} &&\
    #ROOT_VERSION=6.22.08 && \
    wget https://root.cern/download/root_v${ROOT_VERSION}.source.tar.gz && \
    tar -xzvf root_v${ROOT_VERSION}.source.tar.gz && \
    rm root_v${ROOT_VERSION}.source.tar.gz && \
    CURRENT_PATH=`pwd` && \
    #mkdir ~/root && \
    #cd ~/ && \
    mkdir root_${ROOT_VERSION}-build root_${ROOT_VERSION}-install && \
    cd root_${ROOT_VERSION}-build && \
    cmake -DCMAKE_INSTALL_PREFIX=../root_${ROOT_VERSION}-install -Dmathmore=ON -Droofit=ON -Dminuit2=ON -Dpyroot=ON -DPython3_EXECUTABLE=/usr/bin/python3.6 -DPython2_EXECUTABLE=/usr/bin/python2.7 ${HOME}/root-${ROOT_VERSION} && \
    #cmake -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -build . -target install -j1 && \
    cmake --build . --target install -- -j8 && \
    cd .. && \
    rm -rf  root_${ROOT_VERSION}-build && \
    #cd $CURRENT_PATH && \
    rm -rf root-${ROOT_VERSION} && \
    echo "source ${HOME}/root_${ROOT_VERSION}-install/bin/thisroot.sh" >> ~/.bashrc 


ENV ROOTSYS="${HOME}/root_${ROOT_VERSION}-install" 
ENV LD_LIBRARY_PATH="${ROOTSYS}/lib:${LD_LIBRARY_PATH}" 
ENV PYTHONPATH="${ROOTSYS}/lib:${PYTHONPATH}"



#make a copy of aanet
COPY aanet.tar.gz ${HOME}
RUN cd ${HOME} && \
    tar -xvf aanet.tar.gz && \
    rm -rf aanet.tar.gz

RUN /bin/bash -c "source ${ROOTSYS}/bin/thisroot.sh && \
    cd ${HOME}/aanet && \
    source ./setenv.sh && \
    python3.6 ./make.py"

RUN echo "source ${HOME}/aanet/setenv.sh" >> ~/.bashrc 




