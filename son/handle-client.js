import {
    ETHERTYPE_ETH,      ARP_REQUEST,    IHL_VERSION_4,      MAC_ALEN,
    ETHERTYPE_ARP,      ARP_REPLY,      IHL_VERSION_6,      IP4_ALEN,
                                                            MAC_ATYPE,
                                                            IP4_ATYPE,

                                                            ADDR_MAC_BCAST,
                                                            ADDR_MAC_UNKNOWN,
                                                            ADDR_IP4_UNKNOWN,

    ETHHeader,          ARPPacket,      IPPacket,
                        ARPHeader,      IP4Header, 
                                        IP6Header, 
} from "./struct.js"

const log = console.log

import {
    create_eth_header,
    create_arp_packet,
    create_arp_request_packet_who_has_mac_bcast,
    create_arp_reply_packet_asnwering_my_assignation,
} from "./packet.js"

export const LAN = Object.defineProperties({
    [ "ip4 -> mac" ] : new Map,
    [ "mac -> ip4" ] : new Map,
}, {
    ip4_to_mac : { get : function () { return this[ "ip4 -> mac" ] } },
    mac_to_ip4 : { get : function () { return this[ "mac -> ip4" ] } },

    assign  : { 
        value : function ( mac, ip4 ) {
            log( `assigned mac(`,mac,`) <-> ip4(`,ip4,`)` );

            this.ip4_to_mac.set( ip4, mac );
            this.mac_to_ip4.set( mac, ip4 );
        }
    },
})

let handle_arp_request = function ( pkt ) {
    ARPPacket *pkt;    
    log( "handling arp request", this.link )

    create_arp_reply_packet_asnwering_my_assignation(
        this.smac,      
        this.sip4, 
        pkt.arp_smac,   pkt.arp_saddr,
    ).send( this )
}

let handle_arp_reply = function ( pkt ) {
    ARPPacket *pkt;    
    LAN.assign( pkt.arp_smac, pkt.arp_saddr );
    log( "handling arp reply", this.link, LAN )
}

let handle_arp = function ( pkt ) {
    ARPPacket *pkt;
    if (pkt.arp_dmac !== this.smac) return;

    log( "handling arp", this.link, pkt.arp_opcode )
    
    switch ( pkt.arp_opcode ) {
        case ARP_REPLY      : handle_arp_reply( pkt ); return;
        case ARP_REQUEST    : handle_arp_request( pkt ); return;
    }
}

let handle_ip6 = function ( pkt ) {}
let handle_ip4 = function ( pkt ) {}
let handle_eth = function ( pkt ) {
    IPPacket *pkt;
    log( "handling eth", this.link, pkt.ip4_ihl )

    switch ( pkt.ip4_ihl ) {
        case IHL_VERSION_4  : handle_ip4( pkt ); return;
        case IHL_VERSION_6  : handle_ip6( pkt ); return;
    }
}

export function handlers (wsc) {
    return Object({
        handle_arp          : handle_arp = handle_arp.bind( wsc ),         
        handle_arp_reply    : handle_arp_reply = handle_arp_reply.bind( wsc ),   
        handle_arp_request  : handle_arp_request = handle_arp_request.bind( wsc ), 
        handle_eth          : handle_eth = handle_eth.bind( wsc ),
        handle_ip4          : handle_ip4 = handle_ip4.bind( wsc ),
        handle_ip6          : handle_ip6 = handle_ip6.bind( wsc ),
    })
}

export default handlers;