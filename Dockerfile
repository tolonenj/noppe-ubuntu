FROM ubuntu:24.04

COPY --chmod=500 ./install_ubuntu.sh /install_ubuntu.sh
RUN /install_ubuntu.sh
RUN rm /install_ubuntu.sh

COPY --chmod=500 ./init /init

EXPOSE 8787

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/init"]
