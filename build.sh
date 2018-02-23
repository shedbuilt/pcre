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
make -j $SHED_NUMJOBS && \
make DESTDIR="$SHED_FAKEROOT" install || exit 1
mkdir -v "${SHED_FAKEROOT}/lib"
mv -v "${SHED_FAKEROOT}"/usr/lib/libpcre.so.* "${SHED_FAKEROOT}/lib"
ln -sfv ../../lib/$(readlink "${SHED_FAKEROOT}"/usr/lib/libpcre.so) "${SHED_FAKEROOT}/usr/lib/libpcre.so"
