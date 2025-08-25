// Minimal, self-contained Draco EdgeBreaker connectivity parser.
// Small, well-named functions to make step-by-step porting easy.

class BitReader {
  constructor(bytes, byteOffset = 0, byteLength = bytes.length - byteOffset) {
    this.bytes = bytes instanceof Uint8Array ? bytes : new Uint8Array(bytes);
    this.byteOffset = byteOffset;
    this.byteLength = byteLength;
    this.bytePos = 0;
    this.bitPos = 0; // 0..7 MSB-first
  }
  readBits(n) {
    if (n === 0) return 0;
    if (n < 0 || n > 32) throw new Error('readBits supports 1..32');
    let v = 0;
    for (let i = 0; i < n; ++i) {
      if (this.bytePos >= this.byteLength) throw new Error('BitReader overflow');
      const b = this.bytes[this.byteOffset + this.bytePos];
      const bit = (b >> (7 - this.bitPos)) & 1;
      v = (v << 1) | bit;
      this.bitPos++;
      if (this.bitPos === 8) { this.bitPos = 0; this.bytePos++; }
    }
    return v >>> 0;
  }
  resetToByte() { if (this.bitPos !== 0) { this.bitPos = 0; this.bytePos++; } }
  remainingBytes() { return Math.max(0, this.byteLength - this.bytePos); }
}

function readVarUint32(view, offset) {
  let result = 0, shift = 0, pos = offset;
  while (true) {
    if (pos >= view.byteLength) throw new Error('Unexpected EOF');
    const b = view.getUint8(pos++);
    result |= (b & 0x7F) << shift;
    if ((b & 0x80) === 0) break;
    shift += 7; if (shift > 35) throw new Error('varuint32 overflow');
  }
  return { value: result >>> 0, offset: pos };
}

function readVarUint64(view, offset) {
  let result = 0n, shift = 0n, pos = offset;
  while (true) {
    if (pos >= view.byteLength) throw new Error('Unexpected EOF');
    const b = BigInt(view.getUint8(pos++));
    result |= (b & 0x7Fn) << shift;
    if ((b & 0x80n) === 0n) break;
    shift += 7n; if (shift > 70n) throw new Error('varuint64 overflow');
  }
  return { value: result, offset: pos };
}

// Parse only the connectivity block header and return raw buffers.
function parseConnectivity(buffer, startOffset = 0) {
  const ab = buffer instanceof ArrayBuffer ? buffer : (buffer.buffer || buffer);
  const view = new DataView(ab);
  let off = startOffset;

  const traversalType = view.getUint8(off); off += 1;
  const r1 = readVarUint32(view, off); const numEncodedVertices = r1.value; off = r1.offset;
  const r2 = readVarUint32(view, off); const numFaces = r2.value; off = r2.offset;
  const numAttributeData = view.getUint8(off); off += 1;
  const r3 = readVarUint32(view, off); const numEncodedSymbols = r3.value; off = r3.offset;
  const r4 = readVarUint32(view, off); const numEncodedSplitSymbols = r4.value; off = r4.offset;

  // topology splits
  const tRes = readVarUint32(view, off); const numTopologySplits = tRes.value; off = tRes.offset;
  const sourceIdDelta = new Uint32Array(numTopologySplits);
  const splitIdDelta = new Uint32Array(numTopologySplits);
  for (let i = 0; i < numTopologySplits; ++i) {
    const a = readVarUint32(view, off); sourceIdDelta[i] = a.value; off = a.offset;
    const b = readVarUint32(view, off); splitIdDelta[i] = b.value; off = b.offset;
  }
  const splitBytes = Math.ceil(numTopologySplits / 8);
  const availableSplitBytes = Math.max(0, Math.min(splitBytes, view.byteLength - off));
  const splitArr = new Uint8Array(view.buffer, view.byteOffset + off, availableSplitBytes); off += availableSplitBytes;
  const splitReader = new BitReader(splitArr, 0, availableSplitBytes);
  const sourceEdgeBit = new Uint8Array(numTopologySplits);
  for (let i = 0; i < numTopologySplits; ++i) sourceEdgeBit[i] = splitReader.readBits(1);
  splitReader.resetToByte();

  // symbol buffer
  const rSym = readVarUint64(view, off); let symbolBufSize = rSym.value; off = rSym.offset;
  if (symbolBufSize > Number.MAX_SAFE_INTEGER) throw new Error('symbolBuf too large');
  symbolBufSize = Number(symbolBufSize);
  const availableSymBytes = Math.max(0, Math.min(symbolBufSize, view.byteLength - off));
  const symbolBuffer = new Uint8Array(view.buffer, view.byteOffset + off, availableSymBytes); off += availableSymBytes;

  // start-face buffer (one byte hint + varuint32 size + bytes)
  const startProbZero = view.getUint8(off); off += 1;
  const rStart = readVarUint32(view, off); const startFaceBufSize = rStart.value; off = rStart.offset;
  const availableStart = Math.max(0, Math.min(startFaceBufSize, view.byteLength - off));
  const startFaceBuffer = new Uint8Array(view.buffer, view.byteOffset + off, availableStart); off += availableStart;

  return {
    traversalType,
    numEncodedVertices,
    numFaces,
    numAttributeData,
    numEncodedSymbols,
    numEncodedSplitSymbols,
    numTopologySplits,
    sourceIdDelta,
    splitIdDelta,
    sourceEdgeBit,
    symbolBuffer,
    startProbZero,
    startFaceBuffer,
    offsetAfterParsing: off,
  };
}

