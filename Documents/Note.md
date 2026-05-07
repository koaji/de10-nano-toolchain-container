# 困った点

## u-bootビルド
### openssl/evp.hがない。
makeを実行すると、下記エラーが出力された。
```
In file included from tools/imagetool.h:24,
                 from tools/aisimage.c:7:
include/image.h:1476:12: fatal error: openssl/evp.h: No such file or directory
 1476 | #  include <openssl/evp.h>
      |            ^~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.host:114: tools/aisimage.o] Error 1
make[1]: *** Waiting for unfinished jobs....
In file included from tools/imagetool.h:24,
                 from tools/atmelimage.c:7:
include/image.h:1476:12: fatal error: openssl/evp.h: No such file or directory
 1476 | #  include <openssl/evp.h>
      |            ^~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.host:114: tools/atmelimage.o] Error 1
In file included from tools/imagetool.h:24,
                 from tools/fit_common.c:20:
include/image.h:1476:12: fatal error: openssl/evp.h: No such file or directory
 1476 | #  include <openssl/evp.h>
      |            ^~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.host:114: tools/fit_common.o] Error 1
In file included from tools/imagetool.h:24,
                 from tools/fit_image.c:16:
include/image.h:1476:12: fatal error: openssl/evp.h: No such file or directory
 1476 | #  include <openssl/evp.h>
      |            ^~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.host:114: tools/fit_image.o] Error 1
```

対処は、コンテナイメージに`libssl-dev`を入れることで解決した。
(クロスツールのライブラリに入れるべき内容なのか気になるところ)
```
apt install libssl-dev
```

### bcコマンドがない
makeをすると、下記エラーログが出力された。
```
  LD      spl/u-boot-spl
  OBJCOPY spl/u-boot-spl-nodtb.bin
/bin/sh: 1: bc: not found
  SYM     spl/u-boot-spl.sym
make[1]: *** [scripts/Makefile.xpl:345: spl/u-boot-spl-pad.bin] Error 1
```
対処は、コンテナイメージに`bc`を入れることで解決した。
```
apt install bc
```