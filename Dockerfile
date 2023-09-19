FROM binhex/arch-base:latest
LABEL org.opencontainers.image.authors = "binhex"
LABEL org.opencontainers.image.source = "https://github.com/binhex/arch-int-vpn"

# additional files
##################

# add install bash script
ADD build/root/*.sh /root/

# add bash script to run openvpn
ADD run/root/*.sh /root/

# release tag name from buildx arg
ARG RELEASETAG

# arch from buildx --platform, e.g. amd64
ARG TARGETARCH

# add bash script to run privoxy
ADD run/nobody/*.sh /home/nobody/

# install app
#############

# make executable and run bash scripts to install app
RUN chmod +x /root/*.sh /home/nobody/*.sh && \
	/bin/bash /root/install.sh "${RELEASETAG}" "${TARGETARCH}"

# docker settings
#################

# expose port for privoxy
EXPOSE 8118
