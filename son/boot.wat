(module 
    (memory 100)

    (global $memory mut extern)
    (global $buffer mut extern)
    (global $assign mut extern)

    (global $self.name ref)
    (global $self.location.hash ref)
    (global $deviceUuid (mut v128) (v128.const f32x4 0 0 0 0))

    (include "self/Array.wat")
    (include "self/Object.wat")
    (include "self/Memory.wat")
    (include "self/String.wat")
    (include "self/Number.wat")
    (include "self/Buffer.wat")
    (include "self/RegExp.wat")
    (include "self/DataView.wat")
    (include "self/Math.wat")
    (include "self/Crypto.wat")
    (include "self/TypedArray.wat")
    (include "self/EventTarget.wat")

    (include "core/self.wat")
    (include "core/uuid.wat")

    (start $boot
        global($memory $Memory:new<i32x3>ref( i32(10) i32(10) true ) )
        global($buffer $Memory:buffer( global($memory) ) )
        global($assign $Object.fromEntries<ref>ref(
            $Array.of<ref>ref(
                $Array.of<ref.ref>ref( text("memory") global($memory) )
            )
        ))


        (if (i32.eqz $isUuidString( global($self.name) ))
            (then (set <refx3> self text("name") $randomUUID<>ref()))
        )

        (if (call $self.isNaN<ref>i32 global($self.location.hash))
            (then $wasm:mac<ref>( global($assign) ) )
            (else $wasm:ref<ref>( global($assign) ) )
        )
    )

    (data $wasm:ref "wasm://ref.wat")
    (data $wasm:mac "wasm://mac.wat")
)