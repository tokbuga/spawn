import fs from 'fs';
import draco3d from 'draco3d';

(async function(){
  const data = fs.readFileSync('./npc_d.glb');
  // Known DRACO offset provided by user
  const start = 32372;
  const dracoBuf = data.subarray(start);

  const decoderModule = await draco3d.createDecoderModule({});
  const decoder = new decoderModule.Decoder();
  const buffer = new decoderModule.DecoderBuffer();
  buffer.Init(new Int8Array(dracoBuf), dracoBuf.length);

  const geometryType = decoder.GetEncodedGeometryType(buffer);
  if (geometryType !== decoderModule.TRIANGULAR_MESH) { console.error('Not a mesh', geometryType); process.exit(1); }
  const mesh = new decoderModule.Mesh();
  const status = decoder.DecodeBufferToMesh(buffer, mesh);
  if (!status.ok() || !mesh) { console.error('Decode failed', status.error_msg()); process.exit(1); }

  const numPoints = mesh.num_points();
  const posAttrId = decoder.GetAttributeId(mesh, decoderModule.POSITION);
  if (posAttrId < 0) { console.error('No position attribute'); process.exit(1); }
  const posAttr = decoder.GetAttribute(mesh, posAttrId);
  const numComponents = posAttr.num_components();
  const pos = new decoderModule.DracoFloat32Array();
  decoder.GetAttributeFloatForAllPoints(mesh, posAttr, pos);

  console.log('numPoints=', numPoints, 'components=', numComponents);
  const out = [];
  for (let i = 0; i < Math.min(numPoints, 10); ++i) {
  const x = pos.GetValue(i * numComponents + 0);
  const y = pos.GetValue(i * numComponents + 1);
  const z = pos.GetValue(i * numComponents + 2);
    out.push([x,y,z]);
  }
  console.log('first positions:', out);

  decoderModule.destroy(pos);
  decoderModule.destroy(posAttr);
  decoderModule.destroy(mesh);
  decoderModule.destroy(decoder);
  decoderModule.destroy(buffer);
  process.exit(0);
})();
