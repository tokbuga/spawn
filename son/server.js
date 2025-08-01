import { WebSocket, WebSocketServer } from "ws"
import {
    ETHERTYPE_ETH,      ARP_REQUEST,    IHL_VERSION_4,      MAC_ALEN,
    ETHERTYPE_ARP,      ARP_REPLY,      IHL_VERSION_6,      IP4_ALEN,
    ETHERTYPE_WSC,                                          MAC_ATYPE,
                                                            IP4_ATYPE,

                                                            ADDR_MAC_BCAST,
                                                            ADDR_MAC_ANY,
                                                            ADDR_MAC_UNKNOWN,
                                                            ADDR_IP4_UNKNOWN,

    ETHHeader,          ARPPacket,      IPPacket,
    WSCHeader,          ARPHeader,      IP4Header, 
                                        IP6Header, 
} from "./struct.js"

const wss = Object.defineProperty({}, "sock", {
    value: new WebSocketServer({ host: "cen.net", port: 2415 })
});

function handle_arp ( pkt ) {
    ARPPacket *pkt;
    
    if (!this.mac) {
        if (!pkt.isAnnouncement) {
            return;
        }
        this.mac  = pkt.arp_smac;
        this.ip4  = pkt.arp_saddr;
    }

    if ( pkt.eth_dmac === ADDR_MAC_BCAST) {
        this.broadcast(pkt);
        return;
    }
    
    this.server.clients.forEach(c => {
        if (c.mac === pkt.eth_dmac) {
            c.send( pkt )
        }
    })    
}

function handle_wsc ( pkt ) {
    WSCHeader *pkt;
    console.log( "wsc inform", pkt.mac, pkt.ip4 )

    this.sock.mac = pkt.mac;  
    this.sock.ip4 = pkt.ip4;
}

function handle_ip6 ( pkt ) {}
function handle_ip4 ( pkt ) {}
function handle_eth ( pkt ) {
    IPPacket *pkt;

    switch ( pkt.ip4_ihl ) {
        case IHL_VERSION_4  : handle_ip4( pkt ); return;
        case IHL_VERSION_6  : handle_ip6( pkt ); return;
    }
}

wss.sock.on( "connection", function (sock) {
    
    const wsc = Object.defineProperties({}, {
        server : { value : this },
        neighs : { get : Set.prototype.difference.bind( this.clients, new Set([sock]) ) },
        broadcast : { value : function ( data ) { this.neighs.forEach(c => c.send(data)) }},
        uuid : { enumerable: true, value : crypto.randomUUID() },
        sock : { value : sock },
        send : { value : function ( data ) {
            this.sock.send(JSON.stringify(data))
        } } 
    });


    Object.defineProperties( sock, {
        wsc : { value : wsc },
        mac : { get : function () { return this.wsc.mac; } },
        ip4 : { get : function () { return this.wsc.ip4; } },
    } )

    wsc.sock.on( "message", pkt => {
        ETHHeader *pkt;

        console.log({
            dst_addr: pkt.dmac.hex(6),
            src_addr: pkt.smac.hex(6),
            eth_type: pkt.type.hex(2),
        })

        switch ( pkt.type ) {
            case ETHERTYPE_ETH: handle_eth.call( wsc, pkt ); return;
            case ETHERTYPE_ARP: handle_arp.call( wsc, pkt ); return;
            case ETHERTYPE_WSC: handle_wsc.call( wsc, pkt ); return;
            default: console.log("ETHERTYPE_NA", pkt.type.hex(2));
        }
    })
})