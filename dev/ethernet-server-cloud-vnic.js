import { WebSocketServer } from 'ws';
import { WebSocketServerOptions } from '../helpers.js';

export default class NIC extends WebSocketServer {
    constructor ( options ) {
        Object.assign(super( WebSocketServerOptions.default( options ) ), {
            host: options.host, port: options.port
        })
    }

    assignHWAddr ( wsc ) {
        wsc.hwaddr ??= crypto.randomUUID();
    }
}