    (alias $randomUUID $randomUUID<>v128)
    (alias $toUuidString $toUuidString<v128>ref)
    (alias $toUuidArray $toUuidArray<v128>ref)

    (func $toUuidString<v128>ref
        (param $value                       v128)
        (result $uuid                   <string>)

        (local $array                    <Array>)
        (local #array 
            $Array:map<ref.fun>ref(
                $toUuidArray<v128>ref( this )
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

    (func $toUuidArray<v128>ref
        (param $value                       v128)
        (result $uuid                    <Array>)

        $Array.from<ref>ref( 
            $Uint8Array:new<v128>ref( this )
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
