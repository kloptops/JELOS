# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="mame"
PKG_VERSION="b8cd169fab8dec3e61f81c9f2df529ac2afe729e"
PKG_SHA256="f65301ad01293998e031326a7555a20c67ed3335f84c8a69a64d8598a95d4352"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame"
PKG_URL="https://github.com/libretro/mame/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib flac sqlite expat"
PKG_SECTION="libretro"
PKG_SHORTDESC="MAME - Multiple Arcade Machine Emulator"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="-lto"


PKG_MAKE_OPTS_TARGET="REGENIE=1 \
		      VERBOSE=1 \
		      NOWERROR=1 \
		      OPENMP=1 \
		      CROSS_BUILD=1 \
		      TOOLS=0 \
		      RETRO=1 \
		      PTR64=0 \
		      NOASM=0 \
		      PYTHON_EXECUTABLE=python3 \
		      CONFIG=libretro \
		      LIBRETRO_OS=unix \
		      LIBRETRO_CPU= \
		      PLATFORM=arm64 \
		      ARCH= \
		      TARGET=mame \
		      SUBTARGET=mame \
		      OSD=retro \
		      USE_SYSTEM_LIB_EXPAT=1 \
		      USE_SYSTEM_LIB_ZLIB=1 \
		      USE_SYSTEM_LIB_FLAC=1 \
		      USE_SYSTEM_LIB_SQLITE3=1"

pre_configure_target() {
  sed -i "s/-static-libstdc++//g" scripts/genie.lua
}

make_target() {
  unset ARCH
  unset DISTRO
  unset PROJECT
  export ARCHOPTS="-D__aarch64__ -DASMJIT_BUILD_X86"
  make $PKG_MAKE_OPTS_TARGET OVERRIDE_CC=$CC OVERRIDE_CXX=$CXX OVERRIDE_LD=$LD AR=$AR $MAKEFLAGS
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp *.so $INSTALL/usr/lib/libretro/mame_libretro.so
  mkdir -p $INSTALL/usr/config/retroarch/savefiles/mame/hi
  cp plugins/hiscore/hiscore.dat $INSTALL/usr/config/retroarch/savefiles/mame/hi
}
