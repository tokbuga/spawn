    (alias $randomUUID $randomUUID<>v128)
    (alias $toUuidString $toUuidString<v128>ref)
    (alias $toUuidArray $toUuidArray<v128>ref)
    (alias $isUuidString $isUuidString<ref>i32)

    (global $Uuid.TEST_REGEX_SOURCE "[a-f0-9]{32}|(([a-f0-9]{8})((-([a-f0-9]{4})){3})-([a-f0-9]{12}))")

    (func $isUuidString<ref>i32
        (param $value                   <string>)
        (result                              i32)

        $RegExp:test<refx2>i32(
            $RegExp:new<refx2>ref(
                global($Uuid.TEST_REGEX_SOURCE)
                global($RegExp.FLAG_IGNORE_CASE)
            )
            this
        )
    )

    (func $fillRandomUUID<v128>v128
        (param $uuid                    v128)
        (result $uuid                   v128)

        this

        (f32x4.replace_lane 0 $Math.random())
        (f32x4.replace_lane 1 $Math.random())
        (f32x4.replace_lane 2 $Math.random())
        (f32x4.replace_lane 3 $Math.random())
    )

    (func $randomUUID<>ref
        (result $uuid   <string>)
        (local $array   <Array>)

        (local #array
            $Array:map<ref.fun>ref(
                $Array.from<ref>ref(
                    $Uint8Array:new<ref>ref(
                        $TypedArray:buffer<ref>ref(
                            $Float32Array:map<refx2>ref(
                                $Float32Array:new<i32>ref( i32(4) )
                                global($self.Math.random)
                            )
                        )
                    )
                )
                (ref.func $uuid:toHexString)
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

    (func $uuid:toHexString (param i32) (result ref)
        $String:padStart<ref.i32x2>ref(
            $Number:toString<i32x2>ref(
                local(0) i32(16)
            )
            i32(2)
            i32(0)
        )   
    )

    (func $uuid:toInteger<ref>i32 (param ref) (result i32)
        $parseInt<ref.i32>i32( local(0) i32(16) )
    )

    (func $toUuidString<v128>ref
        (param $value                       v128)
        (result $uuid                   <string>)

        (local $array                    <Array>)
        (local #array 
            $Array:map<ref.fun>ref(
                $toUuidArray<v128>ref( this )
                (ref.func $uuid:toHexString)
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

    (func $fromUuidString<ref>v128
        (param $struuid                 <string>)
        (result $uuid                       v128)

        (local $regexp                  <RegExp>)
        (local $match                    <Array>)
        (local $byteArray           <Uint8Array>)
        (local $view            <BigUint64Array>)
        (local $uuid                        v128)
        
        local($regexp $RegExp:new<refx2>ref(
            global($RegExp.MATCH_HEX) 
            global($RegExp.FLAG_GLOBAL)
        ))
      
        local($match $String:match<refx2>ref(
            local($struuid) local($regexp)
        ))

        local($match $Array:map<ref.fun>ref(
            local($match) 
            (ref.func $uuid:toInteger<ref>i32)
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

    (func $randomUUID<>v128
        (result                             v128)
        (call $fromUuidString<ref>v128 $crypto.randomUUID())
    )
