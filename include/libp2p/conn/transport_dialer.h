#pragma once

#include "multiaddr/multiaddr.h"
#include "libp2p/net/stream.h"
#include "libp2p/utils/linked_list.h"

struct TransportDialer {
	char* peer_id;
	struct RsaPrivateKey* private_key;
	int (*can_handle)(const struct MultiAddress* multiaddr);
	struct Stream* (*dial)(const struct TransportDialer* transport_dialer, const struct MultiAddress* multiaddr);
};

struct TransportDialer* libp2p_conn_transport_dialer_new(char* peer_id, struct RsaPrivateKey* private_key);

void libp2p_conn_transport_dialer_free(struct TransportDialer* in);

int libp2p_conn_tcp_can_handle(const struct MultiAddress* addr);

struct Stream* libp2p_conn_tcp_dial(const struct TransportDialer* transport_dialer, const struct MultiAddress* addr);

struct TransportDialer* libp2p_conn_tcp_transport_dialer_new(char* peer_id, struct RsaPrivateKey* private_key);

struct Stream* libp2p_conn_transport_dialer_get(const struct Libp2pLinkedList* transport_dialers, const struct MultiAddress* multiaddr);
