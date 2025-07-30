import { task_channel, TYPE as CONST, WebSocketServerOptions } from "./helpers.js"

task_channel.addEventListener( "message", e => {
    console.log(e);
});

localStorage.uuid ||= crypto.randomUUID();

export const reset = "\x1b[0m"
export const bright = "\x1b[1m"
export const dim = "\x1b[2m"
export const underscore = "\x1b[4m"
export const blink = "\x1b[5m"
export const reverse = "\x1b[7m"
export const hidden = "\x1b[8m"

export const black = "\x1b[30m"
export const red = "\x1b[31m"
export const green = "\x1b[32m"
export const yellow = "\x1b[33m"
export const blue = "\x1b[34m"
export const magenta = "\x1b[35m"
export const cyan = "\x1b[36m"
export const white = "\x1b[37m"

const x1 = (c,s) => `${c}${s}${reset}`;
const packet = ( type, data = {} ) => Object({ type, data });

const sendDiscover = nic => {
    nic.postMessage(
        packet(CONST.BOOTP_DHCP_REQUEST, 
            packet(CONST.SERVICE_DHCP_DISCOVER)
        )
    );
}; 

const upEthernet = nic => {
    WebSocketServerOptions.parse( nic.url, nic );

    nic.cableState = CONST.CABLE_STATE_CONNECTED;
    nic.linkState  = CONST.LINK_STATE_OPENING;
    nic.lastError  = CONST.NULL;

    sendDiscover(nic);
}

Reflect.defineProperty( WebSocket.prototype, "postMessage", {
    value : function (data) { this.send(JSON.stringify(data)) }
})


const navigator_dhcpClientHandlers = {
    [ +CONST.SERVICE_DHCP_OFFER ] : function ( nic, data ) {
        console.log( x1(red, nic.host), CONST.SERVICE_DHCP_OFFER, data )

        nic.postMessage(
            packet(CONST.BOOTP_DHCP_REQUEST, 
                packet(CONST.SERVICE_DHCP_REQUEST, [
                    packet(CONST.VALUE_NIC_HWADDR, data.addr)
                ]
                )
            )
        );
    },

    [ +CONST.SERVICE_DHCP_ACK ] : function ( nic, data ) {
        console.log( x1(yellow, nic.host), CONST.SERVICE_DHCP_ACK, data, nic )
        nic.linkState = CONST.LINK_STATE_OPEN
    }
}

const navigator_nicDeviceHandlers = {
    [ +CONST.BOOTP_DHCP_REPLY ] : function ( nic, data ) {
        console.log( x1(red, nic.host), CONST.BOOTP_DHCP_REPLY, data )
        navigator_dhcpClientHandlers[ data.type ]( nic, data.data );
    },
};


const navigator_ethDeviceHandlers = {
    [ +CONST.EVENT_ONOPEN ] : function ( eth, nic ) {
        console.log( x1(red, nic.host), CONST.EVENT_ONOPEN, eth )

        nic.addEventListener( "message", function (e) {
            const packet = JSON.parse( e.data );
            console.log( x1(red, nic.host), CONST.EVENT_ONMESSAGE, packet )
            const { type, data } = packet;

            navigator_nicDeviceHandlers[ type ]( nic, data );
        })

        upEthernet(nic);
    }
};

class WebSocketClient extends WebSocket {
    constructor ( options ) {
        WebSocketServerOptions.default( options );
        super( options.url );
        
        Reflect.defineProperty( this, "host", { value: options.host });
        Reflect.defineProperty( this, "type", { value: CONST.DEVICE_ETH_WEBSOCKET_JS });
        Reflect.defineProperty( this, "uuid", { value: localStorage.uuid });

        console.log( x1(green, this.host), CONST.EVENT_ONOPENING, options )

        this.addEventListener( "open", ({ target: wsc }) => 
            navigator_ethDeviceHandlers[ +CONST.EVENT_ONOPEN ]( this, wsc, options )
        )
    }

    postMessage (data) {
        console.log( x1(green, this.host), data.type, data.data )
        this.send(JSON.stringify(data)); 
    }
}

const eth0 = new WebSocketClient( { host: "cen.net", port: 2415 } );
const eth1 = new WebSocketClient( { host: "port.central.network", port: 2414 } );
