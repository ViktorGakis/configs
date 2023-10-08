#!/bin/bash
conda_path=$(echo $PATH | tr ':' '\n' | grep -E "/miniconda3|/anaconda3" | head -n 1)
echo conda_path: $conda_path
