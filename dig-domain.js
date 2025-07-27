import { readFileSync } from "fs"
import { createClient } from "redis";
import {
    lookup, 
    reverse, 
    resolveNaptr, 
    resolveSoa, 
    resolveSrv, 
    resolveMx,
    resolveCname,
    resolveCaa,
    resolveNs,
    resolvePtr,
    resolveTxt 
} from 'node:dns/promises';

const tld_list_basic = readFileSync("refdb/tld-list-basic.txt").toString().split(/\s/).filter(Boolean);

if (process.argv.includes("DEBUG") === false) {
    console.debug = function(){}
}

const domain_db = await createClient("redis://127.0.0.1:6379")
  .on("error", (err) => console.debug("Redis Client Error", err))
  .connect();

await domain_db.select(0);

const address_db = await createClient("redis://127.0.0.1:6379")
  .on("error", (err) => console.debug("Redis Client Error", err))
  .connect();

await address_db.select(1);

const isIPAddress = function ( domain ) {
    return domain.match(/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/) !== null;
}

const hasExtension = function (domain) {
    return domain.split(".").find(isExtension) && domain.includes(".");
}

const isDomainName = function ( domain ) {
    return !isIPAddress(domain) && hasExtension(domain);
}

const reverseDomain = function (domain) {
    return domain.split(".").filter(Boolean).reverse().join(".");
}

const extensionOf = function ( domain ) {
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

const rootDomainOf = function ( domain ) {
    console.debug(`rootDomainOf -> ${domain}`);
    
    const extension = extensionOf(domain);
    console.debug(`rootDomainOf -> extensionOf(${domain}) -> ${extension}`);
    
    const e_index = domain.lastIndexOf(extension);
    console.debug(`rootDomainOf -> lastIndexOf(${extension}) -> ${e_index}`);
    
    if (e_index === -1) {
        return domain
    }

    const final_result = domain.substring(0, e_index-1).split(".").pop() + "." + extension;
    console.debug(`rootDomainOf -> final_result -> ${final_result}`);

    return final_result;
}

const isExtension = function ( domain ) {
    return tld_list_basic.indexOf( domain ) !== -1;
}

const clearDomain = function ( domain ) {
    if (!domain) {
        return "";
    }

    let indexOf_proto = domain.indexOf("://");
    if (indexOf_proto !== -1) {
        domain = domain.substring( indexOf_proto + 3 );
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

const extractDomains = function ( ...domains ) {
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

const reverseDNS = async function (domain) {
    try {
        return await reverse( domain );
    }
    catch { return [] }
}

const domainsOfDNSQueue = [];
const domainsOfDNS = async function (domain) {
    if (domainsOfDNSQueue.includes(domain)) {
        return [domain];
    }

    console.log(`domainsOfDNS -> ${domain}`);

    domainsOfDNSQueue.push(domain);

    let resolv = [];
    let opt = { all: true, family: 4 };
    let r;

    try { r = await lookup(domain, opt);    r && resolv.push( ...r.map(Object.values) ) } catch {}
    try { r = await resolveNaptr(domain);   r && resolv.push(r); } catch {}
    try { r = await resolveSoa(domain);     r && resolv.push(r); } catch {}
    try { r = await resolveSrv(domain);     r && resolv.push(r); } catch {}
    try { r = await resolveMx(domain);      r && resolv.push(r); } catch {}
    try { r = await resolveCname(domain);   r && resolv.push(r); } catch {}
    try { r = await resolveCaa(domain);     r && resolv.push(r); } catch {}
    try { r = await resolveNs(domain);      r && resolv.push(r); } catch {}
    try { r = await resolvePtr(domain);     r && resolv.push(r); } catch {}
    try { r = await resolveTxt(domain);     r && resolv.push(r); } catch {}

    try {
    
        if (resolv?.length) {
    
            const resolvs = resolv
                .flat()
                .map(Object.values)
                .flat()
                .flat()
                .map(d => `${d}`.split(/\s|\/|\:|\=/))
                .flat()
                .filter((d,i,t) => t.lastIndexOf(d) === i)                
            ;

            const domains = resolvs.filter(isDomainName);

            let i = domains.length;
            while (i--) {
                domains.push.apply(
                    domains, await domainsOfDNS(domains[i])
                );
            }
    
            return domains.concat(domain).filter((d,i,t) => t.lastIndexOf(d) === i);
        }
    }
    catch {
        // console.log("error", domain)
    }

    return [domain];
}

const ipsOfDomainQueue = [];
const ipsOfDomain = async function (domain) {
    if (ipsOfDomainQueue.includes(domain)) {
        return [domain];
    }

    console.log(`ip4sOfDomain -> ${domain}`);

    ipsOfDomainQueue.push(domain);

    let resolv = [];
    let opt = { all: true, family: 4 };
    let r;

    try { r = await lookup(domain, opt);   r && resolv.push( ...r.map(Object.values) ) } catch {}
    try { r = await resolveNaptr(domain);  r && resolv.push(...r); } catch {}
    try { r = await resolveSoa(domain);    r && resolv.push(Object.values(r)); } catch {}
    try { r = await resolveSrv(domain);    r && resolv.push(...r); } catch {}
    try { r = await resolveMx(domain);     r && resolv.push( ...r.map(Object.values) ); } catch {}
    try { r = await resolveCname(domain);  r && resolv.push(r); } catch {}
    try { r = await resolveCaa(domain);    r && resolv.push(...r); } catch {}
    try { r = await resolveNs(domain);     r && resolv.push(...r); } catch {}
    try { r = await resolvePtr(domain);    r && resolv.push(...r); } catch {}
    try { r = await resolveTxt(domain);    r && resolv.push(...r); } catch {}

    try {
        
        if (resolv?.length) {    
            const resolvs = resolv
                .flat()
                .map(d => `${d}`.split(/\s+|\/|\:|\=|\,/))
                .flat()
                .filter((d,i,t) => t.lastIndexOf(d) === i)                
            ;

            const final_result = resolvs.filter(isIPAddress).filter((d,i,t) => t.lastIndexOf(d) === i);

            return final_result;
        }
    }
    catch {
        console.log("error", domain)
    }

    return [];
}

const domain = reverseDomain(process.argv.findLast(isDomainName));

if (!extensionOf(domain)) {
    process.exit(1);
}

const root_domain = rootDomainOf(domain);

let domains   =  extractDomains(await domainsOfDNS(domain));
let addresses = (await Promise.all(domains.map(ipsOfDomain))).flat();
let ipdomains = (await Promise.all(addresses.map(reverseDNS))).flat();
domains.push.apply(domains, ipdomains)

domains = extractDomains(domains);
addresses = addresses.filter((d,i,t) => t.lastIndexOf(d) === i).sort();

let i, checkExists;

i = domains.length;
while (i--) {
    const domain = reverseDomain(domains[i]);

    checkExists = await domain_db.EXISTS(domain);
    if (checkExists === 0) {
        console.debug(`domain(${domain}) not exisits, adding to db`)
        await domain_db.SET(domain, reverseDomain(root_domain));
    }
}

i = addresses.length;
while (i--) {
    const address = addresses[i];

    checkExists = await address_db.EXISTS(address);
    if (checkExists === 0) {
        console.debug(`address(${address}) not exisits, adding to db`)
        await address_db.SET(address, reverseDomain(root_domain));
    }
}

process.exit(0);
