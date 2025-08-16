addEventListener("message", e => 
    WebAssembly.instantiate(e.data.module, Object.assign(self, e.data)
), {once: true})