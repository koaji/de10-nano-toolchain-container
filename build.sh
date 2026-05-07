#!/bin/bash

# コンテナイメージ名を定義する
IMAGES_TAG_NAME="localhost/arm-none-linux-gnueabihf-crosstool:1.0"

# toolchainのダウンロードURLとファイル名、展開後のディレクトリ名を定義する
#
# Webサイトからダウンロードする場合は、下記URLにアクセスし、
# セクション"x86_64 Linux hosted cross toolchains"の"AArch32 GNU/Linux target with hard float (arm-none-linux-gnueabihf)"
# のリンクをクリックする
# https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads
#
TOOL_CHAIN_DOWNLOAD_URL="https://developer.arm.com/-/media/Files/downloads/gnu/15.2.rel1/binrel/arm-gnu-toolchain-15.2.rel1-x86_64-arm-none-linux-gnueabihf.tar.xz"
TOOL_CHAIN_DOWNLOAD_FILE_NAME="arm-gnu-toolchain-15.2.rel1-x86_64-arm-none-linux-gnueabihf.tar.xz"
TOOL_CHAIN_DIR_NAME="arm-gnu-toolchain-15.2.rel1-x86_64-arm-none-linux-gnueabihf"
CROSS_ARCHITECTURE="arm"
CROSS_COMPILE="arm-none-linux-gnueabihf"

# toolchainディレクトリを作成する
if [ ! -d "toolchain" ]; then
    mkdir toolchain
fi

# toolchainない場合はダウンロードする
if [ ! -f ./toolchain/${TOOL_CHAIN_DOWNLOAD_FILE_NAME} ]; then
    echo "Downloading ${TOOL_CHAIN_DOWNLOAD_FILE_NAME}..."
    curl -L --output ./toolchain/${TOOL_CHAIN_DOWNLOAD_FILE_NAME} ${TOOL_CHAIN_DOWNLOAD_URL}
fi

# toolchainを展開する
if [ ! -d "toolchain/${TOOL_CHAIN_DIR_NAME}" ]; then
    echo "Extracting ${TOOL_CHAIN_DOWNLOAD_FILE_NAME}..."
    tar -xf ./toolchain/${TOOL_CHAIN_DOWNLOAD_FILE_NAME} -C toolchain
fi

# コンテナイメージをビルドする
podman build -t ${IMAGES_TAG_NAME} \
    --build-arg CROSS_ARCHITECTURE=${CROSS_ARCHITECTURE} \
    --build-arg TOOL_CHAIN_DIR_NAME=${TOOL_CHAIN_DIR_NAME} \
    --build-arg CROSS_COMPILE=${CROSS_COMPILE} \
    .