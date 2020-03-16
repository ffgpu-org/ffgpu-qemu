#!/bin/bash -e

ffgpu_conf()
{
    OPTS=" --enable-gtk --enable-vte --enable-virtfs --enable-kvm --enable-ffgpu --with-ffgpu-fmod-xml=../ffgpu-fmod/org.ffgpu.fmod.xml "
    OPTS+=" --disable-user --disable-sdl --target-list=x86_64-softmmu "
    echo "configure with $OPTS"
    ./configure $OPTS
}

ffgpu_make()
{
    NCPU=`getconf _NPROCESSORS_CONF`
    make -j ${NCPU}
}

if [ $# -eq 0 ];then
    ffgpu_conf && ffgpu_make
else
    while getopts "cm" opts;do
	case "$opts" in
	    "c")
		ffgpu_conf
		;;
	    "m")
		ffgpu_make
		;;
	esac
    done
fi
