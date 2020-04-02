#include "dbusif.h"

static const gchar *qemu_dbus_name = NULL;
static const gchar *fmod_dbus_name = NULL;

static void on_name_acquired(GDBusConnection *connection, const gchar *name,
                             gpointer user_data) {
}

static void on_name_lost(GDBusConnection *connection, const gchar *name,
                         gpointer user_data) {
    if (!connection) {
        fprintf(stderr, "can't connect to dbus (session)\n");
    } else {
        fprintf(stderr, "qemu(%s) is already running\n", name);
    }
}

static void on_fmod_appeared(GDBusConnection *connection, const gchar *name,
                             const gchar *name_owner, gpointer user_data) {
    // FFGPUState *ffgpu = (FFGPUState *)user_data;
    fprintf(stderr, "%s is connected\n", name);
}

static void on_fmod_vanished(GDBusConnection *connection, const gchar *name,
                             gpointer user_data) {
    fprintf(stderr, "%s is disconnected\n", name);
}

void init_dbus_intf(FFGPUState *ffgpu) {
    GError *error = NULL;
    qemu_dbus_name =
        ffgpu->host_dbus_name ? ffgpu->host_dbus_name : FFGPU_QEMU_DBUS_NAME;
    fmod_dbus_name =
        ffgpu->fmod_dbus_name ? ffgpu->fmod_dbus_name : FFGPU_FMOD_DBUS_NAME;

    ffgpu->fmod_proxy = ffgpu_fmod_proxy_new_for_bus_sync(
        G_BUS_TYPE_SESSION, 0, fmod_dbus_name, "/", NULL, &error);
    if (error) {
        fprintf(stderr, "%s\n", error->message);
        g_error_free(error);
        error = NULL;
        ffgpu->fmod_proxy = NULL;
    }
    g_dbus_proxy_set_default_timeout(G_DBUS_PROXY(ffgpu->fmod_proxy), G_MAXINT);

    ffgpu->dbus_own_id = g_bus_own_name(
        G_BUS_TYPE_SESSION, qemu_dbus_name, G_BUS_NAME_OWNER_FLAGS_NONE, NULL,
        on_name_acquired, on_name_lost, ffgpu, NULL);

    ffgpu->dbus_watched_id = g_bus_watch_name(
        G_BUS_TYPE_SESSION, fmod_dbus_name, G_BUS_NAME_WATCHER_FLAGS_NONE,
        on_fmod_appeared, on_fmod_vanished, ffgpu, NULL);
}

void deinit_dbus_intf(FFGPUState *ffgpu) {
    g_bus_unown_name(ffgpu->dbus_own_id);
    g_bus_unwatch_name(ffgpu->dbus_watched_id);
}
