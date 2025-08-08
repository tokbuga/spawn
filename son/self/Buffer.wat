
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