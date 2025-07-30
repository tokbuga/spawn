import * as ws from "ws"
import {
    ETHERTYPE_ETH,      ARP_REQUEST,    IHL_VERSION_4,      MAC_ALEN,
    ETHERTYPE_ARP,      ARP_REPLY,      IHL_VERSION_6,      IP4_ALEN,
                                                            MAC_ATYPE,
                                                            IP4_ATYPE,

    ETHHeader,          ARPPacket,      IPPacket,
                        ARPHeader,      IP4Header, 
                                        IP6Header, 
} from "./struct.js"

import {
    create_eth_header,
    create_arp_packet,
    create_wsc_inform,
} from "./packet.js"

import handlers from "./handle-client.js"

const log = console.log

const webSocket = new ws.WebSocket("ws://cen.net:2415");
const wscObject = Object.defineProperties({}, {
    sock : { value : webSocket },
    link : { value : "b -> x" },
    smac : { value : 0x422dc24ce61a },
    sip4 : { value : 0x01020305 },
    send : { value : webSocket.send.bind( webSocket ) } 
});

Object.defineProperties(webSocket, {
    wsco : { value : wscObject },
    link : { value : wscObject.link },
    smac : { value : wscObject.smac },
    sip4 : { value : wscObject.sip4 },
})

const {
    handle_arp,         handle_eth,
    handle_arp_reply,   handle_ip4,
    handle_arp_request, handle_ip6,
} = handlers( wscObject );

webSocket.on( "open", function () {
    
    wscObject.cableState = "CABLE_CONNECTED";
    log( "wsc open", wscObject )

    create_wsc_inform( this.smac, this.sip4 )
        .send( this )

    this.on( "message", function (pkt) {
        const hdr = ETHHeader *pkt;
        log( "handling", this.link, hdr.type )

        switch ( hdr.type ) {
            case ETHERTYPE_ETH : handle_eth( pkt ); return;
            case ETHERTYPE_ARP : handle_arp( pkt ); return;
            default : log("ETHERTYPE_NA", hdr.type.hex(2))
        }
    })
})
