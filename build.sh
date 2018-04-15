#!/bin/bash
./configure --prefix=/usr                     \
            --docdir=/usr/share/doc/pcre-8.41 \
            --enable-unicode-properties       \
            --enable-pcre16                   \
            --enable-pcre32                   \
            --enable-pcregrep-libz            \
            --enable-pcregrep-libbz2          \
            --enable-pcretest-libreadline     \
            --enable-jit                      \
            --disable-static && \
make -j $SHED_NUM_JOBS && \
make DESTDIR="$SHED_FAKE_ROOT" install || exit 1
mkdir -v "${SHED_FAKE_ROOT}/lib"
mv -v "${SHED_FAKE_ROOT}"/usr/lib/libpcre.so.* "${SHED_FAKE_ROOT}/lib"
ln -sfv ../../lib/$(readlink "${SHED_FAKE_ROOT}"/usr/lib/libpcre.so) "${SHED_FAKE_ROOT}/usr/lib/libpcre.so"
