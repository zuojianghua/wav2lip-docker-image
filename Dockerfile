FROM nvcr.io/nvidia/pytorch:22.11-py3
WORKDIR /workspace
USER root
EXPOSE 8800
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai
COPY ./requirements.txt /workspace
RUN apt-get update && apt-get upgrade -y && apt-get install git -y && apt-get install ffmpeg -y
RUN export FORCE_CUDA="1" && export TORCH_CUDA_ARCH_LIST="6.1;8.6" && pip install -r /workspace/requirements.txt
RUN git clone https://github.com/Rudrabha/Wav2Lip.git
RUN mv /workspace/Wav2Lip/* /workspace
RUN curl -o /workspace/face_detection/detection/sfd/s3fd.pth https://www.adrianbulat.com/downloads/python-fan/s3fd-619a316812.pth
RUN curl -o /workspace/wav2lip.pth https://iiitaphyd-my.sharepoint.com/personal/radrabha_m_research_iiit_ac_in/_layouts/15/download.aspx?SourceUrl=%2Fpersonal%2Fradrabha%5Fm%5Fresearch%5Fiiit%5Fac%5Fin%2FDocuments%2FWav2Lip%5FModels%2Fwav2lip%2Epth
# RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && pip install -r /workspace/requirements.txt
# RUN pip install git+https://github.com/openai/CLIP.git
# COPY ./app.py /workspace/app.py
ENTRYPOINT ["jupyter-lab","--no-browser","--allow-root","--port=8800","--ip=0.0.0.0","--ServerApp.token=123456"]
