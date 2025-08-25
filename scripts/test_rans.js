import DracoDecoderMin from '../draco_decoder_min.js';

const freqs = new Uint32Array([10,20,30,40]);
const symbols = new Uint8Array([3,2,1,0,3,3,2,1,0,0,1,2]);
const enc = DracoDecoderMin.Rans.encode(symbols, freqs);
console.log('enc len', enc.length);
const dec = DracoDecoderMin.Rans.decode(enc, freqs, symbols.length);
console.log('dec', Array.from(dec));
console.log('match=', Array.from(dec).join(',') === Array.from(symbols).join(','));
