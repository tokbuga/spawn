
export class WebSocketServer extends WebSocket {
    constructor ( options ) {
        super( options.url );
    }
};