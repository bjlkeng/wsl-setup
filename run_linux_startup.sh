echo "Running graphana and prometheus..."

# ln -s $(readlink -f prometheus-grafana) ~/prometheus-grafana
mkdir -p ~/prometheus-grafana/grafana/grafana.volume
chmod 777 ~/prometheus-grafana/grafana/grafana.volume
mkdir -p ~/prometheus-grafana/prometheus/prometheus.volume
chmod 777 ~/prometheus-grafana/prometheus/prometheus.volume

cd ~/prometheus-grafana/ && docker compose up -d

echo "Running devenv..."
~/devel/wsl-setup/run_devenv.sh
