(module 
    (memory $buffer 1)

    (global $self.Promise ref)
    (global $self.Promise.all ref)
    (global $self.Promise:then ref)
    (global $self.Array ref)
    (global $self.Array:at ref)
    (global $self.WebAssembly ref)
    (global $self.WebAssembly.compile ref)
    (global $self.WebAssembly.instantiate ref)
    (global $self.WebAssembly.Module ref)
    (global $self.WebAssembly.Module.exports ref)

    (global $dev/memory                 mut extern)
    (global $dev/memory<Module>         mut extern)
    (global $dev/memory<Memory>         mut extern)
    (global $dev/memory<Buffer>         mut extern)
    (global $dev/memory<Instance>       mut extern)
    (global $dev/memory<exports>        mut extern)
    (global $dev/memory<Uint8Array>     mut extern)

    (global $dev/ethernet               mut extern)
    (global $dev/ethernet<Module>       mut extern)
    (global $dev/ethernet<Instance>     mut extern)
    (global $dev/ethernet<exports>      mut extern)

    (global $dev/clock                  mut extern)
    (global $dev/clock<Module>          mut extern)
    (global $dev/clock<Instance>        mut extern)
    (global $dev/clock<exports>         mut extern)

    (global $dev/storage                mut extern)
    (global $dev/storage<Module>        mut extern)
    (global $dev/storage<Instance>      mut extern)
    (global $dev/storage<exports>       mut extern)

    (global $sys/event                  mut extern)    
    (global $sys/event<Module>          mut extern)
    (global $sys/event<Instance>        mut extern)
    (global $sys/event<exports>         mut extern)    
    
    (global $nil                        mut extern)    
    (global $nil/array                  mut extern)    
    (global $nil/object                 mut extern)    
    (global $nil/number                 mut extern)    

    (global $imports                    mut extern)

    (start $boot
        $settle:globals()

        $Promise:then<ref.fun>( 
            $Promise.all<ref>ref( 
                $self.Array.of<refx5>ref(
                    $WebAssembly.compile<ref>ref( global($wasm:dev/memory) )
                    $WebAssembly.compile<ref>ref( global($wasm:dev/clock) )
                    $WebAssembly.compile<ref>ref( global($wasm:dev/storage) )
                    $WebAssembly.compile<ref>ref( global($wasm:dev/ethernet) )
                    $WebAssembly.compile<ref>ref( global($wasm:sys/event) )
                )
            )
            func($onallcompile<ref>) 
        )
    )

    (func $settle:globals
        (global.set $dev/memory $self.Object<>ref())   
        (global.set $dev/clock $self.Object<>ref())   
        (global.set $dev/storage $self.Object<>ref())   
        (global.set $dev/ethernet $self.Object<>ref())   
        (global.set $sys/event $self.Object<>ref())   

        (global.set $nil 
            $self.Object.fromEntries<ref>ref(
                $self.Array.of<refx3>ref(
                    $self.Array.of<refx2>ref( text("array") $self.Array<>ref() )
                    $self.Array.of<refx2>ref( text("object") $self.Object<>ref() )
                    $self.Array.of<refx2>ref( text("number") $self.Number<>ref() )
                )
            )
        )   

        (global.set $imports 
            $self.Object.fromEntries<ref>ref(
                $self.Array.of<refx7>ref(
                    $self.Array.of<refx2>ref( text("SHARED_MEMORY")
                        $WebAssembly.Memory<i32x3>ref(
                            i32(1) i32(1) i32(1)
                        )
                    )
                    $self.Array.of<refx2>ref( text("memory") global($dev/memory) )
                    $self.Array.of<refx2>ref( text("clock") global($dev/clock) )
                    $self.Array.of<refx2>ref( text("storage") global($dev/storage) )
                    $self.Array.of<refx2>ref( text("ethernet") global($dev/ethernet) )
                    $self.Array.of<refx2>ref( text("sys/event") global($sys/event) )
                    $self.Array.of<refx2>ref( text("nil") global($nil) )
                )
            )
        )  
    )
    
    (func $WebAssembly.Module.exports<ref>ref
        (param $module ref)
        (result ref)

        $self.Reflect.apply<refx3>ref( 
            global($self.WebAssembly.Module.exports)
            global($self.WebAssembly.Module) 
            $self.Array.of<ref>ref( this )
        )
    )

    (func $WebAssembly.instantiate<refx2>ref
        (param $module ref)
        (param $imports ref)
        (result ref)

        $self.Reflect.apply<refx3>ref( 
            global($self.WebAssembly.instantiate)
            global($self.WebAssembly) 
            $self.Array.of<refx2>ref(
                local($module)
                $self.Object.assign<refx2>ref( self local($imports) )
            )
        )
    )

    (func $WebAssembly.compile<ref>ref
        (param $wasm ref)
        (result ref)

        $self.Reflect.apply<refx3>ref( 
            global($self.WebAssembly.compile)
            global($self.WebAssembly) 
            $self.Array.of<ref>ref( local($wasm) )
        )
    )

    (func $Promise.all<ref>ref
        (param $promises ref)
        (result ref)

        $self.Reflect.apply<refx3>ref( 
            global($self.Promise.all)
            global($self.Promise) 
            $self.Array.of<ref>ref( local($promises) )
        )
    )

    (func $Promise:then<ref.fun>
        (param $promise ref)
        (param $resolve funcref)

        $self.Reflect.apply<refx3>( 
            global($self.Promise:then)
            this 
            $self.Array.of<fun>ref( local($resolve) )
        )
    )

    (func $Promise:then<ref.fun>ref
        (param $promise ref)
        (param $resolve funcref)
        (result ref)

        $self.Reflect.apply<refx3>ref( 
            global($self.Promise:then)
            this 
            $self.Array.of<fun>ref( local($resolve) )
        )
    )

    (func $Array:at<ref.i32>ref
        (param $array ref)
        (param $index i32)
        (result ref)

        $self.Reflect.apply<refx3>ref( 
            global($self.Array:at)
            this 
            $self.Array.of<i32>ref( local($index) )
        )
    )

    (func $WebAssembly.Memory<i32x3>ref
        (param $initial i32)
        (param $maximum i32)
        (param $shared  i32)
        (result ref)

        (new $self.WebAssembly.Memory<ref>ref 
            $self.Object.fromEntries<ref>ref(
                $self.Array.of<refx3>ref(
                    $self.Array<ref.i32>ref( text("initial") local($initial))
                    $self.Array<ref.i32>ref( text("maximum") local($maximum))
                    $self.Array<ref.i32>ref( text("shared")  local($shared))
                )
            )
        )
    )

    (func $Uint8Array<ref>ref
        (param $buffer ref)
        (result ref)
        (new $self.Uint8Array<ref>ref this)
    )

    (func $exportsof (param ref) (result ref) (get <refx2>ref this text("exports")))

    (func $onallcompile<ref>
        (param $modules ref)

        (global.set $dev/memory<Module>     $Array:at<ref.i32>ref( this i32(0) ))
        (global.set $dev/clock<Module>      $Array:at<ref.i32>ref( this i32(1) ))
        (global.set $dev/storage<Module>    $Array:at<ref.i32>ref( this i32(2) ))
        (global.set $dev/ethernet<Module>   $Array:at<ref.i32>ref( this i32(3) ))        
        (global.set $sys/event<Module>      $Array:at<ref.i32>ref( this i32(4) ))    

        $instantiate:dev/memory() 
    )

    (func $ondeviceready
        (warn text("all instantiated"))
    )

    (func $onsystemready<ref>
        (param ref)
        (warn <refx2> text("os ready") this)
    )

    (func $instantiate:dev/clock 
        $Promise:then<ref.fun>( 
            $WebAssembly.instantiate<refx2>ref( 
                global($dev/clock<Module>) 
                global($imports) 
            )
            func($onclockinstance<ref>)
        )
    )

    (func $onclockinstance<ref> 
        (param ref)
        (error this)
                
        $self.Object.assign<refx2>( 
            global($dev/clock) 
            (get <refx2>ref this text("exports"))  
        )

        $instantiate:dev/storage()
    )

    (func $instantiate:dev/storage 
        $Promise:then<ref.fun>( 
            $WebAssembly.instantiate<refx2>ref( 
                global($dev/storage<Module>) 
                global($imports) 
            )
            func($onstorageinstance<ref>)
        )
    )

    (func $onstorageinstance<ref> 
        (param ref)
        (error this)
                
        $self.Object.assign<refx2>( 
            global($dev/storage) 
            (get <refx2>ref this text("exports"))  
        )

        $instantiate:dev/ethernet()
    )

    (func $instantiate:dev/memory 
        $Promise:then<ref.fun>( 
            $WebAssembly.instantiate<refx2>ref( 
                global($dev/memory<Module>) 
                global($imports) 
            )
            func($onmemoryinstance<ref>)
        )
    )

    (func $onmemoryinstance<ref> 
        (param ref)
        (warn this)
        (warn global($imports))
        
        $self.Object.assign<refx2>( 
            global($dev/memory) 
            (get <refx2>ref this text("exports")) 
        )

        $instantiate:dev/clock()
    )

    (func $instantiate:dev/ethernet 
        $Promise:then<ref.fun>( 
            $WebAssembly.instantiate<refx2>ref( 
                global($dev/ethernet<Module>) 
                global($imports) 
            )
            func($onethernetinstance<ref>)
        )
    )

    (func $onethernetinstance<ref> 
        (param ref)
        (error this)
        
        $self.Object.assign<refx2>( 
            global($dev/ethernet) 
            (get <refx2>ref this text("exports")) 
        )

        $ondeviceready()
    )

    (func $instantiate:sys/event 
        $Promise:then<ref.fun>( 
            $WebAssembly.instantiate<refx2>ref( 
                global($sys/event<Module>) 
                global($imports) 
            )
            func($oneventinstance<ref>)
        )
    )

    (func $oneventinstance<ref> 
        (param ref)
        (error this)
        
        $self.Object.assign<refx2>( 
            global($sys/event) 
            (get <refx2>ref this text("exports")) 
        )
    )

    (data $wasm:dev/memory "wasm://dev.memory.wat")
    (data $wasm:dev/clock "wasm://dev.clock.wat")
    (data $wasm:dev/storage "wasm://dev.storage.wat")
    (data $wasm:dev/ethernet "wasm://dev.ethernet.wat")
    (data $wasm:sys/event "wasm://sys.event.wat")
)