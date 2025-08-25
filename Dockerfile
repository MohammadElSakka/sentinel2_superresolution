FROM python:3.10

RUN pip install cuda-python

RUN pip install "sentinel2_superresolution[gpu] @ git+https://github.com/Evoland-Land-Monitoring-Evolution/sentinel2_superresolution.git"

RUN pip uninstall -y onnxruntime-gpu
RUN pip install onnxruntime-gpu[cuda,cudnn]

ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:/usr/local/lib/python3.10/site-packages/nvidia/cublas/lib:/usr/local/lib/python3.10/site-packages/nvidia/cudnn/lib:/usr/local/lib/python3.10/site-packages/nvidia/cufft/lib:/usr/local/lib/python3.10/site-packages/nvidia/cuda_runtime/lib:/usr/local/lib/python3.10/site-packages/nvidia/nvjitlink/lib:/usr/local/lib/python3.10/site-packages/nvidia/cuda_nvrtc/lib:/usr/local/lib/python3.10/site-packages/nvidia/curand/lib"


WORKDIR /app
