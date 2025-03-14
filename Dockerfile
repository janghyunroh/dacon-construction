# CUDA 12.2 기반 이미지 (runtime 버전)
FROM nvidia/cuda:12.2.0-runtime-ubuntu20.04

# 필수 패키지 설치
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    ca-certificates \
    git \
    && rm -rf /var/lib/apt/lists/*

# Miniconda 설치 (Anaconda를 원하면 변경 가능)
ENV CONDA_DIR=/opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh \
    && mkdir -p $CONDA_DIR \
    && bash /tmp/miniconda.sh -b -p $CONDA_DIR \
    && rm /tmp/miniconda.sh
ENV PATH=$CONDA_DIR/bin:$PATH

# Conda 기본 환경 설정
RUN conda create -y -n dev python=3.9 jupyter notebook \
    && echo "source activate dev" >> ~/.bashrc

# 작업 디렉토리 설정
WORKDIR /workspace

# Jupyter Notebook 포트 노출
EXPOSE 8888

# 컨테이너 실행 시 Jupyter Notebook 시작
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
