# Usar a imagem base do Ubuntu 22.04
FROM ubuntu:22.04

# Instalar dependências necessárias
RUN apt-get update && apt-get install -y \
    build-essential wget libreadline-dev libssl-dev \
    && apt-get clean

# Definir o diretório onde os arquivos do SoftEther serão copiados
WORKDIR /opt

# Copiar os arquivos do SoftEther VPN Server para dentro do container
# Supondo que você tenha o arquivo tar.gz no mesmo diretório onde está o Dockerfile
COPY softether-vpnserver-v4.44-9807-rtm-2025.04.16-linux-arm64-64bit.tar /opt/

# Extrair os arquivos do SoftEther VPN Server
RUN tar xzf softether-vpnserver-*.tar.gz \
    && cd vpnserver && make i_read_and_agree_the_license_agreement \
    && mv vpnserver /usr/local/ \
    && ln -s /usr/local/vpnserver/vpnserver /usr/bin/vpnserver \
    && ln -s /usr/local/vpnserver/vpncmd /usr/bin/vpncmd

# Expor as portas necessárias para o SoftEther VPN Server
EXPOSE 443/tcp 992/tcp 1194/udp 5555/tcp

# Comando para iniciar o SoftEther VPN Server
CMD ["/usr/local/vpnserver/vpnserver", "start"]
