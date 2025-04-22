FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    build-essential libreadline-dev libssl-dev

COPY vpnserver /vpnserver

WORKDIR /vpnserver

RUN make i_read_and_agree_the_license_agreement && \
    mv /vpnserver /usr/local/ && \
    ln -s /usr/local/vpnserver/vpnserver /usr/bin/vpnserver && \
    ln -s /usr/local/vpnserver/vpncmd /usr/bin/vpncmd

EXPOSE 443/tcp 992/tcp 1194/udp 5555/tcp

CMD ["/usr/local/vpnserver/vpnserver", "start"]
