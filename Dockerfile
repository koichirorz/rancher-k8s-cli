FROM bitnami/kubectl:1.19 AS k8scli

FROM rancher/cli:latest

COPY --from=k8scli /opt/bitnami/kubectl /usr/local/bin

ENTRYPOINT []
