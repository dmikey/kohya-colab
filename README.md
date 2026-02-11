# Kohya LoRA Trainer

An accessible Google Colab notebook for Stable Diffusion LoRA training. This is a streamlined, all-in-one version by [dmikey](https://github.com/dmikey), based on the work of [Hollowstrawberry](https://github.com/hollowstrawberry/kohya-colab), [Kohya-ss](https://github.com/kohya-ss/sd-scripts), and [Linaqruf](https://github.com/Linaqruf/kohya-trainer).

> **Note:** This trainer focuses on **Stable Diffusion 1.5** support. SDXL and other model architectures are not currently supported due to time constraints.

## 📓 Notebook

| |Colab|
|:--|:-:|
| ⭐ **LoRA Trainer v2.0** | [![Open in Colab](https://raw.githubusercontent.com/dmikey/kohya-colab/main/assets/colab-badge.svg)](https://colab.research.google.com/github/dmikey/kohya-colab/blob/main/Lora_Trainer.ipynb) |

## ✨ Features

* **All-in-One** - Single cell execution: install dependencies, configure, and train
* **Auto-Train Mode** - Automatically discover and train multiple projects in your workspace
* **Smart Repeats** - Auto-calculate optimal repeats based on target iterations and image count
* **Auto-Disconnect** - Optionally disconnect Colab runtime when training completes (saves compute units)
* **One-Click Training** - No complex setup required, just configure and run
* **Multiple Models** - Support for Anime, AnyLoRA, and Stable Diffusion 1.5 base models
* **Smart Fallbacks** - Automatically handles missing dependencies (xformers, bitsandbytes)
* **Flexible Optimizers** - AdamW, AdamW8bit, Prodigy, DAdaptation, Lion, and more
* **LoRA & LoCon** - Train both LoRA and LoCon network types
* **Google Drive Integration** - Saves directly to your Google Drive
* **Clean Output** - Filters non-critical warnings for better readability
* **Modern Tech Stack** - Uses latest kohya-ss scripts with xformers acceleration

## 🚀 Quick Start

### Single Project Training

1. **Open the notebook** in Google Colab using the badge above
2. **Configure your training** parameters in the cell:
   - Set your project name
   - Choose your base model (Anime, AnyLoRA, or SD 1.5)
   - Adjust training steps, learning rates, and network settings
3. **Run the cell** - Everything installs and trains automatically
4. **Download your LoRA** from Google Drive when complete

### Auto-Train Mode (Multiple Projects)

Train multiple LoRA projects in one run:

1. **Organize your workspace** with multiple project folders
   - For "Organize by project": `MyDrive/Loras/project1/dataset/`, `MyDrive/Loras/project2/dataset/`, etc.
   - For "Organize by category": `MyDrive/lora_training/datasets/project1/`, etc.
2. **Enable auto_train** checkbox in the notebook
3. **Run the cell** - The notebook will:
   - Automatically discover all projects with valid datasets
   - Train each project sequentially
   - Skip projects with errors and continue to the next
   - Save each LoRA to its respective output folder

**Tip**: Enable `auto_num_repeats` to automatically calculate optimal repeat values based on each project's image count.

## ⚙️ Configuration Options

### Setup
- **project_name**: Name of your LoRA project (must match folder name)
- **auto_train**: Enable to automatically train all projects in workspace (discovers folders with datasets)
- **auto_disconnect**: Automatically disconnect Colab runtime when training completes (saves compute units)
- **folder_structure**: Choose between project-organized or category-organized folder layouts
- **training_model**: Select base model (Anime, AnyLoRA, or SD 1.5)
- **optional_custom_training_model_url**: Use a custom model from a URL

### Processing
- **resolution**: Training resolution 512-1024px (default: 512)
- **flip_aug**: Enable horizontal flip augmentation for more variety
- **shuffle_tags**: Randomize tag order in captions (helps prevent overfitting)
- **activation_tags**: Number of tags to keep at the start (won't be shuffled)

### Steps
- **num_repeats**: How many times each image is seen per epoch (manual)
- **auto_num_repeats**: Auto-calculate repeats based on target iterations
- **target_iterations**: Desired total training iterations (used when auto_num_repeats enabled)
- **preferred_unit**: Train by Epochs or Steps
- **how_many**: Number of epochs or steps to train
- **save_every_n_epochs**: Save checkpoint frequency
- **keep_only_last_n_epochs**: How many checkpoints to keep (saves space)
- **train_batch_size**: Images per training step (1-8, higher = faster but more VRAM)

### Learning
- **unet_lr**: UNet learning rate (default: 5e-4, controls image generation)
- **text_encoder_lr**: Text encoder learning rate (default: 1e-4, controls text understanding)
- **lr_scheduler**: Learning rate schedule strategy
- **lr_scheduler_number**: Cycles (cosine_with_restarts) or power (polynomial)
- **lr_warmup_ratio**: Gradual learning rate warmup (prevents early overfitting)
- **min_snr_gamma**: Improves training stability (recommended: enabled)

### Structure
- **lora_type**: LoRA (standard) or LoCon (includes convolution layers)
- **network_dim**: LoRA rank/dimension (1-128, higher = more detail but larger file)
- **network_alpha**: LoRA alpha (affects learning strength, typically dim/2)
- **conv_dim**: Convolution dimension (LoCon only)
- **conv_alpha**: Convolution alpha (LoCon only)

### Optimizer
- **AdamW8bit**: Memory-efficient AdamW (recommended for most)
- **Prodigy**: Auto-adjusting learning rate optimizer
- **DAdaptation**: Another auto-LR optimizer
- **AdamW**: Standard AdamW (more VRAM)
- **Lion**: Alternative optimizer with different characteristics
- **SGDNesterov**: Classic optimizer with momentum

## 💡 Tips & Best Practices

### Auto-Calculate Repeats
When `auto_num_repeats` is enabled, the trainer calculates: 
```
num_repeats = round(target_iterations / number_of_images)
```

This ensures consistent training across projects with different image counts:
- 20 images + 200 iterations = 10 repeats
- 50 images + 200 iterations = 4 repeats
- 100 images + 200 iterations = 2 repeats

### Recommended Settings by Use Case

**Character LoRA (15-30 images)**
- Resolution: 512-768
- Network dim: 16-32
- Target iterations: 200-300 (if using auto_num_repeats)
- Learning rate: 5e-4 (UNet), 1e-4 (Text Encoder)

**Style LoRA (30-100 images)**
- Resolution: 512-768
- Network dim: 16-24
- Target iterations: 300-400 (if using auto_num_repeats)
- Learning rate: 3e-4 (UNet), 5e-5 (Text Encoder)

**Concept LoRA (50+ images)**
- Resolution: 512-768
- Network dim: 8-16
- Target iterations: 200-300 (if using auto_num_repeats)
- Learning rate: 5e-4 (UNet), 1e-4 (Text Encoder)

### Auto-Train Considerations
- All projects use the same training parameters (resolution, learning rates, etc.)
- Each project's repeats are calculated independently when `auto_num_repeats` is enabled
- Failed projects are skipped automatically, allowing the batch to complete
- Logs and outputs are saved per-project for easy review

## 📚 Resources

- **LoRA Making Guide**: [Civitai Guide](https://civitai.com/models/22530)
- **Stable Diffusion Guide**: [Hollowstrawberry's Guide](https://huggingface.co/hollowstrawberry/stable-diffusion-guide/blob/main/README.md#index)

## 🙏 Credits

This project builds upon the excellent work of:
- [Hollowstrawberry](https://github.com/hollowstrawberry/kohya-colab) - Original simplified colab implementation
- [Kohya-ss](https://github.com/kohya-ss/sd-scripts) - Core training scripts
- [Linaqruf](https://github.com/Linaqruf/kohya-trainer) - Additional colab innovations

## 📝 Version

**Version 2.0** - All-in-One Edition (February 2026)

Combines installation, configuration, and training into a single streamlined cell with improved error handling and automatic fallbacks.
