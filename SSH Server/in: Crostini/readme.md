sch: https://www.google.com/search?q=chromebook+crostini+ssh+server, https://www.google.com/search?q=Chromebook+crostini+ssh+server+not+working

# source:
- [Setting up ssh-agent in Linux/Crostini on Chromebook](https://gist.github.com/parsley42/f1871360204bb55c3d69f10ec05f5cee)

Works:
- https://www.reddit.com/r/Crostini/comments/qtk3bm/run_ssh_server_on_chromebook/

```
# Inside of Linux container:

# first set passwords:
sudo su
passwd
passwd <user>
# remove file
sudo rm /etc/ssh/sshd_not_meant_to_be_run
ensure these lines are activated in the server config file /etc/ssh/sshd_config:
AllowAgentForwarding yes
AllowTcpForwarding yes
Port 1088 # (arbitrary, anything above 1024, port 22 and 2222 are banned for ssh)
# => In Chrome OS settings add port 1088 (Linux forwarding) and activate it
sudo systemctl start ssh
sudo systemctl enable ssh

# maybe restart and connect from outside machine:
ssh -p 1088 <user>@<chromeOS-IP\_notLinuxContainerIP>
# The IP address is not the IP of the container but of the Chromebook, like f.i.
ssh -p 1088 jo@192.168.100.5
```

# Discuss:
- https://superuser.com/questions/1713532/ssh-into-chromebook
