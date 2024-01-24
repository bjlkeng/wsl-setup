# wsl-setup

Some rough notes on how I setup my WSL desktop box (Windows 11).  My setup is
that I do all my work on my main computer (Macbook Pro), and just ssh into my
WSL desktop box to do any development.  I can directly use the Windows box
using the other input on my monitor and a USB switch but it's a hassle, and I
usually only do that for games.  Otherwise, it's basically a headless server
for me.


## Notes

* Install Nvidia graphics driver (make sure it matches your PyTorch version)
* Followed standard instructions for installing WSL
* Followed standard instructions for installing CUDA (I think you can skip this step if you're using a docker container):
  https://docs.nvidia.com/cuda/wsl-user-guide/index.html
* Manually run `start_ssh.ps1` script once your computer boots up (couldn't quite figure
  out how to get it to run on boot, maybe it's because I don't have Windows 11
  Pro?).  Script does a few things:
    * Starts sshd on WSL on boot (ensure you have it installed on WSL)
    * Extract the IP address of the wsl (changes on each boot)
    * Proxies {ssh, Grafana} your public address (e.g. Wifi) to the wsl box
        * Add appropriate port forwarding
    * Starts up docker containers for Prometheus, Grafana and Node explorer, and then also runs [nvidia_gpu_exporter](https://github.com/utkuozdemir/nvidia_gpu_exporter)
* Need to open up ports on Windows firewall or you cannot make external connections (e.g. ssh)
* Make sure you disable Windows updates (for as long as you can) or else your
  machine will automatically restart (and you'll have to manually run the
  startup script again.

# Linux notes:

* nvidia_gpu_exporter:
    * Download the .deb package (Ubuntu): https://github.com/utkuozdemir/nvidia_gpu_exporter/releases
    * Install it `sudo dpkg -i nvidia-gpu-exporter_1.x.y_linux_amd64.deb`
        * See: https://github.com/utkuozdemir/nvidia_gpu_exporter/blob/master/INSTALL.md
* Things to install:
    * docker
    * mosh


## Setup Docker container

* Install docker on WSL2
* Compile docker container in the `gpu_docker` dir using `make`
    * The prepackaged Nvidia container should contain the right torch/CUDA versions
    * Just make sure the Windows driver will support it properly
* To enable profiling of GPU, make sure (in the Windows driver) to:
    * "Enable Developer Settings"
    * "Allow access to the GPU performance counters to all users"
    * See: 
        * https://developer.nvidia.com/nvidia-development-tools-solutions-err_nvgpuctrperm-permission-issue-performance-counters
        * https://github.com/pytorch/pytorch/issues/99615
* For Linux, install Nvidia container toolkit: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html

## TODO

* Couldn't get [mosh](https://mosh.org) working even with proxying ports and
  opening up the Windows firewall.  Not a big deal but annoying.