// Very small heuristic symbol decoder to allow traversal development.


// Decode a tagged rANS symbol stream (Draco tagged format) using the Rans.decode implementation.
function decodeTaggedSymbols(buf, expectedCount) {
  if (!buf || buf.length < 1) return null;
  try {
    const view = new DataView(buf.buffer, buf.byteOffset, buf.byteLength);
    let pos = 0;
    const tag = view.getUint8(pos); if (tag !== 0) return null; pos += 1;
    const pRes = readVarUint32(view, pos); const precision = pRes.value; pos = pRes.offset;
    const sRes = readVarUint32(view, pos); const S = sRes.value; pos = sRes.offset;
    if (!S || S > 65536) return null;
    const freqs = new Uint32Array(S);
    let total = 0;
    for (let i = 0; i < S; ++i) {
      const fRes = readVarUint32(view, pos); const f = fRes.value; pos = fRes.offset;
      freqs[i] = f; total += f;
    }
    if (total === 0) return null;
    const stream = new Uint8Array(view.buffer, view.byteOffset + pos, view.byteLength - pos);
    if (stream.length === 0) return null;

    // Use the BigInt Rans.decode utility defined later in this file.
    const out = Rans.decode(stream, freqs, expectedCount || 0);
    if (!out) return null;
    // convert Uint32Array -> Uint8Array if symbols fit in a byte
    const result = new Uint8Array(out.length);
    for (let i = 0; i < out.length; ++i) result[i] = out[i] & 0xFF;
    return result;
  } catch (err) {
    return null;
  }
}

function tryDecodeTaggedRans(buf, expectedCount) { return decodeTaggedSymbols(buf, expectedCount); }

// Build symbol probability tables per spec (reads packed token bytes)
function BuildSymbolTables(bufView, num_symbols) {
  const token_probs = new Uint32Array(num_symbols);
  let pos = 0;
  for (let i = 0; i < num_symbols; ++i) {
    if (pos >= bufView.length) { token_probs[i] = 0; continue; }
    const prob_data = bufView[pos++];
    const token = prob_data & 3;
    if (token === 3) {
      const offset = prob_data >>> 2;
      for (let j = 0; j < offset + 1 && i + j < num_symbols; ++j) token_probs[i + j] = 0;
      i += offset;
    } else {
      let prob = prob_data >>> 2;
      for (let j = 0; j < token; ++j) {
        if (pos >= bufView.length) break;
        const eb = bufView[pos++];
        prob = prob | (eb << (8 * (j + 1) - 2));
      }
      token_probs[i] = prob >>> 0;
    }
  }
  const total = token_probs.reduce((a,b)=>a+b, 0);
  return { token_probs, total, consumed: pos };
}

// Build lookup (lut_table_) and probability_table_ (with prob, cum_prob)
function ransBuildLookupTable(token_probs) {
  const num_symbols = token_probs.length;
  const probability_table_ = new Array(num_symbols);
  let cum_prob = 0;
  let act_prob = 0;
  // Find total
  for (let i = 0; i < num_symbols; ++i) cum_prob += token_probs[i];
  const total = cum_prob;
  // Build probability table and LUT (lut size = total)
  let lut = new Uint32Array(Math.max(1, total));
  cum_prob = 0; act_prob = 0;
  for (let i = 0; i < num_symbols; ++i) {
    const prob = token_probs[i];
    probability_table_[i] = { prob: prob, cum_prob: cum_prob };
    cum_prob += prob;
    for (let j = act_prob; j < cum_prob; ++j) lut[j] = i;
    act_prob = cum_prob;
  }
  return { lut_table_: lut, probability_table_, total };
}

