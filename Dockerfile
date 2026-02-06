FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Install system dependencies (matching Colab environment)
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3.10-venv \
    python3-pip \
    git \
    wget \
    curl \
    aria2 \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Set Python 3.10 as default
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1

# Install pip
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10

# Install Jupyter and IPython (to run notebooks)
RUN pip install --no-cache-dir \
    jupyter \
    notebook \
    ipython \
    ipywidgets \
    toml \
    pillow \
    safetensors \
    torch \
    torchvision \
    transformers \
    accelerate \
    diffusers

# Create Colab-like directory structure
RUN mkdir -p /content/drive/MyDrive

# Set working directory
WORKDIR /content

# Copy the notebook
COPY Lora_Trainer.ipynb /content/

# Expose Jupyter port
EXPOSE 8888

# Start Jupyter notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]
