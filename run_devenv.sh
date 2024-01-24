mkdir -p /home/bjlkeng/.vscode-server-devenv

# Needed to enable profiling in docker container
# echo 1 | sudo tee /proc/sys/kernel/perf_event_paranoid

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
    --privileged \
    devenv

# Notes
# --privileged needed to enabling profiling in Docker container
