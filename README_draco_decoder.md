Draco EdgeBreaker helper (simple)
================================

What this provides
- A small, self-contained JavaScript helper: `draco_decoder.js`.
- Parses the EdgeBreaker connectivity block from a DRACO stream and
  returns buffers and bit arrays needed for full decoding.
- Intentionally minimal: it does NOT implement entropy (RANS) or attribute
  decoding. It's designed to be easy to read and to integrate into other
  projects.

Key functions
- parseEdgeBreakerConnectivity(buffer, startOffset)
  - buffer: ArrayBuffer or Uint8Array containing the connectivity block
  - returns: { traversalType, numEncodedVertices, numFaces, numEncodedSymbols,
               symbolBuffer, startFaceBuffer, topologySplitBits, _nextOffset }

How to use
1. Include `draco_decoder.js` in your page or require it in Node.
2. Call `parseEdgeBreakerConnectivity` with the ArrayBuffer and offset
   pointing to the start of the EdgeBreaker connectivity block.
3. Use `symbolBuffer` and `startFaceBuffer` with your chosen symbol decoder.

Next steps (recommended)
- Implement or port a small RANS decoder to decode `symbolBuffer` into symbols.
- Implement attribute decoding using the Draco attribute streams.

Why this file
- You asked for standalone, simple code you can control and move. This
  file keeps parsing concerns separated from entropy and attribute decoding.

License
- Copy/modify as you like for personal projects.
