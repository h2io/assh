Include ~/.ssh/config

Host *
    ForwardAgent yes

Host r01 remote01
    HostName 10.10.0.11
    User $XUSER
Host r03 remote03
    HostName 10.10.2.11
    User $XUSER

Host az1 vdi
    HostName 10.100.0.11
    User root
Host az3
    HostName 10.10.2.11
    User $XUSER

Host sh1
    HostName 10.10.47.77
    User $XDEBUG
    ProxyJump r01,r03

Match exec "hostname | grep -qE '^.*remote0[13]$'"
    ProxyJump none
