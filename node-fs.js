export async function readFileSync ( pathname ) { return new Promise(done => {
    fetch(pathname).then(r => r.text()).then( done );
}); };

export async function writeFileSync () { return undefined; };
export async function unlinkSync () { return undefined; };
export async function existsSync () { return false; };