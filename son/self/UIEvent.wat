    (global $UIEvent.LENGTH                       i32 i32(36))
    (global $UIEvent.HDRLEN                       i32 i32(12))

    (memory $UIEvent:detail                        4 4 shared)
    (memory $UIEvent:sourceCapabilities            4 4 shared)
    (memory $UIEvent:view                          4 4 shared)

    (global $UIEvent.OFFSET_DETAIL                i32  i32(0))
    (global $UIEvent.OFFSET_SOURCE_CAPABILITIES   i32  i32(4))
    (global $UIEvent.OFFSET_VIEW                  i32  i32(8))
    (global $UIEvent.OFFSET_EVENT                 i32 i32(12))

    (global $UIEvent.LENGTH_DETAIL                i32  i32(4))
    (global $UIEvent.LENGTH_SOURCE_CAPABILITIES   i32  i32(4))
    (global $UIEvent.LENGTH_VIEW                  i32  i32(4))
    (global $UIEvent.LENGTH_EVENT                i32  i32(24))

    (func $UIEvent.from<ref>i32
        (param $this                             <UIEvent>)
        (result $offset                                i32)

        (local $offset                                 i32)
        (local #offset $malloc(global($UIEvent.LENGTH)))

        $UIEvent.store<ref.i32>(
            this local($offset)
        )

        local($offset)
    )

    (func $UIEvent.store<ref.i32>
        (param $this                             <UIEvent>)
        (param $offset                                 i32)

        $UIEvent:detail/store<i32.i32>(
            local($offset) $UIEvent:detail/get<ref>i32( this )
        )

        $UIEvent:sourceCapabilities/store<i32.i32>(
            local($offset) $UIEvent:sourceCapabilities/get<ref>i32( this )
        )

        $UIEvent:view/store<i32.i32>(
            local($offset) $UIEvent:view/get<ref>i32( this )
        )

        $Event.store<ref.i32>( 
            this 
            (i32.add local($offset) global($UIEvent.OFFSET_EVENT)) 
        )
    )


    (func $UIEvent:detail/read<i32>i32 
        (param $index                                  i32) 
        (result $value                                 i32) 

        (i32.load (memory $UIEvent:detail) (i32.mul local($index) global($UIEvent.LENGTH_DETAIL)))
    )

    (func $UIEvent:detail/write<i32.i32> 
        (param $index                                  i32) 
        (param $value                                  i32) 

        (i32.store (memory $UIEvent:detail) (i32.mul local($index) global($UIEvent.LENGTH_DETAIL)) local($value))
    )

    (func $UIEvent:detail/get<ref>i32 
        (param $this                             <UIEvent>) 
        (result $value                                 i32) 

        (apply $self.UIEvent:detail/get this i32) 
    )

    (func $UIEvent:detail/load<i32>i32 
        (param $offset                                 i32) 
        (result $value                                 i32) 

        (i32.load offset=0 local($offset))
    )

    (func $UIEvent:detail/store<i32.i32> 
        (param $offset                                 i32) 
        (param $value                                  i32) 

        (i32.store offset=0 local($offset) local($value))
    )



    (func $UIEvent:sourceCapabilities/read<i32>i32 
        (param $index                                  i32) 
        (result $value                                 i32) 

        (i32.load (memory $UIEvent:sourceCapabilities) (i32.mul local($index) global($UIEvent.LENGTH_SOURCE_CAPABILITIES)))
    )

    (func $UIEvent:sourceCapabilities/write<i32.i32> 
        (param $index                                  i32) 
        (param $value                                  i32) 

        (i32.store (memory $UIEvent:sourceCapabilities) (i32.mul local($index) global($UIEvent.LENGTH_SOURCE_CAPABILITIES)) local($value))
    )

    (func $UIEvent:sourceCapabilities/get<ref>i32 
        (param $this                             <UIEvent>) 
        (result $value                                 i32) 

        (apply $self.UIEvent:sourceCapabilities/get this i32) 
    )

    (func $UIEvent:sourceCapabilities/get<ref>ref 
        (param $this                             <UIEvent>) 
        (result $value           <InputDeviceCapabilities>) 

        (apply $self.UIEvent:sourceCapabilities/get this externref) 
    )

    (func $UIEvent:sourceCapabilities/load<i32>i32 
        (param $offset                                 i32) 
        (result $value                                 i32) 

        (i32.load offset=4 local($offset))
    )

    (func $UIEvent:sourceCapabilities/store<i32.i32> 
        (param $offset                                 i32) 
        (param $value                                  i32) 

        (i32.store offset=4 local($offset) local($value))
    )



    (func $UIEvent:view/read<i32>i32 
        (param $index                                  i32) 
        (result $value                                 i32) 

        (i32.load (memory $UIEvent:view) (i32.mul local($index) global($UIEvent.LENGTH_VIEW)))
    )

    (func $UIEvent:view/write<i32.i32> 
        (param $index                                  i32) 
        (param $value                                  i32) 

        (i32.store (memory $UIEvent:view) (i32.mul local($index) global($UIEvent.LENGTH_VIEW)) local($value))
    )

    (func $UIEvent:view/get<ref>i32 
        (param $this                             <UIEvent>) 
        (result $value                                 i32) 

        (apply $self.UIEvent:view/get this i32) 
    )

    (func $UIEvent:view/get<ref>ref 
        (param $this                             <UIEvent>) 
        (result $value                      <AbstractView>) 

        (apply $self.UIEvent:view/get this externref) 
    )

    (func $UIEvent:view/load<i32>i32 
        (param $offset                                 i32) 
        (result $value                                 i32) 

        (i32.load offset=8 local($offset))
    )

    (func $UIEvent:view/store<i32.i32> 
        (param $offset                                 i32) 
        (param $value                                  i32) 

        (i32.store offset=8 local($offset) local($value))
    )