// Spec-aligned RansRead using BigInt state and mapping rem->symbol via lut/prob tables
function RansReadSpec(stateObj, l_rans_base, rans_precision, lut_table_, probability_table_) {
  // stateObj has { state: BigInt, buf: Uint8Array, buf_offset: number }
  // Renormalize: while state < l_rans_base and buf_offset > 0, pull bytes
  while (stateObj.state < BigInt(l_rans_base) && stateObj.buf_offset > 0) {
    stateObj.state = stateObj.state * BigInt(IO_BASE) + BigInt(stateObj.buf[--stateObj.buf_offset]);
  }
  const quo = stateObj.state / BigInt(rans_precision);
  const rem = Number(stateObj.state % BigInt(rans_precision));
  const symbol = lut_table_[rem];
  const symEntry = probability_table_[symbol];
  const prob = BigInt(symEntry.prob || 0);
  const cum_prob = BigInt(symEntry.cum_prob || 0);
  stateObj.state = quo * BigInt(prob) + BigInt(rem) - cum_prob;
  return symbol;
}

// Spec-aligned DecodeTaggedSymbols that follows the pseudocode and uses our Rans.decode
function decodeTaggedSymbolsSpec(buf, num_values, num_components) {
  // buf is Uint8Array containing tagged rANS blob
  if (!buf || buf.length < 1) return null;
  const view = buf;
  let pos = 0;
  // tag byte already checked by caller; skip
  const tag = view[pos++]; if (tag !== 0) return null;
  // precision and num_symbols
  const dv = new DataView(view.buffer, view.byteOffset, view.byteLength);
  const pRes = readVarUint32(dv, pos); const precision = pRes.value; pos = pRes.offset;
  const sRes = readVarUint32(dv, pos); const num_symbols_ = sRes.value; pos = sRes.offset;

  // BuildSymbolTables reads token bytes starting at pos; but the spec feeds BuildSymbolTables
  // with a sequential stream of token bytes (we'll provide the view starting at pos).
  const remaining = view.subarray(pos);

  const { token_probs, total, consumed } = BuildSymbolTables(remaining, num_symbols_);

  // compute frequency table and stream offset: after token bytes, RansInitDecoder expects
  // we pass the encoded stream starting at some offset. The token parsing consumed some bytes;

  // Now remaining[pos + consumed ..] is the encoded ANS stream
  const stream = view.subarray(pos + consumed);
  // Build lut / probability_table per spec
  const { lut_table_, probability_table_, total: tot } = ransBuildLookupTable(token_probs);

  // Initialize rANS decoder state per RansInitDecoder
  const encBuf = stream; const size = encBuf.length;
  if (size === 0) return null;
  let stateObj = { buf: encBuf, buf_offset: size, state: 0n };
  const last = encBuf[size - 1];
  const x = last >>> 6;
  if (x === 0) {
    stateObj.buf_offset = size - 1;
    stateObj.state = BigInt(last & 0x3F);
  } else if (x === 1) {
    if (size < 2) return null;
    stateObj.buf_offset = size - 2;
  stateObj.state = BigInt(dv.getUint16(pos + size - 2, true) & 0x3FFF);
  } else if (x === 2) {
    if (size < 3) return null;
  stateObj.buf_offset = size - 3;
  stateObj.state = BigInt(encBuf[size - 3]) | (BigInt(encBuf[size - 2]) << 8n) | (BigInt(encBuf[size - 1]) << 16n);
    stateObj.state &= 0x3FFFFFn;
  } else {
    if (size < 4) return null;
  stateObj.buf_offset = size - 4;
  stateObj.state = BigInt(encBuf[size - 4]) | (BigInt(encBuf[size - 3]) << 8n) | (BigInt(encBuf[size - 2]) << 16n) | (BigInt(encBuf[size - 1]) << 24n);
    stateObj.state &= 0x3FFFFFFFn;
  }
  stateObj.state += BigInt(TAGGED_RANS_BASE || 16384);

  const rans_precision = (precision && precision > 0) ? precision : (TAGGED_RANS_PRECISION || 4096);
  const l_rans_base = TAGGED_RANS_BASE || 16384;
  const outLen = num_values * num_components;
  try {
    const out = new Uint8Array(outLen);
    for (let i = 0; i < outLen; ++i) {
      const sym = RansReadSpec(stateObj, l_rans_base, rans_precision, lut_table_, probability_table_);
      out[i] = sym & 0xFF;
    }
    return out;
  } catch (e) {
    return null;
  }
}

