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

import * as helpers from "./helpers.js"

const domain_db = await createClient("redis://127.0.0.1:6379")
  .on("error", (err) => console.debug("Redis Client Error", err))
  .connect();

await domain_db.select(0);

const address_db = await createClient("redis://127.0.0.1:6379")
  .on("error", (err) => console.debug("Redis Client Error", err))
  .connect();

await address_db.select(1);


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

const domain = helpers.reverseDomain(process.argv.findLast(isDomainName));

if (!helpers.extensionOf(domain)) {
    process.exit(1);
}

const root_domain = helpers.rootDomainOf(domain);

let domains   = helpers.extractDomains(await domainsOfDNS(domain));
let addresses = (await Promise.all(domains.map(ipsOfDomain))).flat();
let ipdomains = (await Promise.all(addresses.map(reverseDNS))).flat();
domains.push.apply(domains, ipdomains)

domains = helpers.extractDomains(domains);
addresses = addresses.filter((d,i,t) => t.lastIndexOf(d) === i).sort();

let i, checkExists;

i = domains.length;
while (i--) {
    const domain = helpers.reverseDomain(domains[i]);

    checkExists = await domain_db.EXISTS(domain);
    if (checkExists === 0) {
        console.debug(`domain(${domain}) not exisits, adding to db`)
        await domain_db.SET(domain, helpers.reverseDomain(root_domain));
    }
}

i = addresses.length;
while (i--) {
    const address = addresses[i];
    checkExists = await address_db.EXISTS(address);
    if (checkExists === 0) {
        console.debug(`address(${address}) not exisits, adding to db`)
        await address_db.SET(address, helpers.reverseDomain(root_domain));
    }
}

process.exit(0);
