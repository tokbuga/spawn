
    (alias $UIEvent:detail                               $UIEvent:detail<ref>i32)
    (alias $UIEvent:sourceCapabilities       $UIEvent:sourceCapabilities<ref>ref)
    (alias $UIEvent:view                                   $UIEvent:view<ref>ref)

    (func $UIEvent:detail<ref>i32 
        (param $this                             <UIEvent>) 
        (result $value                                 i32) 

        (apply $self.UIEvent:detail/get this i32) 
    )

    (func $UIEvent:sourceCapabilities<ref>ref 
        (param $this                             <UIEvent>) 
        (result $value           <InputDeviceCapabilities>) 

        (apply $self.UIEvent:sourceCapabilities/get this externref) 
    )

    (func $UIEvent:view<ref>ref 
        (param $this                             <UIEvent>) 
        (result $value                      <AbstractView>) 

        (apply $self.UIEvent:view/get this externref) 
    )