// Prefer spec decoder when tag==0
function decodeSymbolsHeuristic(symbolBuffer, expectedCount) {
  if (!symbolBuffer || symbolBuffer.length === 0) return new Uint8Array(0);
  // check tag
  if (symbolBuffer[0] === 0) {
    const specDecoded = decodeTaggedSymbolsSpec(symbolBuffer, expectedCount || 0, 1);
    if (specDecoded) return specDecoded;
  }
  // fallback to existing heuristics
  if (expectedCount && (!symbolBuffer || symbolBuffer.length === 0)) return new Uint8Array(expectedCount);
  if (expectedCount && symbolBuffer.length === expectedCount) return new Uint8Array(symbolBuffer);
  if (expectedCount && symbolBuffer.length <= 8) {
    let allZero = true;
    for (let i = 0; i < symbolBuffer.length; ++i) if (symbolBuffer[i] !== 0) { allZero = false; break; }
    if (allZero) return new Uint8Array(expectedCount);
  }
  const ransDecoded = tryDecodeTaggedRans(symbolBuffer, expectedCount);
  if (ransDecoded) return ransDecoded;
  return new Uint8Array(symbolBuffer);
}

const API = { BitReader, readVarUint32, readVarUint64, parseConnectivity, decodeSymbolsHeuristic, BuildSymbolTables, decodeTaggedSymbolsSpec };
if (typeof window !== 'undefined') window.DracoDecoderMin = API;
if (typeof module !== 'undefined' && module.exports) {
  module.exports = API;
  // also expose default for interop with ESM import handlers
  try { module.exports.default = API; } catch (e) {}
}
export default API;

// Simple traversal builder: currently a deterministic, correct-length
// face generator that also populates corner arrays. This is a stepping
// stone before porting full EdgeBreaker traversal.
function traverseConnectivity(parsed, decodedSymbols) {
  const nf = parsed.numFaces || 0;
  // Prefer decodedSymbols length when available (real number of encoded vertices),
  // fall back to header's numEncodedVertices or a conservative estimate.
  const nv = (decodedSymbols && decodedSymbols.length) ? decodedSymbols.length : (parsed.numEncodedVertices || Math.max(1, nf * 3));
  const faces = new Uint32Array(nf * 3);
  // corner arrays
  const cornerCount = nf * 3;
  const opposite = new Int32Array(cornerCount);
  const cornerToVertex = new Int32Array(cornerCount);
  for (let i = 0; i < cornerCount; ++i) { opposite[i] = -1; cornerToVertex[i] = -1; }

  // Fill faces deterministically using vertex indices cycling through nv
  for (let f = 0; f < nf; ++f) {
    const a = (f * 3 + 0) % nv;
    const b = (f * 3 + 1) % nv;
    const c = (f * 3 + 2) % nv;
    faces[3*f + 0] = a;
    faces[3*f + 1] = b;
    faces[3*f + 2] = c;
    cornerToVertex[3*f + 0] = a;
    cornerToVertex[3*f + 1] = b;
    cornerToVertex[3*f + 2] = c;
  }

  return {
    faces,
    numVertices: nv,
    cornerToVertex,
    oppositeCorners: opposite,
  };
}

// Convenience: parse buffer, decode symbols (heuristic), and traverse
function parseAndTraverse(buffer, startOffset = 0) {
  const parsed = parseConnectivity(buffer, startOffset);
  const decoded = decodeSymbolsHeuristic(parsed.symbolBuffer, parsed.numEncodedSymbols);
  const traversal = traverseConnectivity(parsed, decoded);
  return Object.assign({}, parsed, { decodedSymbols: decoded, traversal });
}

API.traverseConnectivity = traverseConnectivity;
API.parseAndTraverse = parseAndTraverse;
// Heuristic: scan the buffer after startOffset for a tagged-rANS attribute stream
// and attempt to decode positions (3 components). Returns Float32Array Nx3 or null.
function tryExtractPositions(buffer, parsed, startOffset = 0) {
  const expectedVerts = parsed.numEncodedVertices || (parsed.decodedSymbols && parsed.decodedSymbols.length) || 0;
  if (!expectedVerts) return null;
  const comps = 3;
  const expectedLen = expectedVerts * comps;
  const maxScan = Math.min(buffer.length, startOffset + 20000);
  for (let pos = startOffset; pos < maxScan; pos += 1) {
    try {
      const slice = buffer.subarray ? buffer.subarray(pos) : buffer.slice(pos);
      const decoded = tryDecodeTaggedRans(slice, expectedLen);
      if (decoded && decoded.length === expectedLen) {
        // Heuristic dequantize: detect if values fit uint16/sint16 range
        let asFloat = new Float32Array(expectedLen);
        let maxv = 0;
        for (let i = 0; i < expectedLen; ++i) if (Math.abs(decoded[i]) > maxv) maxv = Math.abs(decoded[i]);
        let scale = 1.0;
        if (maxv > 0 && maxv <= 32767) scale = 1.0 / 32767.0; else if (maxv <= 65535) scale = 1.0 / 65535.0;
        for (let i = 0; i < expectedLen; ++i) asFloat[i] = decoded[i] * scale;
        return asFloat;
      }
    } catch (e) {
      // ignore decode errors and continue scanning
    }
  }
  return null;
}
API.tryExtractPositions = tryExtractPositions;

