FROM python:3.8-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip install --no-cache-dir -U pip setuptools wheel

# Create a non-root user
RUN useradd -m myuser

# Set the working directory and change ownership to the non-root user
WORKDIR /app
RUN chown myuser:myuser /app

# Switch to the non-root user
USER myuser

# Set the MPLCONFIGDIR and XDG_CACHE_HOME environment variables to writable directories
ENV MPLCONFIGDIR /home/myuser/.config/matplotlib-custom
ENV XDG_CACHE_HOME /home/myuser/.astropy-custom

# Create the MPLCONFIGDIR and XDG_CACHE_HOME directories and make them writable
RUN mkdir -p $MPLCONFIGDIR $XDG_CACHE_HOME && \
    chmod 777 $MPLCONFIGDIR $XDG_CACHE_HOME

# Add Python to the system path
ENV PATH="/home/myuser/.local/bin:${PATH}"

# Copy the requirements file
COPY --chown=myuser:myuser requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir Cython==0.29.32 numpy==1.24.3 && \
    pip install --no-cache-dir -r requirements.txt