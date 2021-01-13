#!/bin/bash -e

ffgpu_use_gitee_mirror()
{
    git config 'submodule.roms/seabios.url' https://gitee.com/ffgpu/seabios.git
    git config 'submodule.roms/SLOF.url' https://gitee.com/ffgpu/SLOF.git
    git config 'submodule.roms/ipxe.url' https://gitee.com/ffgpu/ipxe.git
    git config 'submodule.roms/openbios.url' https://gitee.com/ffgpu/openbios.git
    git config 'submodule.roms/qemu-palcode.url' https://gitee.com/ffgpu/qemu-palcode.git
    git config 'submodule.roms/sgabios.url' https://gitee.com/ffgpu/sgabios.git
    git config 'submodule.dtc.url' https://gitee.com/ffgpu/dtc.git
    git config 'submodule.roms/u-boot.url' https://gitee.com/ffgpu/u-boot.git
    git config 'submodule.roms/skiboot.url' https://gitee.com/ffgpu/skiboot.git
    git config 'submodule.roms/QemuMacDrivers.url' https://gitee.com/ffgpu/QemuMacDrivers.git
    git config 'submodule.ui/keycodemapdb.url' https://gitee.com/ffgpu/keycodemapdb.git
    git config 'submodule.capstone.url' https://gitee.com/ffgpu/capstone.git
    git config 'submodule.roms/seabios-hppa.url' https://gitee.com/ffgpu/seabios-hppa.git
    git config 'submodule.roms/u-boot-sam460ex.url' https://gitee.com/ffgpu/u-boot-sam460ex.git
    git config 'submodule.tests/fp/berkeley-testfloat-3.url' https://gitee.com/ffgpu/berkeley-testfloat-3.git
    git config 'submodule.tests/fp/berkeley-softfloat-3.url' https://gitee.com/ffgpu/berkeley-softfloat-3.git
    git config 'submodule.roms/edk2.url' https://gitee.com/ffgpu/edk2.git
    git config 'submodule.slirp.url' https://gitee.com/ffgpu/libslirp.git
    git config 'submodule.roms/opensbi.url' https://gitee.com/ffgpu/opensbi.git
    git config 'submodule.roms/qboot.url' https://gitee.com/ffgpu/qboot.git
    git config 'submodule.meson.url' https://gitee.com/ffgpu/meson.git
    git config 'submodule.roms/vbootrom.url' https://gitee.com/ffgpu/vbootrom.git

    git submodule update --init --force --progress

    git config --file .git/modules/roms/edk2/config 'submodule.CryptoPkg/Library/OpensslLib/openssl.url' https://gitee.com/ffgpu/openssl.git
    git config --file .git/modules/roms/edk2/config 'submodule.SoftFloat.url' https://gitee.com/ffgpu/github-berkeley-softfloat-3.git
    git config --file .git/modules/roms/edk2/config 'submodule.UnitTestFrameworkPkg/Library/CmockaLib/cmocka.url' https://gitee.com/ffgpu/cmocka.git
    git config --file .git/modules/roms/edk2/config 'submodule.MdeModulePkg/Universal/RegularExpressionDxe/oniguruma.url' https://gitee.com/ffgpu/oniguruma.git
    git config --file .git/modules/roms/edk2/config 'submodule.MdeModulePkg/Library/BrotliCustomDecompressLib/brotli.url' https://gitee.com/ffgpu/brotli.git
    git config --file .git/modules/roms/edk2/config 'submodule.BaseTools/Source/C/BrotliCompress/brotli.url' https://gitee.com/ffgpu/brotli.git

    git submodule update --init --force --progress

    git config --file .git/modules/roms/edk2/modules/BaseTools/Source/C/BrotliCompress/brotli/config 'submodule.research/esaxx.url' https://gitee.com/ffgpu/esaxx.git
    git config --file .git/modules/roms/edk2/modules/BaseTools/Source/C/BrotliCompress/brotli/config 'submodule.research/libdivsufsort.url' https://gitee.com/ffgpu/libdivsufsort.git

    git config --file .git/modules/roms/edk2/modules/CryptoPkg/Library/OpensslLib/openssl/config 'submodule.boringssl.url' https://gitee.com/ffgpu/boringssl.git
    git config --file .git/modules/roms/edk2/modules/CryptoPkg/Library/OpensslLib/openssl/config 'submodule.krb5.url' https://gitee.com/ffgpu/krb5.git
    git config --file .git/modules/roms/edk2/modules/CryptoPkg/Library/OpensslLib/openssl/config 'submodule.pyca.cryptography.url' https://gitee.com/ffgpu/cryptography.git
    git submodule update --init --recursive --progress
}

ffgpu_conf()
{
    rm -rf ./build && mkdir ./build
    OPTS=" --enable-gtk --enable-vte --enable-virtfs --enable-kvm --enable-ffgpu "
    OPTS+=" --disable-user --disable-sdl --target-list=x86_64-softmmu "
    echo "configure with $OPTS"
    (cd ./build && ../configure $OPTS)
}

ffgpu_make()
{
    NCPU=`getconf _NPROCESSORS_CONF`
    (cd ./build && make -j ${NCPU})
}

if [ $# -eq 0 ];then
    ffgpu_conf && ffgpu_make
else
    while getopts "cmp" opts;do
	case "$opts" in
	    "c")
		ffgpu_conf
                exit 0
		;;
	    "m")
		ffgpu_make
                exit 0
		;;
            "p")
                ffgpu_use_gitee_mirror
                exit 0
                ;;
	esac
    done
fi