// Parse a GLB and return { json: Object, jsonText: string, binChunk: Uint8Array, binOffset }
function parseGLB(ab) {
  const buf = ab instanceof Uint8Array ? ab : new Uint8Array(ab);
  const view = new DataView(buf.buffer, buf.byteOffset, buf.byteLength);
  // header
  const magic = view.getUint32(0, true); // 'glTF'
  const version = view.getUint32(4, true);
  const length = view.getUint32(8, true);
  let offset = 12;
  let jsonText = null;
  let jsonObj = null;
  let binChunk = null;
  let binOffset = -1;
  while (offset < buf.length) {
    const chunkLen = view.getUint32(offset, true); offset += 4;
    const chunkType = view.getUint32(offset, true); offset += 4;
    if (chunkType === 0x4E4F534A) { // JSON
      const txt = new TextDecoder().decode(buf.subarray(offset, offset + chunkLen));
      jsonText = txt; try { jsonObj = JSON.parse(txt); } catch (e) { jsonObj = null; }
    } else if (chunkType === 0x004E4942) { // BIN
      binOffset = offset;
      binChunk = buf.subarray(offset, offset + chunkLen);
    }
    offset += chunkLen;
  }
  return { json: jsonObj, jsonText, binChunk, binOffset };
}

// Find the first KHR_draco_mesh_compression primitive and return absolute buffer offset and length
function findDracoBufferInGLB(glbBuffer) {
  const parsed = parseGLB(glbBuffer);
  if (!parsed.json || !parsed.binChunk) return null;
  const json = parsed.json;
  if (!json.meshes) return null;
  for (const mesh of json.meshes) {
    if (!mesh.primitives) continue;
    for (const prim of mesh.primitives) {
      const ext = prim.extensions && prim.extensions.KHR_draco_mesh_compression;
      if (ext && typeof ext.bufferView === 'number') {
        const bv = json.bufferViews[ext.bufferView];
        if (!bv) continue;
        const byteOffset = (bv.byteOffset || 0) + parsed.binOffset;
        const byteLength = bv.byteLength || 0;
        return { byteOffset, byteLength, json, prim, bufferView: bv };
      }
    }
  }
  return null;
}

API.parseGLB = parseGLB;
API.findDracoBufferInGLB = findDracoBufferInGLB;

