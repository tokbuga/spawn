
    (alias $Buffer.isBuffer          $Buffer.isBuffer<ref>i32)

    (func $Buffer.isBuffer<ref>i32 
        (param $this                                 <Object>) 
        (result $is                                       i32) 

        (i32.ne false (get <refx2>i32 this text("maxByteLength")))
    )

    (func $Buffer:writeInt32LE<ref.i32x2> 
        (param $this                                 <Buffer>) 
        (param $offset                                    i32) 
        (param $value                                     i32) 

        $DataView:setInt32<ref.i32x3>(
            $DataView:new<ref>ref( this )
            local($offset) 
            local($value) 
            true
        )
    )

    (func $Buffer:writeInt32BE<ref.i32x2> 
        (param $this                                 <Buffer>) 
        (param $offset                                    i32) 
        (param $value                                     i32) 

        $DataView:setInt32<ref.i32x3>(
            $DataView:new<ref>ref( this )
            local($offset) 
            local($value) 
            false
        )
    )

    (func $Buffer:writeUint32LE<ref.i32x2> 
        (param $this                                 <Buffer>) 
        (param $offset                                    i32) 
        (param $value                                     i32) 

        $DataView:setUint32<ref.i32x3>(
            $DataView:new<ref>ref( this )
            local($offset) 
            local($value) 
            true
        )
    )

    (func $Buffer:writeUint32BE<ref.i32x2> 
        (param $this                                 <Buffer>) 
        (param $offset                                    i32) 
        (param $value                                     i32) 

        $DataView:setUint32<ref.i32x3>(
            $DataView:new<ref>ref( this )
            local($offset) 
            local($value) 
            false
        )
    )