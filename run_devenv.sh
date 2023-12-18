mkdir -p /home/bjlkeng/.vscode-server-devenv

docker run -d \
    -v /home/bjlkeng/devel:/home/bjlkeng/devel \
    -v /home/bjlkeng/.ssh:/home/bjlkeng/.ssh \
    -v /home/bjlkeng/.vscode-server-devenv:/home/bjlkeng/.vscode-server \
    --rm \
    --hostname devenv \
    --net=host \
    --gpus all \
    --shm-size=8g \
    --ulimit memlock=-1 \
    --ulimit stack=67108864 \
    devenv
