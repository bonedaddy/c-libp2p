#include <stdio.h>
#include <unistd.h>
#include "libp2p/utils/vector.h"
#include "libp2p/net/server.h"

int main(int arg, char** argc) {
    printf("c-libp2p-test hello!\n");

    struct Libp2pVector *protocol_handlers = libp2p_utils_vector_new(3);
    libp2p_utils_vector_add(protocol_handlers, NULL);
    libp2p_net_server_start("127.0.0.1", 1234, protocol_handlers);

    sleep(50);
    libp2p_net_server_stop();
}