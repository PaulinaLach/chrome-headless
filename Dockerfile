FROM debian:buster-slim

ARG CHROME_DEB=https://github.com/webnicer/chrome-downloads/raw/master/x64.deb/google-chrome-stable_87.0.4280.88-1_amd64.deb

RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	fontconfig \
	fonts-ipafont-gothic \
	fonts-wqy-zenhei \
	fonts-thai-tlwg \
	fonts-kacst \
	fonts-symbola \
	fonts-noto \
	fonts-freefont-ttf \
	--no-install-recommends \
    # chrome installation
    && curl -SL ${CHROME_DEB} -o /tmp/chrome.deb \
    && dpkg -i /tmp/chrome.deb; apt-get -fy install --no-install-recommends \
    && rm /tmp/chrome.deb \
    # cleanup apt & cache
	&& apt-get purge --auto-remove -y curl gnupg \
    && apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN groupadd -r chrome && useradd -r -g chrome -G audio,video chrome \
	&& mkdir -p /home/chrome && chown -R chrome:chrome /home/chrome \
    && chown -R chrome:chrome /opt/google/chrome
