## to make the dagger run in fedora

<https://docs.dagger.io/troubleshooting/#dagger-restarts-with-a-cni-setup-error>

```bash
modprobe iptable_nat # to load the module

# then only the dagger thing will work as the cni doesn't support nftables but only iptables (legacy)

rmmod iptable_nat # to unload the module
```