// Simple EdgeBreaker traversal for STANDARD_EDGEBREAKER using decodedSymbols
function decodeEdgeBreakerFaces(parsed, opts = {}) {
  // Use the symbol buffer as a bitstream per spec.
  const bitBuf = parsed.symbolBuffer || new Uint8Array(0);
  const br = new BitReader(bitBuf, 0, bitBuf.length);
  const nf = parsed.numFaces || 0;
  const cornerCount = nf * 3;

  const opposite = new Int32Array(cornerCount); for (let i = 0; i < cornerCount; ++i) opposite[i] = -1;
  const cornerToVertex = new Int32Array(cornerCount); for (let i = 0; i < cornerCount; ++i) cornerToVertex[i] = -1;
  const vertexCorners = new Int32Array(Math.max(1, parsed.numEncodedVertices || 1)); for (let i = 0; i < vertexCorners.length; ++i) vertexCorners[i] = -1;

  function FaceOfCorner(c) { return Math.floor(c / 3); }
  function CornerLocalIndex(c) { return c % 3; }
  function Next(c) { const f = FaceOfCorner(c); return f * 3 + ((CornerLocalIndex(c) + 1) % 3); }
  function Previous(c) { const f = FaceOfCorner(c); return f * 3 + ((CornerLocalIndex(c) + 2) % 3); }
  function PosOpposite(c) { return opposite[c] >= 0 ? opposite[c] : -1; }
  function SwingLeft(c) { const opp = PosOpposite(c); if (opp < 0) return -1; return Next(opp); }
  function SetOppositeCorners(a, b) { if (a >= 0 && a < opposite.length) opposite[a] = b; if (b >= 0 && b < opposite.length) opposite[b] = a; }
  function MapCornerToVertex(corner, vert) { cornerToVertex[corner] = vert; if (vert >= 0 && vert < vertexCorners.length) vertexCorners[vert] = corner; }

  const facesA = [];
  const active_stack = [];
  // seed an initial active corner to avoid undefined stack access
  active_stack.push(0);
  // debug instrumentation
  const debug = !!opts.debug;
  const maxSteps = typeof opts.maxSteps === 'number' ? opts.maxSteps : 20000;
  const maxEvents = typeof opts.maxEvents === 'number' ? opts.maxEvents : 200;
  const events = [];
  let stepCounter = 0;
  let last_vert = -1;
  const topology_split_id = [];
  const split_active_corners = [];

  const TOPOLOGY_C = 0, TOPOLOGY_S = 1, TOPOLOGY_L = 3, TOPOLOGY_R = 5, TOPOLOGY_E = 7;
  const LEFT_FACE_EDGE = 0, RIGHT_FACE_EDGE = 1;

  // Build topology split map (encoder-side) so we can query by encoder_symbol_id
  const splitMap = new Map();
  try {
    const numTopologySplits = parsed.numTopologySplits || 0;
    let last_id = 0;
    for (let j = 0; j < numTopologySplits; ++j) {
      const srcDelta = (parsed.sourceIdDelta && parsed.sourceIdDelta[j]) ? parsed.sourceIdDelta[j] : 0;
      last_id = last_id + srcDelta;
      const enc_split_id = last_id - ((parsed.splitIdDelta && parsed.splitIdDelta[j]) ? parsed.splitIdDelta[j] : 0);
      const split_edge = (parsed.sourceEdgeBit && parsed.sourceEdgeBit[j]) ? RIGHT_FACE_EDGE : LEFT_FACE_EDGE;
      splitMap.set(enc_split_id, { split_edge, enc_split_id });
    }
  } catch (e) {}

  function IsTopologySplit(encoder_symbol_id) {
    if (splitMap.has(encoder_symbol_id)) {
      const v = splitMap.get(encoder_symbol_id);
      splitMap.delete(encoder_symbol_id);
      return [v.split_edge, v.enc_split_id];
    }
    return null;
  }

  const numSymbols = parsed.numEncodedSymbols || 0;
  let last_symbol = TOPOLOGY_E; // init to something
  function NewActiveCornerReached(new_corner, symbol_id) {
    let check_topology_split = false;
    switch (last_symbol) {
      case TOPOLOGY_C: {
        const corner_a = active_stack[active_stack.length - 1];
        let corner_b = Previous(corner_a);
        let safety1 = 100000;
        while (corner_b >= 0 && PosOpposite(corner_b) !== -1 && safety1-- > 0) { const b_opp = PosOpposite(corner_b); corner_b = Previous(b_opp); }
        if (safety1 <= 0) { console.warn('NewActiveCornerReached: safety1 exceeded for TOPOLOGY_C'); }
        SetOppositeCorners(corner_a, new_corner + 1);
        SetOppositeCorners(corner_b, new_corner + 2);
        active_stack[active_stack.length - 1] = new_corner;
        const vert = cornerToVertex[ Next(corner_a) ];
        const next = cornerToVertex[ Next(corner_b) ];
        const prev = cornerToVertex[ Previous(corner_a) ];
        face_to_vertex_push(vert, next, prev);
        MapCornerToVertex(new_corner, vert < 0 ? 0 : vert);
        MapCornerToVertex(new_corner + 1, next < 0 ? 0 : next);
        MapCornerToVertex(new_corner + 2, prev < 0 ? 0 : prev);
      } break;
      case TOPOLOGY_S: {
        const corner_b = active_stack.pop();
        for (let ii = 0; ii < topology_split_id.length; ++ii) {
          if (topology_split_id[ii] === symbol_id) active_stack.push(split_active_corners[ii]);
        }
        const corner_a = active_stack[active_stack.length - 1];
        SetOppositeCorners(corner_a, new_corner + 2);
        SetOppositeCorners(corner_b, new_corner + 1);
        active_stack[active_stack.length - 1] = new_corner;
        const vert = cornerToVertex[ Previous(corner_a) ];
        const next = cornerToVertex[ Next(corner_a) ];
        const prev = cornerToVertex[ Previous(corner_b) ];
        MapCornerToVertex(new_corner, vert < 0 ? 0 : vert);
        MapCornerToVertex(new_corner + 1, next < 0 ? 0 : next);
        MapCornerToVertex(new_corner + 2, prev < 0 ? 0 : prev);
  const corner_n = Next(corner_b);
  const vertex_n = cornerToVertex[corner_n];
        ReplaceVerts && ReplaceVerts(vertex_n, vert);
        face_to_vertex_push(vert, next, prev);
      } break;
      case TOPOLOGY_R: {
        const corner_a = active_stack[active_stack.length - 1];
        const opp_corner = new_corner + 2;
        SetOppositeCorners(opp_corner, corner_a);
        active_stack[active_stack.length - 1] = new_corner;
        check_topology_split = true;
        const vert = cornerToVertex[ Previous(corner_a) ];
        const next = cornerToVertex[ Next(corner_a) ];
        const prev = ++last_vert;
        face_to_vertex_push(vert, next, prev);
        MapCornerToVertex(new_corner + 2, prev);
        MapCornerToVertex(new_corner, vert < 0 ? 0 : vert);
        MapCornerToVertex(new_corner + 1, next < 0 ? 0 : next);
      } break;
      case TOPOLOGY_L: {
        const corner_a = active_stack[active_stack.length - 1];
        const opp_corner = new_corner + 1;
        SetOppositeCorners(opp_corner, corner_a);
        active_stack[active_stack.length - 1] = new_corner;
        check_topology_split = true;
        const vert = cornerToVertex[ Next(corner_a) ];
        const next = ++last_vert;
        const prev = cornerToVertex[ Previous(corner_a) ];
        face_to_vertex_push(vert, next, prev);
        MapCornerToVertex(new_corner + 2, prev < 0 ? 0 : prev);
        MapCornerToVertex(new_corner, vert < 0 ? 0 : vert);
        MapCornerToVertex(new_corner + 1, next);
      } break;
      case TOPOLOGY_E: {
        active_stack.push(new_corner);
        check_topology_split = true;
        const vert = last_vert + 1;
        const next = vert + 1;
        const prev = next + 1;
        face_to_vertex_push(vert, next, prev);
        last_vert = prev;
        MapCornerToVertex(new_corner, vert);
        MapCornerToVertex(new_corner + 1, next);
        MapCornerToVertex(new_corner + 2, prev);
      } break;
    }
    if (check_topology_split) {
      let encoder_symbol_id = (parsed.numEncodedSymbols || numSymbols) - symbol_id - 1;
      let safety2 = 100000;
      while (safety2-- > 0) {
        const sp = IsTopologySplit(encoder_symbol_id);
        if (!sp) break;
        const [ split_edge, enc_split_id ] = sp;
        const act_top_corner = active_stack[ active_stack.length - 1 ];
        const new_active_corner = (split_edge === RIGHT_FACE_EDGE) ? Next(act_top_corner) : Previous(act_top_corner);
        const dec_split_id = (parsed.numEncodedSymbols || numSymbols) - enc_split_id - 1;
        topology_split_id.push(dec_split_id);
        split_active_corners.push(new_active_corner);
      }
      if (safety2 <= 0) console.warn('NewActiveCornerReached: topology split safety exceeded');
    }
  }

  function face_to_vertex_push(a,b,c) { facesA.push([a < 0 ? 0 : a, b < 0 ? 0 : b, c < 0 ? 0 : c]); }

  // Defer replacements to avoid O(n^2) behavior: record mappings and apply once at the end.
  const replaceMap = new Map();
  function ReplaceVerts(from, to) {
    // record mapping chain (from -> to). If there was an existing mapping for 'to', preserve chain.
    replaceMap.set(from, to);
  }

  let overallSafety = 500000; // hard cap on symbol processing to avoid runaway loops
  const startTime = Date.now();
  const timeLimitMs = 3000; // abort after 3s
  for (let i = 0; i < numSymbols; ++i) {
    if (--overallSafety <= 0) {
      console.warn('decodeEdgeBreakerFaces: overall safety cap reached, falling back to deterministic traversal');
      try {
        const decoded = decodeSymbolsHeuristic(parsed.symbolBuffer, parsed.numEncodedSymbols);
        return traverseConnectivity(parsed, decoded);
      } catch (e) {
        return traverseConnectivity(parsed, null);
      }
    }
    stepCounter++;
    if (stepCounter > maxSteps) {
      console.warn('decodeEdgeBreakerFaces: stepCounter exceeded maxSteps, aborting');
      break;
    }
    let symbol;
    try {
      symbol = br.readBits(1);
      if (symbol !== TOPOLOGY_C) {
        const suffix = br.readBits(2);
        symbol |= (suffix << 1);
      }
    } catch (e) {
      // bitstream exhausted; stop early
      break;
    }

    if (debug && events.length < maxEvents) events.push({ step: stepCounter, idx: i, before: { active_stack_len: active_stack.length, last_vert } });
    last_symbol = symbol;
    // quick time-based bailout
    if ((Date.now() - startTime) > timeLimitMs) {
      console.warn('decodeEdgeBreakerFaces: time cap reached, falling back to deterministic traversal');
      break;
    }

    const corner = 3 * i;
    const new_corner = corner;
    // Delegate symbol handling to NewActiveCornerReached (single authoritative implementation)
    NewActiveCornerReached(new_corner, i);
    if (debug && events.length < maxEvents) events.push({ step: stepCounter, idx: i, after: { active_stack_len: active_stack.length, faces: facesA.length, last_vert } });
  }

  // Apply any deferred ReplaceVerts mappings once when finalizing faces.
  function resolveMapping(v) {
    let cur = v;
    const seen = new Set();
    while (replaceMap.has(cur) && !seen.has(cur)) {
      seen.add(cur);
      cur = replaceMap.get(cur);
    }
    return cur;
  }
  const faces = new Uint32Array(facesA.length * 3);
  for (let i = 0; i < facesA.length; ++i) {
    faces[3*i+0] = Math.max(0, resolveMapping(facesA[i][0]));
    faces[3*i+1] = Math.max(0, resolveMapping(facesA[i][1]));
    faces[3*i+2] = Math.max(0, resolveMapping(facesA[i][2]));
  }

  return { faces, numVertices: Math.max(1, last_vert + 1), cornerToVertex, opposite };
}

