#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}
SHED_PKG_LOCAL_DOCDIR="/usr/share/doc/${SHED_PKG_NAME}-${SHED_PKG_VERSION}"
# Configure
./configure --prefix=/usr                     \
            --docdir="$SHED_PKG_LOCAL_DOCDIR" \
            --enable-unicode-properties       \
            --enable-pcre16                   \
            --enable-pcre32                   \
            --enable-pcregrep-libz            \
            --enable-pcregrep-libbz2          \
            --enable-pcretest-libreadline     \
            --enable-jit                      \
            --disable-static &&
# Build and Install
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install &&
# Rearrange
mkdir -v "${SHED_FAKE_ROOT}/lib" &&
mv -v "${SHED_FAKE_ROOT}"/usr/lib/libpcre.so.* "${SHED_FAKE_ROOT}/lib" &&
ln -sfv ../../lib/$(readlink "${SHED_FAKE_ROOT}/usr/lib/libpcre.so") "${SHED_FAKE_ROOT}/usr/lib/libpcre.so" || exit 1
# Optionally Remove Documentation
if [ -z "${SHED_PKG_LOCAL_OPTIONS[docs]}" ]; then
    rm -rf "${SHED_FAKE_ROOT}/usr/share/doc"
fi
