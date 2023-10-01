FROM nvcr.io/nvidia/pytorch:23.09-py3

RUN apt-get -y update
RUN apt-get -y install git openssh-server sudo

RUN useradd -m -d /home/bjlkeng -s /bin/bash -g root -G sudo -u 1000 bjlkeng
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN sed -i 's,.*Port.*,Port 22222,g' /etc/ssh/sshd_config
RUN sed -i 's,.*PasswordAuthentication.*,PasswordAuthentication no,g' /etc/ssh/sshd_config
RUN service ssh start

USER bjlkeng
WORKDIR /home/bjlkeng

RUN git clone https://github.com/bjlkeng/dotfiles.git
RUN pushd dotfiles && ./setup.sh && popd

# ENTRYPOINT sudo service ssh restart && /bin/bash
USER root
CMD ["/usr/sbin/sshd","-D"]

# Start container with something like this:
# docker run -d \
#     -v /home/bjlkeng/devel:/home/bjlkeng/devel \
#     -v /home/bjlkeng/.ssh:/home/bjlkeng/.ssh \
#     --rm \
#     --hostname devenv \
#     --net=host \
#     --gpus all \
#     --shm-size=1g \
#     --ulimit memlock=-1 \
#     --ulimit stack=67108864 \
#     devenv
