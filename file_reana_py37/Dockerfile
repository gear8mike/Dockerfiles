FROM python:3.7.13-slim

RUN apt update -y \
    && apt install -y build-essential git
 
RUN pip install --no-cache-dir -U pip
RUN pip install --no-cache-dir naima==0.9.1 regions==0.4 Cython==0.29.32 && \
    pip install --no-cache-dir astropy==4.0 gammapy==0.17 && \
    pip install --no-cache-dir ipython==7.34.0 matplotlib==3.2.1 && \	
    pip install --no-cache-dir km3io km3pipe km3irf && \
    pip install --no-cache-dir pandas

