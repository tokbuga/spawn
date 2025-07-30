import { TYPE } from "../helpers.js"

export default class DHCP {
    Client = class DHCPClient {
        constructor ( nic ) {

        }
    }

    constructor ( eth0 ) {
        this.ethernet = eth0;
    }

    bound ( vnic ) {
        console.log( vnic.hwaddr );
    }

    [ TYPE.BOOTP_DHCP_REQUEST ] ( data ) {
        switch ( data.type ) {
            case TYPE.SERVICE_DHCP_DISCOVER:
                console.log(data)
            break;
        }
    }
}