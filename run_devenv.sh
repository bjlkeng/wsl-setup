docker run -d \
    -v /home/bjlkeng/devel:/home/bjlkeng/devel \
    -v /home/bjlkeng/.ssh:/home/bjlkeng/.ssh \
    --rm \
    --hostname devenv \
    --net=host \
    --gpus all \
    --shm-size=1g \
    --ulimit memlock=-1 \
    --ulimit stack=67108864 \
    devenv
