import { WebSocketServer } from "ws"

const wss = new WebSocketServer({ port: 21451, host: "cen.net" });
wss.binaryType = "arraybuffer";

wss.on( "connection", function (wsc, req) {
    wsc.on('error', console.error);

    wsc.on("message", e => {
        wss.clients.forEach( c => {
            if(c !== wsc) { c.send(e); }
        })
    })
})
