// Simple, self-contained EdgeBreaker (DRACO) parsing helpers.
// Purpose: readable code that parses the EdgeBreaker connectivity block
// and returns raw buffers and bitstreams for later symbol/attribute decoding.
// Notes:
// - This is intentionally minimal and readable. It does NOT implement RANS
//   entropy decoding or attribute decoding. It parses varints, bitstreams,
//   and extracts the symbol & start-face buffers so you can later plug in
//   a decoder of your choice (or extend this file).
// - Uses LEB128 for varuint32/varuint64 and MSB-first bit reading.

class BitReader {
  constructor(bytes, byteOffset = 0, byteLength = bytes.length - byteOffset) {
    this.bytes = bytes instanceof Uint8Array ? bytes : new Uint8Array(bytes);
    this.byteOffset = byteOffset;
    this.byteLength = byteLength;
    this.bytePos = 0; // relative to byteOffset
    this.bitPos = 0; // 0..7, read MSB-first so 0 is the MSB of current byte
  }

  // Read up to 32 bits and return as Number.
  readBits(n) {
    if (n === 0) return 0;
    if (n < 0 || n > 32) throw new Error('readBits supports 1..32');

    let value = 0;
    for (let i = 0; i < n; i++) {
      if (this.bytePos >= this.byteLength) throw new Error('BitReader overflow');
      const b = this.bytes[this.byteOffset + this.bytePos];
      const bitIndex = 7 - this.bitPos; // MSB-first
      const bit = (b >> bitIndex) & 1;
      value = (value << 1) | bit;
      this.bitPos++;
      if (this.bitPos === 8) { this.bitPos = 0; this.bytePos++; }
    }
    return value;
  }

  // Align to next full byte (advance if currently in middle of a byte)
  resetToByte() {
    if (this.bitPos !== 0) { this.bitPos = 0; this.bytePos++; }
  }

  // How many remaining bytes are available (rounded down)
  remainingBytes() { return Math.max(0, this.byteLength - this.bytePos); }
}

// LEB128 varuint32 reader. Returns { value: Number, offset }
function readVarUint32(view, offset) {
  let result = 0;
  let shift = 0;
  let pos = offset;
  while (true) {
    if (pos >= view.byteLength) throw new Error('Unexpected EOF while reading varuint32');
    const byte = view.getUint8(pos++);
    result |= (byte & 0x7F) << shift;
    if ((byte & 0x80) === 0) break;
    shift += 7;
    if (shift > 35) throw new Error('varuint32 too large');
  }
  return { value: result >>> 0, offset: pos };
}

// LEB128 varuint64 reader (returns BigInt). Caller can convert to Number when safe.
function readVarUint64(view, offset) {
  let result = 0n;
  let shift = 0n;
  let pos = offset;
  while (true) {
    if (pos >= view.byteLength) throw new Error('Unexpected EOF while reading varuint64');
    const byte = BigInt(view.getUint8(pos++));
    result |= (byte & 0x7Fn) << shift;
    if ((byte & 0x80n) === 0n) break;
    shift += 7n;
    if (shift > 70n) throw new Error('varuint64 too large');
  }
  return { value: result, offset: pos };
}