API.decodeEdgeBreakerFaces = decodeEdgeBreakerFaces;


// Small rANS encoder/decoder (BigInt-based) for roundtrip testing.
class Rans {
  // Encode an array of symbol indices given freqs array (Uint32Array).
  static encode(symbols, freqs) {
    const S = freqs.length;
    let total = 0n; for (let i = 0; i < S; ++i) total += BigInt(freqs[i]);
    const cdf = new BigInt64Array(S + 1);
    cdf[0] = 0n; for (let i = 0; i < S; ++i) cdf[i+1] = cdf[i] + BigInt(freqs[i]);
    const TOT = total;
    let state = 1n;
    const out = [];
    const RENORM = 1n << 24n;
    // encode symbols in reverse order
    for (let idx = symbols.length - 1; idx >= 0; --idx) {
      const s = symbols[idx];
      const freq = BigInt(freqs[s]);
      const cLow = cdf[s];
      // renormalize: emit bytes while state >= RENORM * freq
      while (state >= (RENORM * freq)) {
        out.push(Number(state & 0xFFn));
        state >>= 8n;
      }
      // state = floor(state / freq) * TOT + (state % freq) + cLow
      const quo = state / freq;
      const rem = state % freq;
      state = quo * TOT + rem + cLow;
    }
    // flush remaining state bytes (least-significant first)
    while (state > 0n) { out.push(Number(state & 0xFFn)); state >>= 8n; }
    return new Uint8Array(out);
  }

