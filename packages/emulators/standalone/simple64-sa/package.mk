# SPDX-License-Identifier: GPL-2.0-or-later

PKG_NAME="simple64-sa"
PKG_VERSION="7b51819"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/brooksytech/simple64"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="simple64 is an emulator based on a heavily modified version of mupen64plus-core, and ParaLLEl RSP/RDP"
PKG_TOOLCHAIN="manual"

make_target() {
cd ${PKG_BUILD}
  sh ./build.sh PLATFORM ="aarch64"

}

makeinstall_target() {
    mkdir -p ${INSTALL}/usr/bin
}
