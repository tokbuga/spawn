import {
    ETHERTYPE_ETH,      ARP_REQUEST,    IHL_VERSION_4,      MAC_ALEN,
    ETHERTYPE_ARP,      ARP_REPLY,      IHL_VERSION_6,      IP4_ALEN,
    ETHERTYPE_WSC,                                          MAC_ATYPE,
                                                            IP4_ATYPE,

                                                            ADDR_MAC_BCAST,
                                                            ADDR_MAC_ANY,
                                                            ADDR_MAC_UNKNOWN,
                                                            ADDR_IP4_UNKNOWN,
} from "./struct.js"

export const create_eth_header = (
    eth_dmac = 0xffffffffffff,
    eth_smac = 0xffffffffffff,
    eth_type = 0x0000,
) => {
    let offset = 0, buf = Buffer.alloc(42);

    offset = buf.writeUIntBE( eth_dmac, offset, 6 );
    offset = buf.writeUIntBE( eth_smac, offset, 6 );
    offset = buf.writeUInt16BE( eth_type, offset );

    return buf;
}

export const create_wsc_inform = (
    mac = 0xffffffffffff,
    ip4 = 0xffffffff,
    rsv = 0x00
) => {
    let offset = 0, buf = Buffer.alloc(14);

    offset = buf.writeUIntBE( mac, offset, 6 );
    offset = buf.writeUInt32BE( ip4, offset );
    offset = buf.writeUInt16BE( rsv, offset );
    offset = buf.writeUInt16BE( ETHERTYPE_WSC, offset );

    return buf;
}

export const create_arp_request_packet_who_has_mac_bcast = (
    this_mac    = 0x000000000000,
    this_ip4    = 0x00000000,
    unknown_mac = 0x000000000000,
) => create_arp_packet(
    ADDR_MAC_BCAST,     this_mac,     ETHERTYPE_ARP,

    MAC_ATYPE,          IP4_ATYPE,
    MAC_ALEN,           IP4_ALEN,

    ARP_REQUEST,

    this_mac,           this_ip4,
    unknown_mac,        ADDR_IP4_UNKNOWN,
)

export const create_arp_announce = (
    mac = 0x000000000000,
    ip4 = 0x00000000,
) => create_arp_packet(
    ADDR_MAC_BCAST,     mac,            ETHERTYPE_ARP,

    MAC_ATYPE,          IP4_ATYPE,
    MAC_ALEN,           IP4_ALEN,

    ARP_REQUEST,

    mac,                ip4,
    ADDR_MAC_ANY,       ip4,
)

export const create_arp_reply_packet_asnwering_my_assignation = (
    my_mac      = 0x000000000000,
    my_ip4      = 0x00000000,
    querier_mac = 0x000000000000,
    querier_ip4 = 0x00000000,
) => create_arp_packet(
    querier_mac,        my_mac,     ETHERTYPE_ARP,

    MAC_ATYPE,          IP4_ATYPE,
    MAC_ALEN,           IP4_ALEN,

    ARP_REPLY,

    my_mac,             my_ip4,
    querier_mac,        querier_ip4,
)

export const create_arp_request_packet_who_is_ip4_bcast = (
    this_mac    = 0x000000000000,
    this_ip4    = 0x00000000,
    unknown_ip4 = 0x00000000,
) => create_arp_packet(
    ADDR_MAC_BCAST,     this_mac,     ETHERTYPE_ARP,

    MAC_ATYPE,          IP4_ATYPE,
    MAC_ALEN,           IP4_ALEN,

    ARP_REQUEST,

    this_mac,           this_ip4,
    ADDR_MAC_UNKNOWN,   unknown_ip4,
)

export const create_arp_request_packet = (
    eth_dmac = 0xffffffffffff,
    eth_smac = 0xffffffffffff,
    eth_type = 0x0000,

    device_addr_type,
    assigned_address_type,
    device_addr_length,
    assigned_addr_length,
    protocol_operation_type,

    sender_device_address = 0x000000000000,
    sender_assigned_address = 0x00000000,
    target_device_address = 0x000000000000,
    target_assigned_address = 0x00000000
) => {
    let offset = 0, buf = Buffer.alloc(42);

    offset = buf.writeUIntBE( eth_dmac, offset, 6 );
    offset = buf.writeUIntBE( eth_smac, offset, 6 );
    offset = buf.writeUInt16BE( eth_type, offset );

    offset = buf.writeUInt16BE( device_addr_type, offset );
    offset = buf.writeUInt16BE( assigned_address_type, offset );
    offset = buf.writeUInt8( device_addr_length, offset );
    offset = buf.writeUInt8( assigned_addr_length, offset );
    offset = buf.writeUInt16BE( protocol_operation_type, offset );
    
    offset = buf.writeUIntBE( sender_device_address, offset, 6 );
    offset = buf.writeUInt32BE( sender_assigned_address, offset );
    offset = buf.writeUIntBE( target_device_address, offset, 6 );
    offset = buf.writeUInt32BE( target_assigned_address, offset );

    return buf;
}

export const create_arp_packet = (
    eth_dmac = 0xffffffffffff,
    eth_smac = 0xffffffffffff,
    eth_type = 0x0000,

    device_addr_type,
    assigned_address_type,
    device_addr_length,
    assigned_addr_length,
    protocol_operation_type,

    sender_device_address = 0x000000000000,
    sender_assigned_address = 0x00000000,
    target_device_address = 0x000000000000,
    target_assigned_address = 0x00000000
) => {
    let offset = 0, buf = Buffer.alloc(42);

    offset = buf.writeUIntBE( eth_dmac, offset, 6 );
    offset = buf.writeUIntBE( eth_smac, offset, 6 );
    offset = buf.writeUInt16BE( eth_type, offset );

    offset = buf.writeUInt16BE( device_addr_type, offset );
    offset = buf.writeUInt16BE( assigned_address_type, offset );
    offset = buf.writeUInt8( device_addr_length, offset );
    offset = buf.writeUInt8( assigned_addr_length, offset );
    offset = buf.writeUInt16BE( protocol_operation_type, offset );
    
    offset = buf.writeUIntBE( sender_device_address, offset, 6 );
    offset = buf.writeUInt32BE( sender_assigned_address, offset );
    offset = buf.writeUIntBE( target_device_address, offset, 6 );
    offset = buf.writeUInt32BE( target_assigned_address, offset );

    return buf;
}
