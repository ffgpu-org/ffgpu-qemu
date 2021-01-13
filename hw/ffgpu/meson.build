qemu_intf_outputs=['qemu-intf.h', 'qemu-intf.c']
fmod_intf_outputs=['fmod-intf.h', 'fmod-intf.c']

qemu_intf_files = custom_target('QEMU DBus Interface files',
                                output: qemu_intf_outputs,
                                input: [ files('org.ffgpu.qemu.xml') ],
                                command: [ config_host['GDBUS_CODEGEN'],
                                           '--output-directory', '@OUTDIR@',
                                           '--generate-c-code', 'qemu-intf',
                                           '--c-namespace', 'ffgpu',
                                           '--interface-prefix', 'org.ffgpu',
                                           '@INPUT0@' ],
                                depend_files: [ 'org.ffgpu.qemu.xml' ])

fmod_intf_files = custom_target('FMOD DBus Interface files',
                                output: fmod_intf_outputs,
                                input: [ files('org.ffgpu.fmod.xml') ],
                                command: [ config_host['GDBUS_CODEGEN'],
                                           '--output-directory', '@OUTDIR@',
                                           '--generate-c-code', 'fmod-intf',
                                           '--c-namespace', 'ffgpu',
                                           '--interface-prefix', 'org.ffgpu',
                                           '@INPUT0@' ],
                                depend_files: [ 'org.ffgpu.fmod.xml' ])

specific_ss.add(when: 'CONFIG_FFGPU', if_true: [files('ffgpudev.h', 'dbusif.h',
                                                      'ffgpudev.c', 'dbusif.c'),
                                                qemu_intf_files,
                                                fmod_intf_files,
                                                gio])
