import { readFileSync } from "fs" 

export const isNavigator = "undefined" === typeof process;
export const isWebWorker = "undefined" === typeof window;
export const isDevice    = "undefined" !== typeof process;


export const DefaultWebSocketPort = 2415;
export const DefaultWebSocketHost = "127.0.0.1";

if ("undefined" === typeof origin) {
    global.origin = `http://${DefaultWebSocketHost}:${DefaultWebSocketPort}`
}

const [ 
    OriginProtocolName, 
    OriginDomainName,
    OriginPort = OriginProtocolName.endsWith("s") && 443 || 80,
    OriginHost = OriginDomainName,
    OriginProtocol = `${OriginProtocolName}://`, 
] = (origin).split(/[\/|\:]+/);

export const WebSocketServerOptions = Object.defineProperties({
    port     : DefaultWebSocketPort,
    uuid     : "",
    host     : OriginHost,
    protocol : OriginProtocol.replace("http", "ws")
}, {
    path     : { 
        enumerable: true,
        get : function () { return `/${this.uuid}` },
        set : function (v) { return this.uuid = v.substring(1) || "" },
    },
    url     : { 
        enumerable: true,
        get : function () { return `${target.protocol}${target.host}:${target.port}/${target.uuid}`; },
        set : function (v) { return this.parse(v) },
    },
    parse    : {
        enumerable  : false,
        value       : function ( url, target ) {
            const {
                hostname: host, port, pathname: path
            } = new URL( url );

            return this.default({
                host, port, path
            }, target);
        }
    },
    default  : {
        enumerable  : false,
        value       : function ( options = {}, target = options ) {
            for (const key in this) { 
                if (!target[key]) {
                    try { target[key] = this[ key ]} 
                        catch {}
                }
            }

            try { target.url = `${target.protocol}${target.host}:${target.port}/${target.uuid}`; } catch {}

            return target;
        }
    } 
});

if ( typeof process === "undefined" )
    self.process = { argv: [] };

export function toNumber ( any = this ) {
    return `${any}`.split("")
        .map(c => c.charCodeAt())
        .map((c,i) => c * (i+1))
        .reduce((a, b = 0) => a + b)
    ;
} 

Reflect.defineProperty( Object.prototype, "toNumber", { value: toNumber } );

export const task_channel = new BroadcastChannel("task");

export const kUnique = Symbol("uid");

export class Unique extends Number { 
    static sym = kUnique; 
    static map = new Map;

    is (number) {
        return !(this - number);
    }
};

