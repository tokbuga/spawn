(module 
    (import "self" "memory" (memory $memory 10 10 shared))
    (import "memory" "buffer" (global $buffer externref))

    (alias $ref $ref<ref>i32)
    (alias $deref $deref<i32>ref)
    (alias $malloc $malloc<i32>i32)
    (alias $randomUUID $randomUUID<>v128)
    (alias $toUuidString $toUuidString<v128>ref)

    (include "self/Array.wat")
    (include "self/Object.wat")
    (include "self/WeakMap.wat")
    (include "self/WeakRef.wat")
    (include "self/Math.wat")
    (include "self/Crypto.wat")
    (include "self/RegExp.wat")
    (include "self/String.wat")
    (include "self/Number.wat")
    (include "self/TypedArray.wat")

    (global $weak<Map> new WeakMap)
    (global $view<Memory> mut extern)

    (table $ref 1 65536 externref)

    (start $main

        drop($malloc(i32(16)))
        global($view<Memory> 
            $Uint8Array:new(global($buffer))
        )


        (log<ref>         
            $toUuidString(
                $randomUUID()
            )
        )
    )

    (func $toUuidString<v128>ref
        (param $value                       v128)
        (result $uuid                   <string>)
        (local $array                    <Array>)

        local($array 
            $Array:map<ref.fun>ref(
                $Array.from<ref>ref( 
                    $Uint8Array:new<v128>ref( this ) 
                )
                (func $toHexString (param i32) (result ref)
                    $String:padStart<ref.i32x2>ref(
                        $Number:toString<i32x2>ref(
                            local(0) i32(16)
                        )
                        i32(2)
                        i32(0)
                    )
                )
            )
        )

        local($array)x4

        $Array:splice<ref.i32x2.ref>( i32(10) i32(0) text("-"))
        $Array:splice<ref.i32x2.ref>(  i32(8) i32(0) text("-"))
        $Array:splice<ref.i32x2.ref>(  i32(6) i32(0) text("-"))
        $Array:splice<ref.i32x2.ref>(  i32(4) i32(0) text("-"))
        
        $Array:join<ref>ref( 
            local($array)
        )
    )

    (func $randomUUID<>v128
        (result                             v128)
        (local $view            <BigUint64Array>)
        (local $struuid                 <String>)
        (local $regexp                  <RegExp>)
        (local $match                    <Array>)
        (local $byteArray           <Uint8Array>)
        (local $uuid                        v128)

        local($struuid $crypto.randomUUID())
        
        local($regexp $RegExp:new<refx2>ref(
            global($RegExp.MATCH_HEX) 
            global($RegExp.FLAG_GLOBAL)
        ))
      
        local($match $String:match<refx2>ref(
            local($struuid) local($regexp)
        ))

        local($match $Array:map<ref.fun>ref(
            local($match) 
            (func $toInteger<ref>i32 
                (param ref) 
                (result i32)
                $parseInt<ref.i32>i32(
                    local(0) i32(16)
                )
            )
        ))

        local($byteArray $Uint8Array.from<ref>ref(
            local($match)
        ))

        local($view $BigUint64Array:new<ref>ref(
            $TypedArray:buffer(local($byteArray))
        ))

        local($uuid (i64x2.replace_lane 0 local($uuid) $BigUint64Array:at(local($view) i32(0))))
        local($uuid (i64x2.replace_lane 1 local($uuid) $BigUint64Array:at(local($view) i32(1))))

        local($uuid)
    )

    (func $parseInt<ref.i32>i32
        (param $string                  <string>)
        (param $base                         i32)
        (result $integer                     i32)

        (call $self.parseInt<ref.i32>i32 this local($base))
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
