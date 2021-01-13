#ifndef __DBUSIF_H__
#define __DBUSIF_H__

#include "ffgpudev.h"
#include "qemu-intf.h"
#include "fmod-intf.h"

#define FFGPU_QEMU_DBUS_NAME "org.ffgpu.qemu"
#define FFGPU_FMOD_DBUS_NAME "org.ffgpu.fmod"

void init_dbus_intf(FFGPUState *ffgpu);
void deinit_dbus_intf(FFGPUState *ffgpu);

#endif /* __DBUSIF_H__ */
