# Running Kohya Colab Locally on Mac with Docker

This setup allows you to run the Lora Trainer notebook on your Mac using Docker, simulating the Google Colab environment.

## Prerequisites

1. **Docker Desktop** - [Download here](https://www.docker.com/products/docker-desktop)
   - Make sure Docker Desktop is running before starting

2. **NVIDIA GPU (Optional)** - For faster training
   - If you have an NVIDIA GPU, install [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)
   - Without GPU, training will be slower but still work

## Setup

### 1. Install Docker Desktop
```bash
# Download and install Docker Desktop for Mac
# Then start Docker Desktop from your Applications folder
```

### 2. Prepare Your Dataset
```bash
# Create the directory structure
mkdir -p ~/Documents/lora_training/Loras/your_project_name/dataset

# Put your training images in:
# ~/Documents/lora_training/Loras/your_project_name/dataset/
```

### 3. Start the Local Environment
```bash
# Make the run script executable
chmod +x run-local.sh

# Run the setup script
./run-local.sh
```

This will:
- Build a Docker image with the Colab environment
- Start Jupyter notebook server
- Mount your local directories to `/content/drive/MyDrive`

### 4. Access Jupyter Notebook
Open your browser to: **http://localhost:8888**

You'll see the Lora_Trainer_XL.ipynb notebook ready to run!

## Directory Mapping

Your Mac's directories are mapped to Colab paths:

| Mac Path | Container Path (Colab equivalent) |
|----------|-----------------------------------|
| `~/Documents/lora_training` | `/content/drive/MyDrive` |
| `~/Documents/lora_training/Loras/project_name/dataset` | `/content/drive/MyDrive/Loras/project_name/dataset` |

## Running the Notebook

1. In the notebook, set your `project_name` to match your dataset folder
2. Choose folder structure: "Organize by project"
3. Run the cells as you would in Colab
4. Your trained Loras will be saved to: `~/Documents/lora_training/Loras/project_name/output/`

## Stopping the Environment

Press `Ctrl+C` in the terminal where you ran `./run-local.sh`

Or run:
```bash
docker-compose down
```

## Troubleshooting

### Docker not found
```bash
# Make sure Docker Desktop is running
open -a Docker
```

### Permission denied on run-local.sh
```bash
chmod +x run-local.sh
```

### Out of memory
Increase Docker's memory limit in Docker Desktop preferences:
- Docker Desktop → Settings → Resources → Memory
- Recommended: 8GB or more

### GPU not detected
Mac doesn't have NVIDIA GPUs. Training will use CPU, which is slower.
For GPU acceleration on Mac M1/M2, you'd need a different setup with PyTorch MPS backend.

## Notes

- The first build will take ~10-15 minutes to download everything
- Subsequent starts will be much faster
- All your data persists in `~/Documents/lora_training/`
- The notebook runs exactly like in Colab, including the rex steps fix
