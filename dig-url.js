import { createClient } from "redis";
import * as helpers from "./helpers.js"


const domain_db = await createClient("redis://127.0.0.1:6379")
  .on("error", (err) => console.debug("Redis Client Error", err))
  .connect();

await domain_db.select(0);

const url_db = await createClient("redis://127.0.0.1:6379")
  .on("error", (err) => console.debug("Redis Client Error", err))
  .connect();

const fetch_db = await createClient("redis://127.0.0.1:6379")
  .on("error", (err) => console.debug("Redis Client Error", err))
  .connect();

await url_db.select(3);
await fetch_db.select(4);

const url = process.argv.find(helpers.isURL);
const data = await helpers.node_fetch( url );
const content = data.textContent;

await fetch_db.HSET(url, data);
await fetch_db.EXPIRE(url, 600);

const unfiltered_strings = content.split(/\"|\s/).filter(Boolean).filter(s => 
    !s.includes("<") && !s.includes(">") && !s.startsWith(">") &&
    !s.startsWith("=") && !s.endsWith("=") && !s.endsWith("<") &&
    !s.match(/\[|\(|\{|\'|\"|\`/) && s.match(/\w/) && !s.startsWith("self.") &&
    !s.startsWith("col-") && !s.startsWith("row-") && !s.startsWith("window.")
);

const makeup_removeds = unfiltered_strings
    .filter( helpers.isntMakeup );

const url_list = makeup_removeds
    .filter( helpers.isPathStart )
    .map( helpers.prefixURL( url ) )
    .concat(
        makeup_removeds
            .filter( helpers.hasProtocol )
            .map( helpers.removeEndSlash )
    )
    .map( helpers.fixURL )
    .filter( helpers.filterUnique )
    ;

const domains = url_list.map( helpers.domainOfURL ).filter( helpers.filterUnique );


let i;

i = url_list.length;
while (i--) {
    const checkExists = await url_db.EXISTS(url_list[i]);
    if (checkExists === 0) {
        console.log(`url( ${url_list[i]} ) adding to db`)
        await url_db.SET(url_list[i], url);
    }
}

i = domains.length;
while (i--) {

    const domain_name = helpers.reverseDomain(domains[i]);
    const root_domain = helpers.rootDomainOf(domain_name);
    const checkExists = await domain_db.EXISTS(domain_name);

    if (checkExists === 0) {
        console.log(`domain( ${domains[i]} ) not exisits, adding to db`)
        await domain_db.SET(domain_name, root_domain);
    }
}
