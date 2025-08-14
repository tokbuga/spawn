self.userScript = document.currentScript.textContent;

WebAssembly.instantiateStreaming(
    fetch('boot.wasm'), self
)