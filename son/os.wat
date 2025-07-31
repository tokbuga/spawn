(module 
    (memory $buffer 1)
    (global $self.WebAssembly ref)
    (global $self.WebAssembly.instantiate ref)

    (global $dev/memory<Module>         mut extern)
    (global $dev/memory<Memory>         mut extern)
    (global $dev/memory<Buffer>         mut extern)
    (global $dev/memory<Instance>       mut extern)
    (global $dev/memory<Uint8Array>     mut extern)

    (global $dev/ethernet<Module>       mut extern)
    (global $dev/ethernet<Instance>     mut extern)
    (global $dev/ethernet<Functions>    mut extern)


    (start $boot
        $init:memory()
        $init:ethernet()
    )

    (func $init:memory
        (async 
            (apply $self.WebAssembly.compile<ref>ref 
                global($self.WebAssembly) 
                (param global($wasm:memory))
            )
            (then $onmodule     (param ref) (result ref) 
                (global.set $dev/memory<Module> this)
                (call $instantiate<ref>ref this)
            )
            (then $oninstance   (param ref) (result ref) 
                (global.set $dev/memory<Instance> this)
                (get <refx2>ref this text("exports"))
            )
            (then $onexports    (param ref) (result ref)
                (get <refx2>ref this text("memory"))
            )
            (then $onmemory     (param ref) (result ref)
                (global.set $dev/memory<Memory> this)
                (set <refx3> self text("memory") this)
                (get <refx2>ref this text("buffer"))
            )
            (then $ongetbuffer  (param ref) (result ref)
                (global.set $dev/memory<Buffer> this)
                (new $self.Uint8Array<ref>ref this)
            )
            (then $onarrayview  (param ref)
                (global.set $dev/memory<Uint8Array> this)
            )
            (then $done
                (warn<refx2>
                    text("memory:")
                    (call $self.Array.of<refx5>ref 
                        global($dev/memory<Module>)
                        global($dev/memory<Instance>)
                        global($dev/memory<Memory>)
                        global($dev/memory<Buffer>)
                        global($dev/memory<Uint8Array>)                
                    )
                )
            )
        )
    )

    (func $init:ethernet
        (async 
            (apply $self.WebAssembly.compile<ref>ref 
                global($self.WebAssembly) 
                (param global($wasm:ethernet))
            )
            (then $onmodule     (param ref) (result ref) 
                (global.set $dev/ethernet<Module> this)
                (call $instantiate<ref>ref this)
            )
            (then $oninstance   (param ref) (result ref) 
                (global.set $dev/ethernet<Instance> this)
                (get <refx2>ref this text("exports"))
            )
            (then $onexports    (param ref) 
                (global.set $dev/ethernet<Functions> this)
            )
            (then $done
                (warn<refx2>
                    text("ethernet:")
                    (call $self.Array.of<refx3>ref 
                        global($dev/ethernet<Module>)
                        global($dev/ethernet<Instance>)
                        global($dev/ethernet<Functions>)
                    )
                )
            )
        )
    )

    (func $instantiate<ref>ref
        (param $module ref)
        (result ref)

        (call $self.Reflect.apply<refx3>ref 
            global($self.WebAssembly.instantiate) 
            global($self.WebAssembly) 
            (call $self.Array.of<refx2>ref this self)
        )
    )

    (data $wasm:memory "wasm://memory.wat")
    (data $wasm:ethernet "wasm://ethernet.wat")
)