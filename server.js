import RedisServer from 'redis-server';
import * as ws from 'ws';
import NIC from "./dev/ethernet-server-cloud-vnic.js"
import DHCP from "./svc/dhcp-server-cloud-vnic.js"

import { TYPE as CONST } from "./helpers.js"
import { WebSocketServerOptions } from "./helpers.js"

const server = new RedisServer(6379);
const serverError = await server.open();

if (serverError !== null) {
    process.exit(console.log("redisservererror", serverError));
};

const x1red = str => `\x1b[33m${str}\x1b[0m`;
const packet = ( type, data = {} ) => Object({ type, data });

const dhcpServiceHandlers = {
    [ +CONST.SERVICE_DHCP_DISCOVER ] : function ( nic, data ) {
        console.log( nic.uuid, x1red(nic.uuid), CONST.SERVICE_DHCP_DISCOVER, data )
        
        nic.postMessage(
            packet(CONST.BOOTP_DHCP_REPLY, 
                packet(CONST.SERVICE_DHCP_OFFER, 
                    packet(CONST.VALUE_NIC_HWADDR, crypto.randomUUID())
                )
            )
        );
    },

    [ +CONST.SERVICE_DHCP_REQUEST ] : function ( nic, data ) {
        console.log( nic.uuid, x1red(nic.uuid), CONST.SERVICE_DHCP_REQUEST, data )
        
        nic.postMessage(
            packet(CONST.BOOTP_DHCP_REPLY, 
                packet(CONST.SERVICE_DHCP_ACK, [
                    packet(CONST.VALUE_NIC_HWADDR, crypto.randomUUID()),
                    packet(CONST.VALUE_LEASE_TIME, 30),
                ])
            )
        );
    }
};

const nicDeviceHandlers = {
    [ +CONST.BOOTP_DHCP_REQUEST ] : function ( nic, data ) {
        console.log( nic.uuid, x1red(nic.uuid), CONST.BOOTP_DHCP_REQUEST, data )
        dhcpServiceHandlers[ data.type ]( nic, data.data );
    },
};

const ethDeviceHandlers = {
    [ +CONST.EVENT_ONCONNECTION ] : function ( eth, nic, req ) {
        console.log( x1red(nic.uuid), CONST.EVENT_ONCONNECTION, eth.host )

        Reflect.defineProperty( nic, "eth",  { value: eth });
        Reflect.defineProperty( nic, "type", { value: CONST.DEVICE_ETH_WEBSOCKETSERVER_CLIENT_NODEJS });
        Reflect.defineProperty( nic, "uuid", { value: req.url.substring(1) });
        Reflect.defineProperty( nic, "postMessage", { value: function ( data ) {
            this.send(JSON.stringify(data));
        }});

        nic.addEventListener( "message", function (e) {
            
            const packet = JSON.parse( e.data );
            const { type, data } = packet;

            nicDeviceHandlers[ type ]( this, data );
        })
    }
};

class WebSocketServer extends ws.WebSocketServer {
    constructor ( options ) {
        WebSocketServerOptions.default( options );
        super({ host: options.host, port: options.port });
        Object.assign( this, options )
        this.addListener( "connection", (wsc, req) => 
            ethDeviceHandlers[ +CONST.EVENT_ONCONNECTION ]( this, wsc, req )
        )
    }
}

const eth0 = new WebSocketServer({ host: "cen.net", port: 2415, uuid: crypto.randomUUID(), type: CONST.DEVICE_ETH_WEBSOCKETSERVER_NODEJS });
const eth1 = new WebSocketServer({ host: "port.central.network", port: 2414, uuid: crypto.randomUUID(), type: CONST.DEVICE_ETH_WEBSOCKETSERVER_NODEJS });

