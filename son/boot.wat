(module 
    (memory 100)

    (global $memory mut extern)
    (global $buffer mut extern)

    (include "self/Array.wat")
    (include "self/Object.wat")
    (include "self/Memory.wat")
    (include "self/Buffer.wat")
    (include "self/DataView.wat")

    (start $boot

        global($memory $Memory:new<i32x3>ref( i32(10) i32(10) true ) )
        global($buffer $Memory:buffer( global($memory) ) )
        
        $wasm:ref<ref>(
            $Object.fromKeyValue<refx2>ref(
                text("memory") global($memory)
            )
        )
    )

    (data $wasm:ref "wasm://ref.wat")
)