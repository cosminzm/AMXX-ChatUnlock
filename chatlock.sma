#include <amxmodx>

#define PLUGIN "Chat Unlock"
#define VERSION "1.0"
#define AUTHOR "COSMIN"

new bool:g_has_chat[33]; // salveaza starea fiecarui jucator

public plugin_init() {
    register_plugin(PLUGIN, VERSION, AUTHOR)

    register_clcmd("say", "handle_say")
    register_clcmd("say_team", "handle_say_team")
}

public client_connect(id) {
    g_has_chat[id] = false
}

public client_disconnect(id) {
    g_has_chat[id] = false
}

public handle_say(id) {
    new args[192]
    read_args(args, charsmax(args))
    remove_quotes(args)

    if(equali(args, "/chat")) {
        g_has_chat[id] = true
        client_print(id, print_chat, "[Server] Chatul a fost activat pentru tine.")
        return PLUGIN_HANDLED
    }

    if(!g_has_chat[id]) {
        client_print(id, print_chat, "[Server] Chatul este blocat. Scrie /chat pentru a-l activa.")
        return PLUGIN_HANDLED
    }

    return PLUGIN_CONTINUE
}

public handle_say_team(id) {
    return handle_say(id)
}
