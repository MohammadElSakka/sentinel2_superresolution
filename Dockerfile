# -----------------------------------------------------------------------------
# Author: M. El Sakka
# Github: https://github.com/MohammadElSakka
# Date: 2025-08-25
# Description: Dockerfile for running Sentinel-2 super-resolution with CUDA,
#              ONNX Runtime GPU provider, and necessary environment setup.
# -----------------------------------------------------------------------------

FROM python:3.10

RUN pip install cuda-python

RUN pip install "sentinel2_superresolution[gpu] @ git+https://github.com/Evoland-Land-Monitoring-Evolution/sentinel2_superresolution.git"

# reference: https://onnxruntime.ai/docs/execution-providers/CUDA-ExecutionProvider.html#preload-dlls
# otherwise onnxruntime wouldn't find CUDAExecutionProvider

RUN pip uninstall -y onnxruntime-gpu
RUN pip install onnxruntime-gpu[cuda,cudnn]

# Done manually by listing all NVIDIA directories needed to add to the environment variables
# A smarter way to do it ?

ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:/usr/local/lib/python3.10/site-packages/nvidia/cublas/lib:/usr/local/lib/python3.10/site-packages/nvidia/cudnn/lib:/usr/local/lib/python3.10/site-packages/nvidia/cufft/lib:/usr/local/lib/python3.10/site-packages/nvidia/cuda_runtime/lib:/usr/local/lib/python3.10/site-packages/nvidia/nvjitlink/lib:/usr/local/lib/python3.10/site-packages/nvidia/cuda_nvrtc/lib:/usr/local/lib/python3.10/site-packages/nvidia/curand/lib"


WORKDIR /app
