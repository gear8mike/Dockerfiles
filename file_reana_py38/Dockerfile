FROM python:3.8-slim

# Set the working directory
# WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --no-cache-dir --user -U pip

# Copy the requirements file
COPY requirements.txt .

# Install Python dependencies
# RUN pip install --no-cache-dir --user Cython==0.29.32 numpy==1.21.6 && \
#     pip install --no-cache-dir --user -r requirements.txt

RUN pip install --no-cache-dir ipython==7.34.0 matplotlib==3.4.2 && \
    pip install --no-cache-dir naima==0.9.1 regions==0.5 Cython==0.29.32 && \
    pip install --no-cache-dir numpy==1.24.3 astropy>=4.0 gammapy==0.17 && \	
    pip install --no-cache-dir pandas iminuit tqdm nbconvert && \
    pip freeze

# Set the entrypoint to the bash shell
CMD ["/bin/bash"]
