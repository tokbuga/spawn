(module 
    (memory 100)

    (start $main
        $window<ref>(
            $self.Object.fromEntries<ref>ref(
                $self.Array.of<ref>ref(
                    $self.Array.of<ref.ref>ref( 
                        text("memory")
                        (new $self.WebAssembly.Memory<ref>ref
                            $self.Object.fromEntries<ref>ref(
                                $self.Array.of<refx3>ref(
                                    $self.Array.of<ref.i32>ref( text("initial") i32(100) )
                                    $self.Array.of<ref.i32>ref( text("maximum") i32(100) )
                                    $self.Array.of<ref.i32>ref( text("shared") true )
                                )
                            )
                        )    
                    )
                )
            )
        )
    )

    (data $window "wasm://canvas.window.wat")
)