wsl.exe sudo /etc/init.d/ssh start
$wsl_ip = (wsl hostname -I).trim().Split(" ")[0]
Write-Host "WSL Machine IP: ""$wsl_ip"""

netsh int portproxy reset all
netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=2222 connectport=22 connectaddress=$wsl_ip
netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=3000 connectport=3000 connectaddress=$wsl_ip
netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=22222 connectport=22222 connectaddress=$wsl_ip

#for ($i=60000; $i -le 60010; $i++)
#{
#	netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=$i connectport=$i connectaddress=$wsl_ip
#}

wsl.exe ~/bin/docker-service
