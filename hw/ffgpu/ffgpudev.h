#ifndef __FFGPUDEV_H__
#define __FFGPUDEV_H__

#include "qemu/osdep.h"
#include "hw/pci/pci.h"
#include "hw/pci/msi.h"
#include "qemu-intf.h"
#include "fmod-intf.h"

typedef struct {
    PCIDevice pdev;
    MemoryRegion mmio;
    QemuConsole *con;

    gchar *host_dbus_name;
    gchar *fmod_dbus_name;

    /* dbus interface */
    ffgpuFmod *fmod_proxy;
    guint dbus_own_id;
    guint dbus_watched_id;
} FFGPUState;





#endif  /* __FFGPUDEV_H__ */
