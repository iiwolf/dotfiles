#!/bin/bash
# install_libgl : 
git clone https://github.com/libigl/libigl.git $PROGRAMS/libigl \
    && cd $PROGRAMS/libigl \
    && mkdir build \
    && cd build \
    && cmake \
        -D CMAKE_BUILD_TYPE=Release \
        -D LIBIGL_EXPORT_TARGETS=ON \
        -D LIBIGL_WITHOUT_COPYLEFT=ON \
        -D LIBIGL_USE_STATIC_LIBRARY=OFF \
        ../ \
    && make -j$(nproc) install