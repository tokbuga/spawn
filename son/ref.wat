(module 
    (import "self" "memory" (memory $memory 10 10 shared))
    (import "memory" "buffer" (global $buffer externref))

    (alias $ref $ref<ref>i32)
    (alias $deref $deref<i32>ref)
    (alias $malloc $malloc<i32>i32)

    (include "self/Array.wat")
    (include "self/Object.wat")
    (include "self/WeakMap.wat")
    (include "self/WeakRef.wat")
    (include "self/TypedArray.wat")

    (global $weak<Map> new WeakMap)
    (global $view<Memory> mut extern)

    (table $ref 1 65536 externref)

    (start $main

        drop($malloc(i32(16)))
        global($view<Memory> 
            $Uint8Array:new(global($buffer))
        )

        (log global($view<Memory>))
    )

    (func $malloc<i32>i32 
        (param $length                  i32) 
        (result $offset                 i32) 

        (i32.atomic.rmw.add i32(0) local($length))
    )


    (func $deref<i32>ref 
        (param $index                    i32)
        (result $value              <Object>)

        $WeakRef:deref<ref>ref( get($ref local($index)) )
    )

    (func $ref<ref>i32 
        (param $value               <Object>)
        (result $index                   i32)

        (if (null === this)
            (then false return)
        )

        (if (call $WeakMap:hasnt<refx2>i32 
                global($weak<Map>) local($value) 
            )
            (then 
                $WeakMap:set<refx2.i32>(
                    global($weak<Map>) 
                    local($value) 
                    grow($ref 
                        $WeakRef:new<ref>ref(
                            local($value)
                        ) 
                        true
                    )
                )
            )
        )

        $WeakMap:get<refx2>i32(
            global($weak<Map>) local($value) 
        )
    )
)
