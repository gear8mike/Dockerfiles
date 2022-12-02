FROM python:3.10-slim

RUN apt update -y \
    && apt install -y build-essential git
 
RUN pip install --no-cache-dir -U pip
RUN pip install --no-cache-dir astropy gammapy==1.0 && \
    pip install --no-cache-dir km3io km3pipe km3irf && \
    pip install --no-cache-dir pandas