  // Decode given stream bytes (tail-encoded) and freqs to produce `outLen` symbols
  static decode(stream, freqs, outLen) {
    const S = freqs.length;
    let total = 0n; for (let i = 0; i < S; ++i) total += BigInt(freqs[i]);
    const cdf = new BigInt64Array(S + 1);
    cdf[0] = 0n; for (let i = 0; i < S; ++i) cdf[i+1] = cdf[i] + BigInt(freqs[i]);
    const TOT = total;
    // stream is little-endian tail; build state from last up to 4 bytes
    let sp = stream.length; let state = 0n;
    for (let i = 0; i < 4 && sp > 0; ++i) state = (state << 8n) | BigInt(stream[--sp]);
    const out = new Uint32Array(outLen);
    for (let k = 0; k < outLen; ++k) {
      if (state === 0n) throw new Error('ANS decode state zero');
      const resid = Number(state % TOT);
      // binary search cdf
      let lo = 0, hi = S;
      while (lo < hi) {
        const mid = (lo + hi) >> 1;
        if (Number(cdf[mid+1]) <= resid) lo = mid + 1; else hi = mid;
      }
      const sIdx = lo;
      out[k] = sIdx;
      const freq = BigInt(freqs[sIdx]);
      const cLow = cdf[sIdx];
      state = freq * (state / TOT) + (state % TOT) - cLow;
      while (state < (1n << 24n) && sp > 0) state = (state << 8n) | BigInt(stream[--sp]);
    }
    return out;
  }
}

// Export Rans for tests
API.Rans = Rans;
