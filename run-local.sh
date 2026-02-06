#!/bin/bash

# Script to run the Kohya Colab notebook locally using Docker

set -e

echo "🐋 Setting up local Colab environment..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker Desktop."
    exit 1
fi

# Check for NVIDIA GPU support (optional, will work without it but slower)
if command -v nvidia-smi &> /dev/null; then
    echo "✅ NVIDIA GPU detected"
    USE_GPU=true
else
    echo "⚠️  No NVIDIA GPU detected. Training will use CPU (slower)."
    USE_GPU=false
fi

# Create local directory structure
echo "📁 Creating local directory structure..."
mkdir -p ~/Documents/lora_training/Loras
mkdir -p ~/Documents/lora_training/datasets

# Build the Docker image
echo "🔨 Building Docker image..."
docker compose build

# Start the container
echo "🚀 Starting Jupyter notebook server..."
if [ "$USE_GPU" = true ]; then
    docker compose up
else
    # Run without GPU support
    docker run -it --rm \
        -p 8888:8888 \
        -v ~/Downloads/lora/Downloads/lora/deck\ copy:/content/drive/MyDrive \
        -v $(pwd)/Lora_Trainer_XL.ipynb:/content/Lora_Trainer_XL.ipynb \
        kohya-colab-kohya-trainer
fi

echo ""
echo "✅ Jupyter notebook is running!"
echo "📖 Open your browser to: http://localhost:8888"
echo "📂 Your datasets should be in: ~/Documents/lora_training/"
echo ""
echo "Press Ctrl+C to stop the server"
