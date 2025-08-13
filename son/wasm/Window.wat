
    (alias $WindowEvent:new             $WindowEvent:new<ref>ref)
    (alias $wasm.Window:new             $wasm.Window:new<i32>ref)
    (global $wasm.Window<Class>                       mut extern)

    (global $wasm.EVENT_TYPE_WINDOW   i32 i32(1))
    (global $wasm.EVENT_NAME_WINDOW     "window")
    
    (func $wasm.Window<Class>
        (result $class <Class>)

        (if (null === global($wasm.Window<Class>))
            (then
                global($wasm.Window<Class>
                    $wasm.ExtendPointerClass(
                        text("Window")
                    )
                )
            )
        )

        global($wasm.Window<Class>)
    )

    (global $WindowEvent<Class>       mut extern)
    
    (func $WindowEvent<Class>
        (result $class <Class>)

        (if (null === global($WindowEvent<Class>))
            (then
                (global.set $WindowEvent<Class>
                    (call $self.Reflect.apply<refx3>ref
                        (call $self.Function<ref>ref
                            text("return class WindowEvent extends CustomEvent {
                                    constructor ( detail ) {
                                        super( 'window', { detail })
                                    } 

                                    get target () { return this.detail }                       
                                }
                            ")  
                        )
                        null
                        $self.Array<>ref()
                    )
                )
            )
        )

        global($WindowEvent<Class>)
    )

    (func $WindowEvent:new<ref>ref
        (param $window           <WindowPointer>)
        (result $event             <WindowEvent>)

        $self.Reflect.construct<refx2>ref(
            $WindowEvent<Class>() $Array:new<ref>ref( this )
        )
    )

    (func $wasm.Window:new<i32>ref
        (param $offset i32)
        (result $Pointer <Pointer>)
        (call $self.Reflect.construct<refx2>ref
            $wasm.Window<Class>() 
            $self.Array.of<i32>ref( 
                local($offset)   
            )
        )
    )