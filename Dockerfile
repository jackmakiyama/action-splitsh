FROM alpine:3.15

COPY root /root

RUN apk add --no-cache git git-lfs wget bash openssh tar && \
    git lfs install && \
    wget https://github.com/splitsh/lite/releases/download/v1.0.1/lite_linux_amd64.tar.gz && \
    tar -zxpf lite_linux_amd64.tar.gz --directory /usr/local/bin/ && \
    rm -rf /var/lib/apt/lists/* 


ENTRYPOINT ["/root/entrypoint.sh"]
