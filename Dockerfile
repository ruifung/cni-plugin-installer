FROM --platform=$BUILDPLATFORM alpine AS build
ARG version=v1.1.1
ARG TARGETPLATFORM
WORKDIR /cni-plugins
COPY download-cni-plugins.sh download-cni-plugins.sh
RUN chmod a+x download-cni-plugins.sh && ./download-cni-plugins.sh && rm download-cni-plugins.sh

FROM busybox:1.36.0-musl
LABEL org.opencontainers.image.source https://github.com/ruifung/cni-plugin-installer
WORKDIR /opt/cni/bin/
VOLUME [ "/host/opt/cni/bin/" ]
COPY install-cni-plugins.sh /install-cni-plugins.sh
RUN chmod a+x /install-cni-plugins.sh
COPY --from=build /cni-plugins/* /opt/cni/bin/

ENTRYPOINT [ "/bin/sh", "/install-cni-plugins.sh" ]
