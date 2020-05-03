#include <stdio.h>
#include <unistd.h>
#include "libp2p/utils/vector.h"
#include "libp2p/net/server.h"

int main(int arg, char** argc) {
    const char *ip = "127.0.0.1";
    const int port  = 1234;

    printf("libp2p node start listening ip:%s, port:%d\n", ip, port);
    struct Libp2pVector *protocol_handlers = libp2p_utils_vector_new(3);
    libp2p_utils_vector_add(protocol_handlers, NULL);
    libp2p_net_server_start(ip, port, protocol_handlers);
    sleep(50);
    libp2p_net_server_stop();
    printf("libp2p node stop\n");
}