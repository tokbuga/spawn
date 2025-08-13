
    (alias $ArrayBuffer:new                       $ArrayBuffer:new<i32>ref)
    (alias $ArrayBuffer:detached             $ArrayBuffer:detached<ref>i32)
    (alias $ArrayBuffer:resizable           $ArrayBuffer:resizable<ref>i32)
    (alias $ArrayBuffer:byteLength         $ArrayBuffer:byteLength<ref>i32)
    (alias $ArrayBuffer:maxByteLength   $ArrayBuffer:maxByteLength<ref>i32)
    (alias $ArrayBuffer.isView                 $ArrayBuffer.isView<ref>i32)

    (func $ArrayBuffer:new<i32>ref 
        (param $length                                    i32) 
        (result $this                           <ArrayBuffer>) 

        (new $self.ArrayBuffer<i32>ref local($length)) 
    )

    (func $ArrayBuffer:byteLength<ref>i32 
        (param $buffer                          <ArrayBuffer>) 
        (result $length                                   i32) 

        (apply $self.ArrayBuffer:byteLength/get this i32) 
    )

    (func $ArrayBuffer:maxByteLength<ref>i32 
        (param $buffer                          <ArrayBuffer>) 
        (result $length                                   i32) 

        (apply $self.ArrayBuffer:maxByteLength/get this i32) 
    )

    (func $ArrayBuffer:detached<ref>i32 
        (param $buffer                          <ArrayBuffer>) 
        (result $detached                                 i32) 

        (apply $self.ArrayBuffer:detached/get this i32) 
    )

    (func $ArrayBuffer:resizable<ref>i32 
        (param $buffer                          <ArrayBuffer>) 
        (result $resizable                                i32) 

        (apply $self.ArrayBuffer:resizable/get this i32) 
    )

    (func $ArrayBuffer.isView<ref>i32 
        (param $this                                 <Object>) 
        (result $isView                                   i32) 

        (apply $self.ArrayBuffer.isView this i32) 
    )

    (func $ArrayBuffer.isPrototypeOf<ref>i32 
        (param $this                                 <Object>) 
        (result $is                                       i32) 

        (apply $self.ArrayBuffer.isPrototypeOf this i32) 
    )
