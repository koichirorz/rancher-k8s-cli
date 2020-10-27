FROM bitnami/kubectl:1.19 AS k8scli

FROM centos:centos7 AS ranchercli
# docker build --no-cache --build-arg RANCHER_VERSION=${tag} -t ${image}:${tag} .
ARG RANCHER_VERSION=2.4.6

RUN curl -LO "https://github.com/rancher/cli/releases/download/v${RANCHER_VERSION}/rancher-linux-amd64-v${RANCHER_VERSION}.tar.gz"
RUN tar axvf rancher-linux-amd64-v${RANCHER_VERSION}.tar.gz
RUN mv rancher-v${RANCHER_VERSION}/rancher /usr/local/bin
RUN chmod +x /usr/local/bin/rancher

FROM centos:centos7 AS final
COPY --from=ranchercli /usr/local/bin/rancher /usr/local/bin/rancher
COPY --from=k8scli /opt/bitnami/kubectl/bin /usr/local/bin
ENTRYPOINT []