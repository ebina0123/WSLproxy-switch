#!/bin/sh

_PROXY=#yourhostproxy
_HOSTIP=#yourhostname

function set_proxy() {
    export http_proxy=$_PROXY
    export https_proxy=$_PROXY
    export ftp_proxy=$_PROXY
    
    git config --global http.proxy $_PROXY
    git config --global https.proxy $_PROXY
    git config --global url."https://".insteadOf git://
}

function unset_proxy() {
    unset http_proxy
    unset https_proxy
    unset ftp_proxy
    
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    git config --global --unset url."https://".insteadOf
}

function get_host() {
    echo `grep search /etc/resolv.conf | sed 's/search.//'`
}

echo `get_host`

if [ -z "`get_host`" ]; then
    echo -e "\e[36mUnset proxy settings\e[m"
    unset_proxy
elif [ `get_host` = $_HOSTIP ]; then
    echo -e "\e[32mSwitch to proxy\e[m" 
    set_proxy
else
    echo -e "\e[31mgrass\e[m"
fi
