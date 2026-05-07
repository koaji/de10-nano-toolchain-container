# DE10-nano用toolchain付きコンテナ

## 概要
本コンテナは、Terasic社製FPGA開発ボード DE10-nano 向けのtoolchain付きコンテナである。
主に、u-bootのビルドに使用する。

## 各ファイルの説明

| ファイル名 | 説明 |
| --- | --- |
| build.sh | toolchainのダウンロード、展開およびコンテナイメージ作成を行うシェルスクリプト。ツールチェインは`/opt`にある。 |
| run.sh | コンテナイメージを実行するスクリプト。/rootがカレントディレクトリと共有される。 |

## 開発環境

開発環境は[SoftwareVersions.md](/Documents/SoftwareVersions.md)に記載する。

## 注意事項
toolchainを変更する際は、build.shの環境変数をメンテナンスすること。

本コンテナ作成する際に、困った点を[Note.md](/Documents/Note.md)に記載する。

## 参考サイト

- [de10-nano, SoCモジュールで遊ぶ [u-boot編-02]](https://note.com/shiny_godwit903/n/neb77fc6ceb85)
- [Arm GNU Toolchain Downloads](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads)
- [Ubuntu 20.04のdocker build時にタイムゾーン選択を求められた時の対処メモ](https://qiita.com/mochi_yu2/items/af80a3adc7ff70e58807)

