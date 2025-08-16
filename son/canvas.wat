(module 
    (memory 100)
    (global $self.name ref)

    (include "self/Array.wat")
    (include "self/Crypto.wat")
    (include "self/TypedArray.wat")
    (include "self/RegExp.wat")
    (include "self/String.wat")
    (include "self/Math.wat")
    (include "self/Number.wat")
    (include "self/EventTarget.wat")
    (include "self/Object.wat")

    (include "core/self.wat")
    (include "core/uuid.wat")

    (start $main
        (if (i32.eqz $isUuidString( global($self.name) ))
            (then (set <refx3> self text("name") $randomUUID<>ref()))
        )

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