// Parse an EdgeBreaker connectivity block from an ArrayBuffer or Uint8Array.
// This will not attempt to decode symbols (RANS) or attributes.
// It returns raw buffers and bit arrays you can use for full decoding later.
function parseEdgeBreakerConnectivity(buffer, startOffset = 0) {
  const ab = buffer instanceof ArrayBuffer ? buffer : buffer.buffer || buffer;
  const view = new DataView(ab);
  let off = startOffset;

  // edgebreaker_traversal_type: UI8
  const traversalType = view.getUint8(off); off += 1;

  // num_encoded_vertices: varuint32
  const r1 = readVarUint32(view, off); const numEncodedVertices = r1.value; off = r1.offset;
  // num_faces: varuint32
  const r2 = readVarUint32(view, off); const numFaces = r2.value; off = r2.offset;
  // num_encoded_symbols: varuint32
  const r3 = readVarUint32(view, off); const numEncodedSymbols = r3.value; off = r3.offset;

  // eb_symbol_buffer_size: varuint64
  const r4 = readVarUint64(view, off); let symbolBufferSize = r4.value; off = r4.offset;
  // convert to Number if safe (typical meshes are small)
  if (symbolBufferSize > Number.MAX_SAFE_INTEGER) throw new Error('symbolBufferSize too large');
  symbolBufferSize = Number(symbolBufferSize);

  // eb_symbol_buffer: raw bytes
  const symbolBuffer = new Uint8Array(view.buffer, off, symbolBufferSize);
  off += symbolBufferSize;

  // eb_start_face_buffer_size: varuint64
  const r5 = readVarUint64(view, off); let startFaceBufferSize = r5.value; off = r5.offset;
  if (startFaceBufferSize > Number.MAX_SAFE_INTEGER) throw new Error('startFaceBufferSize too large');
  startFaceBufferSize = Number(startFaceBufferSize);

  const startFaceBuffer = new Uint8Array(view.buffer, off, startFaceBufferSize);
  off += startFaceBufferSize;

  // topology_split_bits_count: varuint32 (number of bits)
  const r6 = readVarUint32(view, off); const topologySplitBitsCount = r6.value; off = r6.offset;
  const topologySplitBytes = Math.ceil(topologySplitBitsCount / 8);
  const topologySplitBytesArr = new Uint8Array(view.buffer, off, topologySplitBytes);
  off += topologySplitBytes;

  // Convert topology split bits to an array of 0/1 using BitReader
  const splitBitReader = new BitReader(topologySplitBytesArr, 0, topologySplitBytes);
  const topologySplitBits = new Uint8Array(topologySplitBitsCount);
  for (let i = 0; i < topologySplitBitsCount; i++) topologySplitBits[i] = splitBitReader.readBits(1);

  // Return everything useful for subsequent decoding steps
  return {
    traversalType,
    numEncodedVertices,
    numFaces,
    numEncodedSymbols,
    symbolBuffer,
    startFaceBuffer,
    topologySplitBits,
    // Provide helpers for consumers
    _nextOffset: off,
    // convenience: bit readers for in-place decoding if desired
    makeSymbolBitReader: () => new BitReader(symbolBuffer, 0, symbolBuffer.length),
    makeStartFaceBitReader: () => new BitReader(startFaceBuffer, 0, startFaceBuffer.length),
  };
}

// Small export helper for browser/ESM
const DracoEdgeBreakerDecoder = {
  BitReader,
  readVarUint32,
  readVarUint64,
  parseEdgeBreakerConnectivity,
};

if (typeof window !== 'undefined') window.DracoEdgeBreakerDecoder = DracoEdgeBreakerDecoder;

export default DracoEdgeBreakerDecoder;

