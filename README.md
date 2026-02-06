# Kohya LoRA Trainer

An accessible Google Colab notebook for Stable Diffusion LoRA training. This is a streamlined, all-in-one version by [dmikey](https://github.com/dmikey), based on the work of [Hollowstrawberry](https://github.com/hollowstrawberry/kohya-colab), [Kohya-ss](https://github.com/kohya-ss/sd-scripts), and [Linaqruf](https://github.com/Linaqruf/kohya-trainer).

## 📓 Notebook

| |Colab|
|:--|:-:|
| ⭐ **LoRA Trainer v2.0** | [![Open in Colab](https://raw.githubusercontent.com/dmikey/kohya-colab/main/assets/colab-badge.svg)](https://colab.research.google.com/github/dmikey/kohya-colab/blob/main/Lora_Trainer.ipynb) |

## ✨ Features

* **All-in-One** - Single cell execution: install dependencies, configure, and train
* **One-Click Training** - No complex setup required, just configure and run
* **Multiple Models** - Support for Anime, AnyLoRA, and Stable Diffusion 1.5 base models
* **Smart Fallbacks** - Automatically handles missing dependencies (xformers, bitsandbytes)
* **Flexible Optimizers** - AdamW, AdamW8bit, Prodigy, DAdaptation, Lion, and more
* **LoRA & LoCon** - Train both LoRA and LoCon network types
* **Google Drive Integration** - Saves directly to your Google Drive
* **Clean Output** - Filters non-critical warnings for better readability
* **Modern Tech Stack** - Uses latest kohya-ss scripts with xformers acceleration

## 🚀 Quick Start

1. **Open the notebook** in Google Colab using the badge above
2. **Configure your training** parameters in the cell:
   - Set your project name
   - Choose your base model (Anime, AnyLoRA, or SD 1.5)
   - Adjust training steps, learning rates, and network settings
3. **Run the cell** - Everything installs and trains automatically
4. **Download your LoRA** from Google Drive when complete

## ⚙️ Configuration Options

### Training Parameters
- **Resolution**: 512-1024px (default: 512)
- **Epochs/Steps**: Choose your preferred unit and quantity
- **Batch Size**: 1-8 (default: 2)
- **Learning Rates**: Separate for UNet and Text Encoder
- **Optimizers**: AdamW8bit, Prodigy, DAdaptation, Lion, SGDNesterov

### Network Settings
- **LoRA Rank (network_dim)**: 1-128 (default: 16)
- **LoRA Alpha (network_alpha)**: 1-128 (default: 8)
- **Type**: LoRA or LoCon with configurable conv dimensions

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
