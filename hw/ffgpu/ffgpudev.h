#ifndef __FFGPUDEV_H__
#define __FFGPUDEV_H__

#include "hw/pci/pci.h"
#include "hw/pci/msi.h"

typedef struct {
    PCIDevice pdev;
    MemoryRegion mmio;

} FFGPUState;





#endif  /* __FFGPUDEV_H__ */
