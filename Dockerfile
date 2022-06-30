FROM node:16.15

# Set bash as default shell
ENV SHELL=/bin/bash

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt update
RUN apt install python3 python3-venv python3-pip -y
RUN apt clean
RUN pip3 install numpy -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
RUN pip3 install matplotlib -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
#RUN pip3 install torchvision -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
RUN pip3 install seaborn -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
RUN pip3 install sklearn -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
RUN pip3 install ipykernel -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
RUN pip3 install jupytext -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
RUN pip3 purge

RUN useradd --create-home --no-log-init --shell /bin/bash coder
RUN adduser coder sudo
RUN echo 'coder:1q2w3e4r' | chpasswd
RUN usermod -u 1000 coder && usermod -G 1000 coder

USER coder
WORKDIR /home/coder

COPY . /home/coder/server
RUN cd /home/coder/server && yarn

ENTRYPOINT ["bash"]