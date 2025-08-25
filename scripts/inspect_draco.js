import fs from 'fs';
import { fileURLToPath } from 'url';
const path = './npc_d.glb';
const __dirname = fileURLToPath(new URL('.', import.meta.url));

(async()=>{
  if (!fs.existsSync(path)) { console.error('npc_d.glb not found'); process.exit(2); }
  const data = fs.readFileSync(path);
  const dracoIdx = data.indexOf(Buffer.from('DRACO'));
  console.log('DRACO index =', dracoIdx);
  const start = dracoIdx + 5;
  const slice = new Uint8Array(data.buffer, data.byteOffset + start, data.length - start);
  const mod = await import('../draco_decoder.js');
  const m = mod.default || mod;
  const parsed = m.parseEdgeBreakerConnectivity(slice.buffer, 0);
  const sb = parsed.symbolBuffer;
  console.log('symbolBuffer.length =', sb.length);
  const dumpLen = Math.min(256, sb.length);
  const hex = Array.from(sb.slice(0, dumpLen)).map(b => b.toString(16).padStart(2, '0')).join(' ');
  console.log('first', dumpLen, 'bytes:', hex);
})();
