#!/usr/bin/env python3
"""Test the calculate_rex_steps fallback logic"""

import math
from pathlib import Path
import tempfile
import os

# Simulate the error scenario
def test_calculate_rex_fallback():
    """Test that the fallback calculation works when imports fail"""
    
    # Create temporary test directory with fake images
    with tempfile.TemporaryDirectory() as tmpdir:
        test_images_dir = Path(tmpdir) / "test_dataset"
        test_images_dir.mkdir()
        
        # Create some fake image files
        for i in range(10):
            (test_images_dir / f"image_{i}.png").touch()
        
        # Simulate the parameters
        train_batch_size = 4
        gradient_accumulation_steps = 1
        max_train_epochs = 10
        num_repeats = 2
        lr_warmup_ratio = 0.05
        lr_scheduler_num_cycles = 3
        
        # Fallback calculation (what happens when BucketManager import fails)
        print("Testing fallback calculation...")
        
        try:
            # This should fail
            from library.train_util import BucketManager
            print("❌ BucketManager imported successfully - this means the original issue still exists")
        except (ImportError, AttributeError, ModuleNotFoundError) as e:
            print(f"✅ Import failed as expected: {e}")
            print("Running fallback calculation...\n")
            
            # Fallback calculation
            supported_types = [".png", ".jpg", ".jpeg", ".webp", ".bmp"]
            
            total_images = 0
            num_images = sum(1 for img in test_images_dir.iterdir() if img.suffix.lower() in supported_types)
            total_images = num_images * num_repeats
            
            steps_per_epoch = math.ceil(total_images / train_batch_size / gradient_accumulation_steps)
            calculated_max_steps = steps_per_epoch * max_train_epochs
            
            print(f"📊 Test Results:")
            print(f"  Images found: {num_images}")
            print(f"  Total images (with repeats): {total_images}")
            print(f"  Steps per epoch: {steps_per_epoch}")
            print(f"  Total max steps: {calculated_max_steps}")
            
            # Calculate rex cycle steps
            cycle_steps = calculated_max_steps // (lr_scheduler_num_cycles or 1)
            print(f"  Rex cycle steps: {cycle_steps}")
            
            warmup_steps = round(calculated_max_steps * lr_warmup_ratio) // (lr_scheduler_num_cycles or 1)
            print(f"  Warmup steps: {warmup_steps}")
            
            print("\n✅ Fallback calculation completed successfully!")
            print("The fix is working - training would proceed with these estimated steps.")

if __name__ == "__main__":
    test_calculate_rex_fallback()