export const unique = {
    for : new Proxy( Unique, {

        set : function ( Super, keyName, keyCode ) {
            const keyFunc = Function(`return class ${keyName} extends this {}`);
            const keyClass = keyFunc.call(Super); 
            const keyNumber = Reflect.construct( keyClass, [ keyCode ] );

            Reflect.defineProperty( keyClass.prototype, "name", { value: keyName } );
            Reflect.defineProperty( keyClass.prototype, "value", {  value: keyCode } );
            Reflect.defineProperty( keyClass.prototype, Super.sym, { value: () => keyCode } );
            Reflect.defineProperty( keyClass.prototype, Symbol.toPrimitive, { value: () => keyCode } );
            
            Super.map.set( keyName, keyNumber );
            Super.map.set( keyCode, keyNumber );
            Super.map.set( keyNumber, keyName );

            Reflect.defineProperty( Super.map, keyName, { value: keyNumber } );
            Reflect.defineProperty( Super.map, keyCode, { value: keyNumber } );

            return keyNumber;
        },

        get : function ( Super, keyName ) {

            if (Super.map.has( keyName ) === false) {
                const keyCode = keyName.toNumber();
    
                const keyFunc = Function(`return class ${keyName} extends this {}`);
                const keyClass = keyFunc.call(Super); 
                const keyNumber = Reflect.construct( keyClass, [ keyCode ] );
    
                Reflect.defineProperty( keyClass.prototype, "name", { value: keyName } );
                Reflect.defineProperty( keyClass.prototype, "value", {  value: keyCode } );
                Reflect.defineProperty( keyClass.prototype, Super.sym, { value: () => keyCode } );
                Reflect.defineProperty( keyClass.prototype, Symbol.toPrimitive, { value: () => keyCode } );
                
                Super.map.set( keyName, keyNumber );
                Super.map.set( keyCode, keyNumber );
                Super.map.set( keyNumber, keyName );

                Reflect.defineProperty( Super.map, keyName, { value: keyNumber } );
                Reflect.defineProperty( Super.map, keyCode, { value: keyNumber } );
            }

            return Super.map.get( keyName );
        } 
    })
};
unique.for.NULL = 0;
unique.for.TASK_FETCH_URL;
unique.for.TASK_ADD_URL;
unique.for.TASK_ADD_URL_LIST;
unique.for.TASK_ADD_DOMAIN;
unique.for.TASK_ADD_DOMAIN_LIST;
unique.for.BOOTP_DHCP_REQUEST;
unique.for.BOOTP_DHCP_REPLY;
unique.for.SERVICE_DHCP_DISCOVER;
unique.for.SERVICE_DHCP_OFFER;
unique.for.SERVICE_DHCP_REQUEST;
unique.for.SERVICE_DHCP_ACK;
unique.for.SERVICE_DHCP_NAK;
unique.for.ERROR_ADDR_NOT_AVAILABLE;
unique.for.STATE_PASSIVE;
unique.for.STATE_ACTIVE;
unique.for.STATE_WAITING;
unique.for.STATE_CREATING;
unique.for.STATE_ASSIGNING;
unique.for.STATE_WORKING;
unique.for.STATE_TRUE;
unique.for.STATE_FALSE;
unique.for.CABLE_STATE_CONNECTED;
unique.for.LINK_STATE_OPENING;
unique.for.LINK_STATE_OPEN;
unique.for.LINK_STATE_CLOSED;
unique.for.LINK_STATE_CLOSING;
unique.for.EVENT_ONCONNECTION;
unique.for.EVENT_ONMESSAGE;
unique.for.EVENT_ONOPEN;
unique.for.EVENT_ONOPENING;
unique.for.DEVICE_ETH_WEBSOCKET_JS;
unique.for.DEVICE_ETH_WEBSOCKETSERVER_NODEJS;
unique.for.DEVICE_ETH_WEBSOCKETSERVER_CLIENT_NODEJS;
unique.for.VALUE_NIC_HWADDR;
unique.for.VALUE_LEASE_TIME;

export const TYPE = Unique.map;

if (process.argv.includes("DEBUG") === false) {
    console.debug = function(){}
}

const tld_list_basic = (await readFileSync("refdb/tld-list-basic.txt")).toString().split(/\s/).filter(Boolean);

export function addTask ( type, data ) {
    task_channel.postMessage({ type, data });
}

export function protocolOf (url) {
    return hasProtocol(url) && `${url.match(/(.*)\:\/\//).at(1)}` || "";
}

export function fullpathOf (url) {
    if (hasProtocol(url)) {
        url = url.substring( url.indexOf("://") + 3 );    
    }

    const indexOfSlash = url.indexOf("/");
    if (indexOfSlash !== -1) {
        return url.substring(indexOfSlash);
    }

    return "/";
}

export function filenameOf (url) {
    return url.split("/").pop();
}

export function basenameOf (url) {
    const filename = filenameOf(url);
    const lastindex = filename.lastIndexOf(".");
    if (lastindex !== -1) {
        return filename.substring(0, lastindex);
    }
    return filename;
}

export function fileextensionOf (url) {
    const filename = filenameOf(url);
    const basename = basenameOf(url);
    return filename.substring(basename.length + 1);
}

export function domainOfURL (url) {
    const ext = extensionOf(url);
    const proto = protocolOf(url);

    let begin = 0;
    if (proto) {
        begin += proto.length + 3;
    }

    let end = url.indexOf( ext ) + ext.length;
    let domain = url.substring( begin, end );

    if (!isDomainName(domain)) {
        return "";
    }

    return domain;
}

