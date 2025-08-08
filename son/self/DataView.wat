
    (alias $DataView:new                   $DataView:new<ref>ref)

    (func $DataView:new<ref>ref 
        (param $buffer                               <Buffer>) 
        (result $this                              <DataView>) 

        (new $self.DataView<ref>ref local($buffer)) 
    )

    (func $DataView:setInt32<ref.i32x2> 
        (param $this                               <DataView>) 
        (param $offset                                    i32) 
        (param $value                                     i32) 

        (apply $self.DataView:setInt32<i32x2> 
            this 
            (param 
                local($offset) 
                local($value)
            )
        ) 
    )

    (func $DataView:setInt32<ref.i32x3> 
        (param $this                               <DataView>) 
        (param $offset                                    i32) 
        (param $value                                     i32) 
        (param $littleEndian                              i32) 

        (apply $self.DataView:setInt32<i32x3> 
            this 
            (param 
                local($offset) 
                local($value) 
                local($littleEndian)
            )
        ) 
    )


    (func $DataView:setUint32<ref.i32x2> 
        (param $this                               <DataView>) 
        (param $offset                                    i32) 
        (param $value                                     i32) 

        (apply $self.DataView:setUint32<i32x2> 
            this 
            (param 
                local($offset) 
                local($value)
            )
        ) 
    )

    (func $DataView:setUint32<ref.i32x3> 
        (param $this                               <DataView>) 
        (param $offset                                    i32) 
        (param $value                                     i32) 
        (param $littleEndian                              i32) 

        (warn <ref.i32x3> local(0) local(1) local(2) local(3))

        (apply $self.DataView:setUint32<i32x3> 
            this 
            (param 
                local($offset) 
                local($value) 
                local($littleEndian)
            )
        ) 
    )
