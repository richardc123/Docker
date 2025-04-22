FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    build-essential wget libreadline-dev libssl-dev \
    && wget https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases/download/v4.43-9799/softether-vpnserver-v4.43-9799-rtm-2023.12.27-linux-x64-64bit.tar.gz \
    && tar xzf softether-vpnserver-*.tar.gz \
    && cd vpnserver && make i_read_and_agree_the_license_agreement \
    && mv vpnserver /usr/local/ \
    && ln -s /usr/local/vpnserver/vpnserver /usr/bin/vpnserver \
    && ln -s /usr/local/vpnserver/vpncmd /usr/bin/vpncmd

EXPOSE 443/tcp 992/tcp 1194/udp 5555/tcp

CMD ["/usr/local/vpnserver/vpnserver", "start"]
