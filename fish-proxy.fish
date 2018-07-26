#!/bin/env fish

set -x PROXY #your proxy
set -x HOSTIP #your hostname

function set_proxy #proxy下のの環境をexport
    set -xg http_proxy $PROXY
    set -xg https_proxy $PROXY
    set -xg ftp_proxy $PROXY
    
    git config --global http.proxy $PROXY
    git config --global https.proxy $PROXY
    git config --global url."https://".insteadOf git://
end

function unset_proxy #非proxy下の環境をexport
    set -e http_proxy
    set -e https_proxy
    set -e ftp_proxy
    
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    git config --global --unset url."https://".insteadOf
end

function get_host
    grep search /etc/resolv.conf | sed 's/search.//'
end

get_host

if test -z (get_host)
    echo -e "\e[36mUnset proxy settings\e[m"
    unset_proxy
else if test (get_host) = $HOSTIP
    echo -e "\e[32mSwitch to proxy\e[m" 
    set_proxy
else
    echo -e "\e[31munset proxy\e[m"
    unset_proxy
end

