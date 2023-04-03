FROM fedora:38

ENV SHELL /bin/bash

ARG NB_USER=msmirnov
ARG NB_UID=1900
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --uid ${NB_UID} \
    ${NB_USER}

RUN dnf install passwd -y && \
    # sudo usermod -aG sudo ${NB_USER}
    passwd -d ${NB_USER}

USER root
ENV PATH=$PATH:${HOME}/.local/bin

USER ${NB_USER}


WORKDIR ${HOME}