export function hasProtocol (url) {
    return `${url}`.match(/(.*)\:\/\//)?.index === 0;
}

export const makeup_extensions = [ "css", "js", "svg", "less", "sass", "gif", "css.map" ];
export const url_extensions = [ "html", "php", "pdf", "aspx" ];

export function isntMakeup (url) {
    return !makeup_extensions.includes(url.split(".").pop());
}

export function isURLExtension (url) {
    const split = url.split(".");
    return (split.length > 1) && url_extensions.includes(split.pop());
}

export function isPathStart (url) {
    return url.startsWith("/") || url.endsWith("/") || isURLExtension(url);
}

export function prefixURL (url) {

    let domainStart = url.indexOf("://");
    if (domainStart !== -1) {
        domainStart += 3;
    }

    url = removeEndSlash(url);

    return d => `${url}/${removeStartSlash(d)}`;
}

export function fixURL (url) {
    const domain = rootDomainOf(url);
    if (domain) {
        const index = url.indexOf(domain) + domain.length;
        const prev = url.substring(0, index);
        const rest = url.substring(index);

        return removeEndSlash(removeEndSlash(prev).concat("/").concat(removeStartSlash(rest)));
    }

    return removeEndSlash(url);
}

export function removeEndSlash (url = "") {
    return url.endsWith("/") && removeEndSlash(url.substring(0, url.length-1)) || url;
}

export function removeStartSlash (url = "") {
    return url.startsWith("/") && removeStartSlash(url.substring(1)) || url;
}

export function filterUnique (d,i,t) {
    return d && t.lastIndexOf(d) === i;
}

export function isURL (url) {
    return hasExtension(url);
}

export function extensionOf ( domain ) {
    console.debug(`extensionOf -> ${domain}`);

    const cleared_domain_name = clearDomain(domain);
    console.debug(`extensionOf -> clearDomain(${domain}) -> ${cleared_domain_name}`);

    const rev_parts = cleared_domain_name.split(".").reverse();
    console.debug(`extensionOf -> rev_parts(${domain}) -> `, rev_parts);
    
    let last_extension_until_not_one = 0;
    let length_of_rev_parts = rev_parts.length;

    while (length_of_rev_parts--) {
        console.debug(`extensionOf -> while(length_of_rev_parts--) -> `, length_of_rev_parts);
        
        const rev_part_i = last_extension_until_not_one++;
        console.debug(`extensionOf -> while(length_of_rev_parts--) -> rev_part_i -> `, rev_part_i);

        const rev_part_at_i = rev_parts.at(rev_part_i);
        console.debug(`extensionOf -> while(length_of_rev_parts--) -> rev_part_at_i(${rev_part_i}) -> `, rev_part_at_i);
        
        const is_extension = isExtension( rev_part_at_i ); 
        console.debug(`extensionOf -> while(length_of_rev_parts--) -> isExtension(${rev_part_at_i}) -> `, is_extension);
        
        if (is_extension) {
            continue;
        }

        const final_result = rev_parts.slice( 0, last_extension_until_not_one-1 ).reverse().join(".");
        console.debug(`extensionOf -> while(length_of_rev_parts--) -> final_result -> `, final_result);

        return final_result;
    }

    console.debug(`extensionOf -> WHILE_ENDED_WITHOUT_SUCCESS !!`);

    return "";
}


export function isIPAddress ( domain ) {
    return domain.match(/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/) !== null;
}

export function hasExtension (domain) {
    return domain.split(".").find(isExtension) && domain.includes(".");
}

export function isDomainName ( domain ) {
    return !isIPAddress(domain) && hasExtension(domain);
}

export function reverseDomain (domain) {
    return domain.split(".").filter(Boolean).reverse().join(".");
}

export function rootDomainOf ( domain ) {
    console.debug(`rootDomainOf -> ${domain}`);

    const extension = extensionOf(domain);
    console.debug(`rootDomainOf -> extensionOf(${domain}) -> ${extension}`);
    
    const e_index = domain.lastIndexOf(extension);
    console.debug(`rootDomainOf -> lastIndexOf(${extension}) -> ${e_index}`);
    
    if (e_index === -1) {
        return domain
    }

    const final_result = clearDomain(domain.substring(0, e_index-1).split(".").pop() + "." + extension);
    console.debug(`rootDomainOf -> final_result -> ${final_result}`);

    return final_result;
}

export function isExtension ( domain ) {
    return tld_list_basic.indexOf( domain ) !== -1;
}

export function clearDomain ( domain ) {
    if (!domain) {
        return "";
    }

    let indexOf_proto = domain.indexOf("//");
    if (indexOf_proto !== -1) {
        domain = domain.substring( indexOf_proto + 2 );
    }

    let indexOf_port = domain.indexOf(":");
    if (indexOf_port !== -1) {
        domain = domain.substring( 0, indexOf_port );
    }

    let indexOf_url = domain.indexOf("/", indexOf_proto + 3);
    if (indexOf_url !== -1) {
        domain = domain.substring( 0, indexOf_url );
    }

    return domain;
}

export function extractDomains ( ...domains ) {
    return [ ...domains ].flat().map(domain => {
        console.debug(`extractDomains -> ${domain}`);
    
        const cleared_domain_name = clearDomain( domain );    
        console.debug(`extractDomains -> clearDomain(${domain}) -> ${cleared_domain_name}`);
        
        const root_domain_name = rootDomainOf(cleared_domain_name);
        console.debug(`extractDomains -> rootDomainOf(${cleared_domain_name}) -> ${root_domain_name}`);
        
        const extended_from_root = domain.substring(0, domain.lastIndexOf(root_domain_name)-1);
        console.debug(`extractDomains -> extended_from_root -> ${extended_from_root}`);
        
        const final_result = extended_from_root
            .split(".")
            .map((n,i,t) => `${t.slice(i).join(".")}.${root_domain_name}`)
            .concat(root_domain_name)
            .map(d => d.split(".").filter(Boolean).join("."));

        console.debug(`extractDomains -> final_result -> `, final_result);
    
        return final_result;

    }).flat().filter((d,i,t) => t.lastIndexOf(d) === i).sort((a,b) => a.length - b.length);
}

export async function hash (text, alg = "sha-1") {
    return Array.from( new Uint8Array((await crypto.subtle.digest(alg, Buffer.from(text)))) ).map((b) => b.toString(16).padStart(2, "0"))
    .join("")
}

export async function node_fetch (url) {
    
    const data = { url };
    let t0, request = { headers: new Headers, text: async () => "" };
    
    data.urlHash            = await hash(url);
    data.proto              = protocolOf(data.url);
    data.domain             = domainOfURL(data.url);
    data.root_domain        = rootDomainOf(data.domain);
    data.full_path          = fullpathOf(data.url);
    data.file_name          = filenameOf(data.url);
    data.file_base_name     = basenameOf(data.url);
    data.file_ext_name      = fileextensionOf(data.url);

    data.time_origin        = performance.timeOrigin;         
    t0 = performance.now();

    if (url && isURL(url))  {
        request             = (await fetch(data.url)) || {};
    }

    data.time_request       = performance.now() - t0;
    data.request_ok         = !!request.ok && 1 || 0;
    data.request_redirected = !!request.redirected && 1 || 0;
    data.request_type       = request.type;
    data.headers            = Array.from(request.headers.values()).join("\n");
    data.cookie             = request.headers.get("set-cookie");
    data.contentType        = request.headers.get("content-type")?.split(/\;|\s/).at(0);
    data.contentLength      = request.headers.get("content-length") && Number(request.headers.get("content-length")) || 0;
    data.lastModified       = request.headers.get("last-modified") && new Date(request.headers.get("last-modified")).getTime() || 0;

    if (data.request_ok) {
        data.textContent    = (await request.text()).replaceAll(/\s+/g, " ").trim();
    }

    return data;
}