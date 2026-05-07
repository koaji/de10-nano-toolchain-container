FROM ubuntu:26.04

# タイムゾーン変更
ENV TZ=Asia/Tokyo

# apt用のタイムゾーン設定
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# パッケージの更新
RUN apt update && \
    apt upgrade -y && \
    apt install -y python-is-python3 \
                   make \ 
                   bison \
                   flex \
                   bc \
                   libssl-dev \
                   && \
    apt clean

# クロスツール関連の引数を定義する
ARG TOOL_CHAIN_DIR_NAME=""
ARG CROSS_ARCHITECTURE=""
ARG CROSS_COMPILE=""

# Toolchainのコピー(ホスト側で予めクロスツールを展開しておく)
RUN mkdir -p /opt/${TOOL_CHAIN_DIR_NAME}
COPY ./toolchain/${TOOL_CHAIN_DIR_NAME} /opt/${TOOL_CHAIN_DIR_NAME}

# クロスツール用の環境変数を設定する
ENV PATH=/opt/${TOOL_CHAIN_DIR_NAME}:$PATH
ENV ARCH=${CROSS_ARCHITECTURE}
ENV CROSS_COMPILE=${CROSS_COMPILE}-
ENV PATH="/opt/${TOOL_CHAIN_DIR_NAME}/bin:${PATH}"

CMD ["/bin/bash"]
