FROM gitlab-registry.cern.ch/escape-wp2/docker-images/datalake-singleuser:cc7a62a9
LABEL maintainer="Enrique Garcia <enrique 'dot' garcia <dot> garcia 'at' cern <dot> ch>"

USER root
WORKDIR /opt

COPY ./environment.yml ./environment.yml

RUN conda install mamba -n base -c conda-forge && \
    mamba env create -f environment.yml && \
    conda clean --all -f -y

ENV PATH /opt/conda/envs/comb_km3net_cta/bin:$PATH
ENV CONDA_DEFAULT_ENV comb_km3net_cta

RUN echo "conda activate comb_km3net_cta" >> ~/.bashrc

WORKDIR $HOME
USER $NB_UID
