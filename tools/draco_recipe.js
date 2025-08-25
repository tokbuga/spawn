import fs from 'fs';
import path from 'path';
(async ()=>{
  const mod = await import('file://' + path.resolve('./draco_decoder_min.js'));
  const dec = mod.default || mod;
  const glbPath = path.resolve('son/npc_d.glb');
  if (!fs.existsSync(glbPath)) { console.error('GLB not found at', glbPath); process.exit(2); }
  const ab = fs.readFileSync(glbPath);
  const found = dec.findDracoBufferInGLB(ab);
  if (!found) { console.error('No KHR_draco_mesh_compression primitive found'); process.exit(3); }
  const { byteOffset, byteLength } = found;
  console.log('Found Draco buffer at', byteOffset, byteLength);
  const parsed = dec.parseConnectivity(ab, byteOffset);
  // Prepare JSON-friendly copy
  const out = {
    traversalType: parsed.traversalType,
    numEncodedVertices: parsed.numEncodedVertices,
    numFaces: parsed.numFaces,
    numAttributeData: parsed.numAttributeData,
    numEncodedSymbols: parsed.numEncodedSymbols,
    numEncodedSplitSymbols: parsed.numEncodedSplitSymbols,
    numTopologySplits: parsed.numTopologySplits,
    sourceIdDelta: Array.from(parsed.sourceIdDelta || []),
    splitIdDelta: Array.from(parsed.splitIdDelta || []),
    sourceEdgeBit: Array.from(parsed.sourceEdgeBit || []),
    symbolBuffer_base64: Buffer.from(parsed.symbolBuffer || new Uint8Array(0)).toString('base64'),
    startFaceBuffer_base64: Buffer.from(parsed.startFaceBuffer || new Uint8Array(0)).toString('base64'),
    parsedBytes: parsed.offsetAfterParsing || parsed.parsedBytes || 0,
    byteOffset,
    byteLength
  };
  const outPath = path.resolve('draco_recipe.json');
  fs.writeFileSync(outPath, JSON.stringify(out, null, 2));
  console.log('Wrote', outPath);
})();
