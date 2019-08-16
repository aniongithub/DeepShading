# So we can easily switch the base image we use
ARG BASE_IMAGE=tensorflow/tensorflow
from $BASE_IMAGE

# To prevent messages like "debconf: unable to initialize frontend"
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
	apt-get -y --no-install-recommends install \
    apt-utils apt-transport-https software-properties-common \
    wget

# Install pip3 and python3
RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -sf /usr/bin/python3 python \
  && pip3 install --upgrade pip

RUN alias python=python3
RUN alias pip=pip3

# install keras and other packages we care about
RUN apt-get update && apt-get install -y libhdf5-dev libhdf5-serial-dev openexr libopenexr-dev python-opencv
RUN pip install keras h5py pyexr