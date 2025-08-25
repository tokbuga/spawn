import fs from 'fs';
import path from 'path';
(async ()=>{
  const mod = await import('file://' + path.resolve(process.cwd(), 'draco_decoder_min.js'));
  const dec = mod.default;
  const recipePath = path.resolve(process.cwd(), 'draco_recipe.json');
  if (!fs.existsSync(recipePath)) throw new Error('Missing recipe: ' + recipePath);
  const recipe = JSON.parse(fs.readFileSync(recipePath, 'utf8'));
  const glbPath = path.resolve(process.cwd(), 'son', 'npc_d.glb');
  if (!fs.existsSync(glbPath)) throw new Error('Missing glb: ' + glbPath);
  const glb = fs.readFileSync(glbPath);
  const parsed = dec.parseConnectivity(glb, recipe.byteOffset);
  const res = dec.decodeEdgeBreakerFaces(parsed, { debug: true, maxSteps: 20000, maxEvents: 200 });
  console.log('facesLen', res && res.faces ? res.faces.length/3 : (res && res.length) || 0);
  if (res && res.debugEvents) console.log('events sample', res.debugEvents.slice(0,40));
  else console.log('no debug events returned');
})();
