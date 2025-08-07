(module 
    (memory 100)

    (start $boot
        $wasm:os/window<ref>ref(
            $self.Object.fromEntries<ref>ref(
                $self.Array.of<ref>ref(
                    $self.Array.of<ref.ref>ref( 
                        text("memory")
                        new $self.WebAssembly.Memory<ref>ref( 
                            $self.Object.fromEntries<ref>ref(
                                $self.Array.of<refx3>ref(
                                    $self.Array.of<ref.i32>ref( text("initial") i32(10))
                                    $self.Array.of<ref.i32>ref( text("maximum") i32(10))
                                    $self.Array.of<ref.i32>ref( text( "shared")  true  )
                                )
                            )
                        )
                    )
                )
            )
        )

        (log<ref>)
    )

    (data $wasm:os/window "wasm://os.window.wat")
)