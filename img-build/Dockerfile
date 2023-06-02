FROM docker.io/opensciencegrid/xrootd-standalone:3.6-release
COPY ./init-xrd.sh /usr/local/bin/entrypoint.sh
RUN groupadd -g 8666 gm2cornell && groupadd -g 9950 gm2 && usermod -aG gm2cornell xrootd && usermod -aG gm2 xrootd
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
