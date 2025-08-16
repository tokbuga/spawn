    (alias $STL:debugArrayBuffer        $STL:debugArrayBuffer<ref>)

    (global $STL.BYTES_PER_ELEMENT i32 i32(50))
    (global $STL.OFFSET_TRIANGLE_COUNT i32 i32(80))
    (global $STL.OFFSET_TRIANGLE_DATA i32 i32(84))

    (func $STL:normalX<i32>f32            (param $offset i32) (result f32) (f32.load  offset=0 local($offset)))
    (func $STL:normalY<i32>f32            (param $offset i32) (result f32) (f32.load  offset=4 local($offset)))
    (func $STL:normalZ<i32>f32            (param $offset i32) (result f32) (f32.load  offset=8 local($offset)))
    (func $STL:vertex1X<i32>f32           (param $offset i32) (result f32) (f32.load offset=12 local($offset)))
    (func $STL:vertex1Y<i32>f32           (param $offset i32) (result f32) (f32.load offset=16 local($offset)))
    (func $STL:vertex1Z<i32>f32           (param $offset i32) (result f32) (f32.load offset=20 local($offset)))
    (func $STL:vertex2X<i32>f32           (param $offset i32) (result f32) (f32.load offset=24 local($offset)))
    (func $STL:vertex2Y<i32>f32           (param $offset i32) (result f32) (f32.load offset=28 local($offset)))
    (func $STL:vertex2Z<i32>f32           (param $offset i32) (result f32) (f32.load offset=32 local($offset)))
    (func $STL:vertex3X<i32>f32           (param $offset i32) (result f32) (f32.load offset=36 local($offset)))
    (func $STL:vertex3Y<i32>f32           (param $offset i32) (result f32) (f32.load offset=40 local($offset)))
    (func $STL:vertex3Z<i32>f32           (param $offset i32) (result f32) (f32.load offset=44 local($offset)))
    (func $STL:attributeByteCount<i32>i32 (param $offset i32) (result i32) (i32.load16_u offset=48 local($offset)))


    (func $STL:debugArrayBuffer<ref>
        (param $buffer <ArrayBuffer>)
        (local $length i32)
        (local $offset i32)
        (local $triangleCount i32)
        (local $triangleOffset i32)
        (local $attributeByteCount i32)
        (local $attributeByteArray <Uint8Array>)
        (local $i i32)

        (local #length $ArrayBuffer:byteLength( this ))
        (local #offset malloc( local($length) ))

        $TypedArray:set(
            $Uint8Array:new<ref.i32x2>ref( global($buffer) local($offset) local($length) )        
            $Uint8Array:new<ref.i32x2>ref( local($buffer) i32(0) local($length) )        
        )
        
        (local #triangleCount (i32.load (i32.add local($offset) global($STL.OFFSET_TRIANGLE_COUNT))))
        (local #triangleOffset (i32.add local($offset) global($STL.OFFSET_TRIANGLE_DATA)))
        (local #triangleCount (i32.const 100))

        (if local($triangleCount)
            (then
                (loop $i++

                    (if (local @attributeByteCount
                            $STL:attributeByteCount<i32>i32( 
                                local($triangleOffset) 
                            )
                        )
                        (then (local #attributeByteArray
                            $Uint8Array:new<ref.i32x2>ref(
                                global($buffer)
                                (i32.add 
                                    local($triangleOffset)
                                    global($STL.BYTES_PER_ELEMENT)
                                )
                                i32(2) 
                            )
                        ))
                        (else (local #attributeByteArray null))
                    )

                    (warn<i32x3.refx2>
                        local($i) 
                        local($triangleOffset) 
                        local($attributeByteCount) 
                        local($attributeByteArray) 

                        $self.Array.of<f32x3>ref(
                            $STL:normalX<i32>f32( local($triangleOffset) )
                            $STL:normalY<i32>f32( local($triangleOffset) )
                            $STL:normalZ<i32>f32( local($triangleOffset) )
                        )
                    )

                    (log<refx3>
                        $self.Array.of<f32x3>ref(
                            $STL:vertex1X<i32>f32( local($triangleOffset) )
                            $STL:vertex1Y<i32>f32( local($triangleOffset) )
                            $STL:vertex1Z<i32>f32( local($triangleOffset) )
                        )

                        $self.Array.of<f32x3>ref(
                            $STL:vertex2X<i32>f32( local($triangleOffset) )
                            $STL:vertex2Y<i32>f32( local($triangleOffset) )
                            $STL:vertex2Z<i32>f32( local($triangleOffset) )
                        )

                        $self.Array.of<f32x3>ref(
                            $STL:vertex3X<i32>f32( local($triangleOffset) )
                            $STL:vertex3Y<i32>f32( local($triangleOffset) )
                            $STL:vertex3Z<i32>f32( local($triangleOffset) )
                        )                        
                    )

                    (local #triangleOffset 
                        (i32.add 
                            local($triangleOffset)
                            global($STL.BYTES_PER_ELEMENT)
                        )
                    )

                    (br_if $i++ 
                        (i32.lt_u 
                            (local.tee $i local($i)++) 
                            (local.get $triangleCount)
                        )
                    )
                )
            )
        )
    )