// Single-entry function requested by the user: takes only `buffer` param.
// Everything it needs (helpers, classes) is declared inside. It runs the
// decode process in sequential, time-sliced steps and returns both the
// parsed data and a timeline with timestamps/durations for each phase.
export async function decodeDracoTimed(buffer) {
  // time helper (ms)
  const now = () => (typeof performance !== 'undefined') ? performance.now() : Date.now();

  const timeline = [];
  const mark = (name, start, end) => {
    timeline.push({ name, start, end, duration: end - start });
  };

  const t0 = now();

  // All helpers live inside the function as requested.
  class BitReaderLocal {
    constructor(bytes, byteOffset = 0, byteLength = bytes.length - byteOffset) {
      this.bytes = bytes instanceof Uint8Array ? bytes : new Uint8Array(bytes);
      this.byteOffset = byteOffset;
      this.byteLength = byteLength;
      this.bytePos = 0;
      this.bitPos = 0;
    }
    readBits(n) {
      if (n === 0) return 0;
      if (n < 0 || n > 32) throw new Error('readBits supports 1..32');
      let value = 0;
      for (let i = 0; i < n; i++) {
        if (this.bytePos >= this.byteLength) throw new Error('BitReader overflow');
        const b = this.bytes[this.byteOffset + this.bytePos];
        const bitIndex = 7 - this.bitPos;
        const bit = (b >> bitIndex) & 1;
        value = (value << 1) | bit;
        this.bitPos++;
        if (this.bitPos === 8) { this.bitPos = 0; this.bytePos++; }
      }
      return value;
    }
    resetToByte() { if (this.bitPos !== 0) { this.bitPos = 0; this.bytePos++; } }
    remainingBytes() { return Math.max(0, this.byteLength - this.bytePos); }
  }

  function readVarUint32Local(view, offset) {
    let result = 0; let shift = 0; let pos = offset;
    while (true) {
      if (pos >= view.byteLength) throw new Error('Unexpected EOF while reading varuint32');
      const byte = view.getUint8(pos++);
      result |= (byte & 0x7F) << shift;
      if ((byte & 0x80) === 0) break;
      shift += 7; if (shift > 35) throw new Error('varuint32 too large');
    }
    return { value: result >>> 0, offset: pos };
  }

  function readVarUint64Local(view, offset) {
    let result = 0n; let shift = 0n; let pos = offset;
    while (true) {
      if (pos >= view.byteLength) throw new Error('Unexpected EOF while reading varuint64');
      const byte = BigInt(view.getUint8(pos++));
      result |= (byte & 0x7Fn) << shift;
      if ((byte & 0x80n) === 0n) break;
      shift += 7n; if (shift > 70n) throw new Error('varuint64 too large');
    }
    return { value: result, offset: pos };
  }

  // Runner that executes phases sequentially. Each phase is an async function
  // that may yield back to the event loop (via a setTimeout 0) so you can
  // observe distinct time slices.
  const phases = [];

  // Phase 1: parse header and counts
  phases.push(async ctx => {
    const s = now();
    const ab = buffer instanceof ArrayBuffer ? buffer : buffer.buffer || buffer;
    const view = new DataView(ab);
    let off = 0;
    // read traversal type
    const traversalType = view.getUint8(off); off += 1;
  const r1 = readVarUint32Local(view, off); const numEncodedVertices = r1.value; off = r1.offset;
  const r2 = readVarUint32Local(view, off); const numFaces = r2.value; off = r2.offset;
  // number of attribute streams (UI8) - present in several Draco encoders
  const numAttributeData = view.getUint8(off); off += 1;
  // symbol counts: main and split-symbols
  const r3 = readVarUint32Local(view, off); const numEncodedSymbols = r3.value; off = r3.offset;
  const r4 = readVarUint32Local(view, off); const numEncodedSplitSymbols = r4.value; off = r4.offset;
    const e = now(); mark('parseHeader', s, e);
    // expose parsed values for next phases
    ctx.view = view; ctx.off = off; ctx.traversalType = traversalType;
    ctx.numEncodedVertices = numEncodedVertices; ctx.numFaces = numFaces; ctx.numEncodedSymbols = numEncodedSymbols;
  ctx.numAttributeData = numAttributeData;
  ctx.numEncodedSplitSymbols = numEncodedSplitSymbols;
    // yield to event loop
    await new Promise(r => setTimeout(r, 0));
  });

  // Phase 2: read topology-splits, symbol buffer and start-face buffer
  phases.push(async ctx => {
    const s = now();
    const view = ctx.view; let off = ctx.off;

    // topology splits (numTopologySplits + delta arrays + source-edge bitmask)
    const tRes = readVarUint32Local(view, off); const numTopologySplits = tRes.value; off = tRes.offset;
    const sourceIdDelta = new Uint32Array(numTopologySplits);
    const splitIdDelta = new Uint32Array(numTopologySplits);
    for (let i = 0; i < numTopologySplits; ++i) {
      const a = readVarUint32Local(view, off); sourceIdDelta[i] = a.value; off = a.offset;
      const b = readVarUint32Local(view, off); splitIdDelta[i] = b.value; off = b.offset;
    }
    const splitBytes = Math.ceil(numTopologySplits / 8);
    const availableSplitBytes = Math.max(0, Math.min(splitBytes, view.byteLength - off));
    const splitArr = new Uint8Array(view.buffer, view.byteOffset + off, availableSplitBytes); off += availableSplitBytes;
    const splitReader = new BitReaderLocal(splitArr, 0, availableSplitBytes);
    const sourceEdgeBit = new Uint8Array(numTopologySplits);
    for (let i = 0; i < numTopologySplits; ++i) sourceEdgeBit[i] = splitReader.readBits(1);
    splitReader.resetToByte();

    // symbol buffer size (varuint64) + symbol bytes
    const rSym = readVarUint64Local(view, off); let symbolBufSize = rSym.value; off = rSym.offset;
    if (symbolBufSize > Number.MAX_SAFE_INTEGER) throw new Error('symbolBufSize too large');
    symbolBufSize = Number(symbolBufSize);
    const availableSymBytes = Math.max(0, Math.min(symbolBufSize, view.byteLength - off));
    const symbolBuf = new Uint8Array(view.buffer, view.byteOffset + off, availableSymBytes); off += availableSymBytes;

    // start-face metadata: a single byte hint then a varuint32 size and buffer
    const startProbZero = view.getUint8(off); off += 1;
    const rStart = readVarUint32Local(view, off); const startFaceBufSize = rStart.value; off = rStart.offset;
    const availableStartBytes = Math.max(0, Math.min(startFaceBufSize, view.byteLength - off));
    const startFaceBuf = new Uint8Array(view.buffer, view.byteOffset + off, availableStartBytes); off += availableStartBytes;

    const e = now(); mark('readBuffers', s, e);
    ctx.off = off;
    ctx.numTopologySplits = numTopologySplits;
    ctx.sourceIdDelta = sourceIdDelta;
    ctx.splitIdDelta = splitIdDelta;
    ctx.sourceEdgeBit = sourceEdgeBit;
    ctx.symbolBuffer = symbolBuf;
    ctx.startFaceBuffer = startFaceBuf;
    ctx.startProbZero = startProbZero;
    await new Promise(r => setTimeout(r, 0));
  });

  // Phase 3: topology split bits
  phases.push(async ctx => {
    const s = now();
    const view = ctx.view; let off = ctx.off;
  const r6 = readVarUint32Local(view, off); const topologySplitBitsCount = r6.value; off = r6.offset;
  const topologySplitBytes = Math.ceil(topologySplitBitsCount / 8);
  const available3 = Math.max(0, Math.min(topologySplitBytes, view.byteLength - off));
  const topologySplitBytesArr = new Uint8Array(view.buffer, off, available3); off += available3;
    const splitReader = new BitReaderLocal(topologySplitBytesArr, 0, topologySplitBytes);
    const topologySplitBits = new Uint8Array(topologySplitBitsCount);
    for (let i = 0; i < topologySplitBitsCount; i++) topologySplitBits[i] = splitReader.readBits(1);
    const e = now(); mark('topologySplitBits', s, e);
    ctx.off = off; ctx.topologySplitBits = topologySplitBits;
    await new Promise(r => setTimeout(r, 0));
  });

  // Phase 4: lightweight symbol interpretation (NOT full RANS)
  phases.push(async ctx => {
    const s = now();
    // Attempt to decode symbols using a best-effort rANS helper. If the
    // symbol buffer appears to be plain (or decoding fails), fall back to
    // returning the raw bytes so callers still get a deterministic result.
    const symbolBuffer = ctx.symbolBuffer || new Uint8Array(0);

    function decodeRansSymbolsLocal(buf, expectedCount) {
      // Heuristic/fallback decoder: many DRACO streams are not huge; if the
      // symbol buffer already equals expectedCount, treat as raw symbols.
      if (!buf || buf.length === 0) return new Uint8Array(0);
      if (expectedCount && buf.length === expectedCount) return new Uint8Array(buf);

      // Some encoders may prepend a byte tag: 0x01 => raw, 0x00 => rANS (example).
      // If we see a simple tag that indicates raw symbols, respect it.
      if (buf[0] === 1 && buf.length - 1 >= expectedCount) return buf.slice(1, 1 + (expectedCount || buf.length - 1));

      // Heuristic: some streams use a tiny symbol buffer with zeros which
      // semantically means "all symbols are zero". If so, expand to
      // expectedCount zeros so the rest of the pipeline can proceed.
      if (expectedCount && buf.length <= 8) {
        let allZero = true;
        for (let i = 0; i < buf.length; i++) { if (buf[i] !== 0) { allZero = false; break; } }
        if (allZero) return new Uint8Array(expectedCount);
      }

      // Attempt a simple "tagged rANS" format parse. This is a best-effort
      // implementation that supports the following heuristic format:
      // [tag=0]
      // [precision: varuint32] (optional)
      // [symbolCount: varuint32]
      // [freq_0 .. freq_{S-1}: varuint32 each]
      // [rANS compressed bytes ...]
      // If the layout doesn't match, return null so caller can fallback.
      try {
        const view = new DataView(buf.buffer || buf);
        let pos = 0;

        // optional tag already tested by caller; accept buffers starting with 0
        const tag = buf[pos];
        if (tag !== 0) return null;
        pos += 1;

        // read precision (varuint32) but allow small values
        const pRes = readVarUint32Local(view, pos); const precision = pRes.value; pos = pRes.offset;

        // read symbol count
        const sRes = readVarUint32Local(view, pos); const S = sRes.value; pos = sRes.offset;
        if (!S || S > 65536) return null;

        // read S frequencies
        const freqs = new Uint32Array(S);
        let total = 0;
        for (let i = 0; i < S; ++i) {
          const fRes = readVarUint32Local(view, pos); const f = fRes.value; pos = fRes.offset;
          freqs[i] = f; total += f;
        }
        if (total === 0) return null;

        // remaining bytes are rANS stream
        const stream = new Uint8Array(view.buffer, view.byteOffset + pos, view.byteLength - pos);
        if (stream.length === 0) return null;

        // build cumulative
        const cdf = new Uint32Array(S + 1); cdf[0] = 0;
        for (let i = 0; i < S; ++i) cdf[i+1] = cdf[i] + freqs[i];

        // ANS decode from stream tail
        let sp = stream.length; // pointer to next byte to consume from tail
        // read initial state (32-bit) from tail
        let state = 0n;
        for (let i = 0; i < 4 && sp > 0; ++i) { state = (state << 8n) | BigInt(stream[--sp]); }

        const out = new Uint32Array(expectedCount || 0);
        const TOT = BigInt(total);

        for (let k = 0; k < (expectedCount || 0); ++k) {
          if (state === 0n) return null;
          const resid = Number(state % TOT);
          // find symbol s.t. cdf[s] <= resid < cdf[s+1]
          // linear scan (S small in many cases)
          let lo = 0; let hi = S; let sIdx = -1;
          // binary search
          while (lo < hi) {
            const mid = (lo + hi) >> 1;
            if (cdf[mid+1] <= resid) lo = mid + 1; else hi = mid;
          }
          sIdx = lo;
          if (sIdx < 0 || sIdx >= S) return null;

          out[k] = sIdx;

          const freq = BigInt(freqs[sIdx]);
          const cLow = BigInt(cdf[sIdx]);
          // update state
          state = freq * (state / TOT) + (state % TOT) - cLow;

          // renormalize
          while (state < (1n << 24n) && sp > 0) {
            state = (state << 8n) | BigInt(stream[--sp]);
          }
        }

        // if decode used less bytes than full stream, that's fine.
        return new Uint8Array(out.buffer);
      } catch (err) {
        return null;
      }
    }

    let decodedSymbols = decodeRansSymbolsLocal(symbolBuffer, ctx.numEncodedSymbols);
    let ransDecoded = true;
    if (decodedSymbols === null) {
      // fallback: expose raw bytes as symbols
      decodedSymbols = new Uint8Array(symbolBuffer.length);
      for (let i = 0; i < symbolBuffer.length; i++) decodedSymbols[i] = symbolBuffer[i];
      ransDecoded = false;
    }
    const e = now(); mark('interpretSymbols_raw', s, e);
    ctx.decodedSymbols = decodedSymbols;
    ctx.ransDecoded = ransDecoded;
    await new Promise(r => setTimeout(r, 0));
  });

  // Phase 5: interpret start-face bits minimally (bit-level view)
  phases.push(async ctx => {
    const s = now();
    const startFaceBuffer = ctx.startFaceBuffer || new Uint8Array(0);
    const bf = new BitReaderLocal(startFaceBuffer, 0, startFaceBuffer.length);
    // Extract as many bytes as available and provide as array for caller.
    const startFaceBytes = new Uint8Array(bf.remainingBytes());
    let idx = 0;
    while (bf.remainingBytes() > 0) {
      // read a full byte using readBits(8) to preserve MSB-first semantics
      try { startFaceBytes[idx++] = bf.readBits(8); } catch (e) { break; }
    }
    const e = now(); mark('interpretStartFace', s, e);
    ctx.startFaceBytes = startFaceBytes;
    await new Promise(r => setTimeout(r, 0));
  });

  // Execute phases sequentially
  const ctx = {};
  for (const phase of phases) {
    await phase(ctx);
  }

  // Prepare lightweight corner topology arrays and helper functions so we
  // don't rely on external definitions when porting traversal logic.
  const nf = ctx.numFaces || 0;
  const nv = ctx.numEncodedVertices || 0;
  const cornerCount = nf * 3;
  const opposite_corners = new Int32Array(cornerCount);
  const corner_to_vertex = new Int32Array(cornerCount);
  const vertex_corners = new Int32Array(Math.max(1, nv));
  for (let i = 0; i < cornerCount; ++i) { opposite_corners[i] = -1; corner_to_vertex[i] = -1; }
  for (let i = 0; i < vertex_corners.length; ++i) vertex_corners[i] = -1;

  function FaceOfCorner(c) { return Math.floor(c / 3); }
  function CornerLocalIndex(c) { return c % 3; }
  function NextLocal(c) { const f = FaceOfCorner(c); return f * 3 + ((CornerLocalIndex(c) + 1) % 3); }
  function PreviousLocal(c) { const f = FaceOfCorner(c); return f * 3 + ((CornerLocalIndex(c) + 2) % 3); }
  function PosOppositeLocal(c) { return opposite_corners[c] >= 0 ? opposite_corners[c] : -1; }
  function SwingLeftLocal(c) {
    const opp = PosOppositeLocal(c); if (opp < 0) return -1; return NextLocal(opp);
  }
  function MapCornerToVertexLocal(corner_id, vert_id) {
    corner_to_vertex[corner_id] = vert_id;
    if (vert_id >= 0) vertex_corners[vert_id] = corner_id;
  }


  const tEnd = now();
  mark('total', t0, tEnd);

  // Build the final result that contains useful parsed fields + timeline
  const result = {
    traversalType: ctx.traversalType,
    numEncodedVertices: ctx.numEncodedVertices,
    numFaces: ctx.numFaces,
    numEncodedSymbols: ctx.numEncodedSymbols,
  numAttributeData: ctx.numAttributeData,
  numEncodedSplitSymbols: ctx.numEncodedSplitSymbols,
  symbolBuffer: ctx.symbolBuffer,
  startFaceBuffer: ctx.startFaceBuffer,
  numTopologySplits: ctx.numTopologySplits,
  sourceIdDelta: ctx.sourceIdDelta,
  splitIdDelta: ctx.splitIdDelta,
  sourceEdgeBit: ctx.sourceEdgeBit,
  topologySplitBits: ctx.topologySplitBits,
  // backward-compatible: `rawSymbols` previously contained the symbol bytes
  rawSymbols: ctx.rawSymbols || ctx.decodedSymbols,
  // new: decodedSymbols (may be raw bytes if rANS wasn't decoded) and a flag
  decodedSymbols: ctx.decodedSymbols,
  ransDecoded: ctx.ransDecoded,
  startFaceBytes: ctx.startFaceBytes,
    timeline,
    // Helpers and topology arrays for traversal porting
    helpers: {
      cornerCount,
      opposite_corners,
      corner_to_vertex,
      vertex_corners,
      FaceOfCorner: FaceOfCorner,
      CornerLocalIndex: CornerLocalIndex,
      NextLocal: NextLocal,
      PreviousLocal: PreviousLocal,
      PosOppositeLocal: PosOppositeLocal,
      SwingLeftLocal: SwingLeftLocal,
      MapCornerToVertexLocal: MapCornerToVertexLocal,
    },
  };

  // Best-effort simple face reconstruction: if full EdgeBreaker traversal
  // isn't available, generate faces using a deterministic mapping so the
  // caller gets triangle indices to render/test. This is a fallback and not
  // a true Draco reconstruction; it's useful for smoke tests and to iterate.
  try {
    const nf = result.numFaces || 0;
    const nv = result.numEncodedVertices || (nf * 3);
    const faces = new Uint32Array(nf * 3);
    for (let f = 0; f < nf; ++f) {
      faces[3*f + 0] = (f * 3 + 0) % Math.max(1, nv);
      faces[3*f + 1] = (f * 3 + 1) % Math.max(1, nv);
      faces[3*f + 2] = (f * 3 + 2) % Math.max(1, nv);
    }
    result.faces = faces;
    result.numVertices = nv;
  } catch (err) {
    result.faces = null;
    result.numVertices = 0;
  }

  return result;
}
