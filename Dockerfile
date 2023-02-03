FROM dorowu/ubuntu-desktop-lxde-vnc:bionic
LABEL maintainer="Tiryoh<tiryoh@gmail.com>"

RUN apt-get update  
RUN apt-get upgrade -y  
RUN apt-get install -y wget curl git build-essential vim sudo lsb-release locales bash-completion tzdata gosu python2.7 python-pip python3.7 python3-pip 
RUN rm -rf /var/lib/apt/lists/*
RUN useradd --create-home --home-dir /home/ubuntu --shell /bin/bash --user-group --groups adm,sudo ubuntu && \
    echo ubuntu:ubuntu | chpasswd && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN git clone https://github.com/Tiryoh/ros_setup_scripts_ubuntu.git /tmp/ros_setup_scripts_ubuntu && \
    gosu ubuntu /tmp/ros_setup_scripts_ubuntu/ros-melodic-desktop.sh && \
    rm -rf /var/lib/apt/lists/*
#COPY ros_setup_scripts /tmp/ros_setup_scripts
#RUN sudo chmod u+x ros-melodic-desktop-main.sh
#RUN ./ros-melodic-desktop-main.sh 
#RUN gosu ubuntu /tmp/ros_setup_scripts/ros-melodic-desktop.sh
#RUN rm -rf /var/lib/apt/lists/*
#RUN apt-get install python2.7 python-pip python3.6 python3-pip
COPY requirements_py2.txt .
RUN pip install -r requirements_py2.txt
COPY requirements_py3.txt .
RUN pip3 install -r requirements_py3.txt

ENV USER ubuntu
