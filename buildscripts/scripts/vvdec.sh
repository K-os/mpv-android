#!/bin/bash -e

. ../../include/path.sh

if [ "$1" == "build" ]; then
	true
elif [ "$1" == "clean" ]; then
	rm -rf _build$ndk_suffix
	exit 0
else
	exit 255
fi

#autoreconf -if

mkdir -p _build$ndk_suffix

extra=
[[ "$ndk_triple" == "i686"* ]] && extra="--disable-asm"

#../configure \
#	--host=$ndk_triple $extra \
#	--enable-shared --disable-static \


cmake \
-DCMAKE_TOOLCHAIN_FILE=$DIR/sdk/android-ndk-r23b/build/cmake/android.toolchain.cmake \
-DANDROID_ABI=$android_abi \
-DCMAKE_INSTALL_PREFIX="$prefix_dir" \
-S . -B _build$ndk_suffix -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=1

cmake --build _build$ndk_suffix -j
cmake --build _build$ndk_suffix --target install 

#make -j$cores
#make DESTDIR="$prefix_dir" install
