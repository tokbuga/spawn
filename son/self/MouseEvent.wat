    (global $MouseEvent.LENGTH                       i32 i32(88))
    (global $MouseEvent.HDRLEN                       i32 i32(52))

    (memory $MouseEvent:altKey                        1 1 shared)
    (memory $MouseEvent:ctrlKey                       1 1 shared)
    (memory $MouseEvent:metaKey                       1 1 shared)
    (memory $MouseEvent:shiftKey                      1 1 shared)
    (memory $MouseEvent:button                        1 1 shared)
    (memory $MouseEvent:buttons                       1 1 shared)
    (memory $MouseEvent:clientX                       4 4 shared)
    (memory $MouseEvent:clientY                       4 4 shared)
    (memory $MouseEvent:movementX                     4 4 shared)
    (memory $MouseEvent:movementY                     4 4 shared)
    (memory $MouseEvent:offsetX                       4 4 shared)
    (memory $MouseEvent:offsetY                       4 4 shared)
    (memory $MouseEvent:pageX                         4 4 shared)
    (memory $MouseEvent:pageY                         4 4 shared)
    (memory $MouseEvent:screenX                       4 4 shared)
    (memory $MouseEvent:screenY                       4 4 shared)
    (memory $MouseEvent:relatedTarget                 4 4 shared)

    (global $MouseEvent.OFFSET_ALT_KEY               i32  i32(0))
    (global $MouseEvent.OFFSET_CTRL_KEY              i32  i32(1))
    (global $MouseEvent.OFFSET_META_KEY              i32  i32(2))
    (global $MouseEvent.OFFSET_SHIFT_KEY             i32  i32(3))
    (global $MouseEvent.OFFSET_BUTTON                i32  i32(4))
    (global $MouseEvent.OFFSET_BUTTONS               i32  i32(5))
    (global $MouseEvent.OFFSET_PADDING               i32  i32(6))
    (global $MouseEvent.OFFSET_CLIENT_X              i32  i32(8))
    (global $MouseEvent.OFFSET_CLIENT_Y              i32 i32(12))
    (global $MouseEvent.OFFSET_MOVEMENT_X            i32 i32(16))
    (global $MouseEvent.OFFSET_MOVEMENT_Y            i32 i32(20))
    (global $MouseEvent.OFFSET_OFFSET_X              i32 i32(24))
    (global $MouseEvent.OFFSET_OFFSET_Y              i32 i32(28))
    (global $MouseEvent.OFFSET_PAGE_X                i32 i32(32))
    (global $MouseEvent.OFFSET_PAGE_Y                i32 i32(36))
    (global $MouseEvent.OFFSET_SCREEN_X              i32 i32(40))
    (global $MouseEvent.OFFSET_SCREEN_Y              i32 i32(44))
    (global $MouseEvent.OFFSET_RELATED_TARGET        i32 i32(48))
    (global $MouseEvent.OFFSET_UI_EVENT              i32 i32(52))

    (global $MouseEvent.OFFSET_X                     i32  i32(8))
    (global $MouseEvent.OFFSET_Y                     i32 i32(12))

    (global $MouseEvent.LENGTH_ALT_KEY                i32 i32(1))
    (global $MouseEvent.LENGTH_CTRL_KEY               i32 i32(1))
    (global $MouseEvent.LENGTH_META_KEY               i32 i32(1))
    (global $MouseEvent.LENGTH_SHIFT_KEY              i32 i32(1))
    (global $MouseEvent.LENGTH_BUTTON                 i32 i32(1))
    (global $MouseEvent.LENGTH_BUTTONS                i32 i32(1))
    (global $MouseEvent.LENGTH_PADDING                i32 i32(2))
    (global $MouseEvent.LENGTH_CLIENT_X               i32 i32(4))
    (global $MouseEvent.LENGTH_CLIENT_Y               i32 i32(4))
    (global $MouseEvent.LENGTH_MOVEMENT_X             i32 i32(4))
    (global $MouseEvent.LENGTH_MOVEMENT_Y             i32 i32(4))
    (global $MouseEvent.LENGTH_OFFSET_X               i32 i32(4))
    (global $MouseEvent.LENGTH_OFFSET_Y               i32 i32(4))
    (global $MouseEvent.LENGTH_PAGE_X                 i32 i32(4))
    (global $MouseEvent.LENGTH_PAGE_Y                 i32 i32(4))
    (global $MouseEvent.LENGTH_SCREEN_X               i32 i32(4))
    (global $MouseEvent.LENGTH_SCREEN_Y               i32 i32(4))
    (global $MouseEvent.LENGTH_RELATED_TARGET         i32 i32(4))
    (global $MouseEvent.LENGTH_UI_EVENT              i32 i32(36))

    (func $MouseEvent.from<ref>i32
        (param $this                          <MouseEvent>)
        (result $offset                                i32)

        (local $offset                                 i32)
        (local #offset $malloc(global($MouseEvent.LENGTH)))

        $MouseEvent.store<ref.i32>(
            this local($offset)
        )

        local($offset)
    )

    (func $MouseEvent.store<ref.i32>
        (param $this                          <MouseEvent>)
        (param $offset                                 i32)

        $MouseEvent:altKey/store<i32.i32>(
            local($offset) $MouseEvent:altKey/get<ref>i32( this )
        )

        $MouseEvent:ctrlKey/store<i32.i32>(
            local($offset) $MouseEvent:ctrlKey/get<ref>i32( this )
        )

        $MouseEvent:metaKey/store<i32.i32>(
            local($offset) $MouseEvent:metaKey/get<ref>i32( this )
        )

        $MouseEvent:shiftKey/store<i32.i32>(
            local($offset) $MouseEvent:shiftKey/get<ref>i32( this )
        )

        $MouseEvent:button/store<i32.i32>(
            local($offset) $MouseEvent:button/get<ref>i32( this )
        )

        $MouseEvent:buttons/store<i32.i32>(
            local($offset) $MouseEvent:buttons/get<ref>i32( this )
        )

        $MouseEvent:clientX/store<i32.f32>(
            local($offset) $MouseEvent:clientX/get<ref>f32( this )
        )

        $MouseEvent:clientY/store<i32.f32>(
            local($offset) $MouseEvent:clientY/get<ref>f32( this )
        )

        $MouseEvent:movementX/store<i32.f32>(
            local($offset) $MouseEvent:movementX/get<ref>f32( this )
        )

        $MouseEvent:movementY/store<i32.f32>(
            local($offset) $MouseEvent:movementY/get<ref>f32( this )
        )

        $MouseEvent:offsetX/store<i32.f32>(
            local($offset) $MouseEvent:offsetX/get<ref>f32( this )
        )

        $MouseEvent:offsetY/store<i32.f32>(
            local($offset) $MouseEvent:offsetY/get<ref>f32( this )
        )

        $MouseEvent:pageX/store<i32.f32>(
            local($offset) $MouseEvent:pageX/get<ref>f32( this )
        )

        $MouseEvent:pageY/store<i32.f32>(
            local($offset) $MouseEvent:pageY/get<ref>f32( this )
        )

        $MouseEvent:screenX/store<i32.f32>(
            local($offset) $MouseEvent:screenX/get<ref>f32( this )
        )

        $MouseEvent:screenY/store<i32.f32>(
            local($offset) $MouseEvent:screenY/get<ref>f32( this )
        )

        $MouseEvent:relatedTarget/store<i32.i32>(
            local($offset) $MouseEvent:relatedTarget/get<ref>i32( this )
        )

        $UIEvent.store<ref.i32>( 
            this 
            (i32.add local($offset) global($MouseEvent.OFFSET_UI_EVENT)) 
        )
    )



    (func $MouseEvent:altKey/read<i32>i32 
        (param $index                                  i32) 
        (result $value                                 i32) 

        (i32.load8_u (memory $MouseEvent:altKey) local($index))
    )

    (func $MouseEvent:altKey/write<i32.i32> 
        (param $index                                  i32) 
        (param $value                                  i32) 

        (i32.store8 (memory $MouseEvent:altKey) local($index) local($value))
    )

    (func $MouseEvent:altKey/get<ref>i32 
        (param $this                          <MouseEvent>) 
        (result $value                                 i32) 

        (apply $self.MouseEvent:altKey/get this i32) 
    )

    (func $MouseEvent:altKey/load<i32>i32 
        (param $offset                                 i32) 
        (result $value                                 i32) 

        (i32.load8_u offset=0 local($offset))
    )

    (func $MouseEvent:altKey/store<i32.i32> 
        (param $offset                                 i32) 
        (param $value                                  i32) 

        (i32.store8 offset=0 local($offset) local($value))
    )



    (func $MouseEvent:ctrlKey/read<i32>i32 
        (param $index                                  i32) 
        (result $value                                 i32) 

        (i32.load8_u (memory $MouseEvent:ctrlKey) local($index))
    )

    (func $MouseEvent:ctrlKey/write<i32.i32> 
        (param $index                                  i32) 
        (param $value                                  i32) 

        (i32.store8 (memory $MouseEvent:ctrlKey) local($index) local($value))
    )

    (func $MouseEvent:ctrlKey/get<ref>i32 
        (param $this                          <MouseEvent>) 
        (result $value                                 i32) 

        (apply $self.MouseEvent:ctrlKey/get this i32) 
    )

    (func $MouseEvent:ctrlKey/load<i32>i32 
        (param $offset                                 i32) 
        (result $value                                 i32) 

        (i32.load8_u offset=1 local($offset))
    )

    (func $MouseEvent:ctrlKey/store<i32.i32> 
        (param $offset                                 i32) 
        (param $value                                  i32) 

        (i32.store8 offset=1 local($offset) local($value))
    )




    (func $MouseEvent:metaKey/read<i32>i32 
        (param $index                                  i32) 
        (result $value                                 i32) 

        (i32.load8_u (memory $MouseEvent:metaKey) local($index))
    )

    (func $MouseEvent:metaKey/write<i32.i32> 
        (param $index                                  i32) 
        (param $value                                  i32) 

        (i32.store8 (memory $MouseEvent:metaKey) local($index) local($value))
    )

    (func $MouseEvent:metaKey/get<ref>i32 
        (param $this                          <MouseEvent>) 
        (result $value                                 i32) 

        (apply $self.MouseEvent:metaKey/get this i32) 
    )

    (func $MouseEvent:metaKey/load<i32>i32 
        (param $offset                                 i32) 
        (result $value                                 i32) 

        (i32.load8_u offset=2 local($offset))
    )

    (func $MouseEvent:metaKey/store<i32.i32> 
        (param $offset                                 i32) 
        (param $value                                  i32) 

        (i32.store8 offset=2 local($offset) local($value))
    )



    (func $MouseEvent:shiftKey/read<i32>i32 
        (param $index                                  i32) 
        (result $value                                 i32) 

        (i32.load8_u (memory $MouseEvent:shiftKey) local($index))
    )

    (func $MouseEvent:shiftKey/write<i32.i32> 
        (param $index                                  i32) 
        (param $value                                  i32) 

        (i32.store8 (memory $MouseEvent:shiftKey) local($index) local($value))
    )

    (func $MouseEvent:shiftKey/get<ref>i32 
        (param $this                          <MouseEvent>) 
        (result $value                                 i32) 

        (apply $self.MouseEvent:shiftKey/get this i32) 
    )

    (func $MouseEvent:shiftKey/load<i32>i32 
        (param $offset                                 i32) 
        (result $value                                 i32) 

        (i32.load8_u offset=3 local($offset))
    )

    (func $MouseEvent:shiftKey/store<i32.i32> 
        (param $offset                                 i32) 
        (param $value                                  i32) 

        (i32.store8 offset=3 local($offset) local($value))
    )





    (func $MouseEvent:button/read<i32>i32 
        (param $index                                  i32) 
        (result $value                                 i32) 

        (i32.load8_u (memory $MouseEvent:button) local($index))
    )

    (func $MouseEvent:button/write<i32.i32> 
        (param $index                                  i32) 
        (param $value                                  i32) 

        (i32.store8 (memory $MouseEvent:button) local($index) local($value))
    )

    (func $MouseEvent:button/get<ref>i32 
        (param $this                          <MouseEvent>) 
        (result $value                                 i32) 

        (apply $self.MouseEvent:button/get this i32) 
    )

    (func $MouseEvent:button/load<i32>i32 
        (param $offset                                 i32) 
        (result $value                                 i32) 

        (i32.load8_u offset=4 local($offset))
    )

    (func $MouseEvent:button/store<i32.i32> 
        (param $offset                                 i32) 
        (param $value                                  i32) 

        (i32.store8 offset=4 local($offset) local($value))
    )




    (func $MouseEvent:buttons/read<i32>i32 
        (param $index                                  i32) 
        (result $value                                 i32) 

        (i32.load8_u (memory $MouseEvent:buttons) local($index))
    )

    (func $MouseEvent:buttons/write<i32.i32> 
        (param $index                                  i32) 
        (param $value                                  i32) 

        (i32.store8 (memory $MouseEvent:buttons) local($index) local($value))
    )

    (func $MouseEvent:buttons/get<ref>i32 
        (param $this                          <MouseEvent>) 
        (result $value                                 i32) 

        (apply $self.MouseEvent:buttons/get this i32) 
    )

    (func $MouseEvent:buttons/load<i32>i32 
        (param $offset                                 i32) 
        (result $value                                 i32) 

        (i32.load8_u offset=5 local($offset))
    )

    (func $MouseEvent:buttons/store<i32.i32> 
        (param $offset                                 i32) 
        (param $value                                  i32) 

        (i32.store8 offset=5 local($offset) local($value))
    )



    (func $MouseEvent:clientX/read<i32>f32 
        (param $index                                  i32) 
        (result $clientX                               f32) 

        (f32.load (memory $MouseEvent:clientX) (i32.mul local($index) global($MouseEvent.LENGTH_CLIENT_X)))
    )

    (func $MouseEvent:clientX/write<i32.f32> 
        (param $index                                  i32) 
        (param $clientX                                f32) 

        (f32.store (memory $MouseEvent:clientX) (i32.mul local($index) global($MouseEvent.LENGTH_CLIENT_X)) local($clientX))
    )

    (func $MouseEvent:clientX/get<ref>f32 
        (param $this                          <MouseEvent>) 
        (result $clientX                               f32) 

        (apply $self.MouseEvent:clientX/get this f32) 
    )

    (func $MouseEvent:clientX/load<i32>f32 
        (param $offset                                 i32) 
        (result $clientX                               f32) 

        (f32.load offset=8 local($offset))
    )

    (func $MouseEvent:clientX/store<i32.f32> 
        (param $offset                                 i32) 
        (param $clientX                                f32) 

        (f32.store offset=8 local($offset) local($clientX))
    )



    (func $MouseEvent:clientY/read<i32>f32 
        (param $index                                  i32) 
        (result $value                                 f32) 

        (f32.load (memory $MouseEvent:clientY) (i32.mul local($index) global($MouseEvent.LENGTH_CLIENT_Y)))
    )

    (func $MouseEvent:clientY/write<i32.f32> 
        (param $index                                  i32) 
        (param $value                                  f32) 

        (f32.store (memory $MouseEvent:clientY) (i32.mul local($index) global($MouseEvent.LENGTH_CLIENT_Y)) local($value))
    )

    (func $MouseEvent:clientY/get<ref>f32 
        (param $this                          <MouseEvent>) 
        (result $value                                 f32) 

        (apply $self.MouseEvent:clientY/get this f32) 
    )

    (func $MouseEvent:clientY/load<i32>f32 
        (param $offset                                 i32) 
        (result $value                                 f32) 

        (f32.load offset=12 local($offset))
    )

    (func $MouseEvent:clientY/store<i32.f32> 
        (param $offset                                 i32) 
        (param $value                                  f32) 

        (f32.store offset=12 local($offset) local($value))
    )



    (func $MouseEvent:movementX/read<i32>f32 
        (param $index                                  i32) 
        (result $value                                 f32) 

        (f32.load (memory $MouseEvent:movementX) (i32.mul local($index) global($MouseEvent.LENGTH_MOVEMENT_X)))
    )

    (func $MouseEvent:movementX/write<i32.f32> 
        (param $index                                  i32) 
        (param $value                                  f32) 

        (f32.store (memory $MouseEvent:movementX) (i32.mul local($index) global($MouseEvent.LENGTH_MOVEMENT_X)) local($value))
    )

    (func $MouseEvent:movementX/get<ref>f32 
        (param $this                          <MouseEvent>) 
        (result $value                                 f32) 

        (apply $self.MouseEvent:movementX/get this f32) 
    )

    (func $MouseEvent:movementX/load<i32>f32 
        (param $offset                                 i32) 
        (result $value                                 f32) 

        (f32.load offset=16 local($offset))
    )

    (func $MouseEvent:movementX/store<i32.f32> 
        (param $offset                                 i32) 
        (param $value                                  f32) 

        (f32.store offset=16 local($offset) local($value))
    )



    (func $MouseEvent:movementY/read<i32>f32 
        (param $index                                  i32) 
        (result $value                                 f32) 

        (f32.load (memory $MouseEvent:movementY) (i32.mul local($index) global($MouseEvent.LENGTH_MOVEMENT_Y)))
    )

    (func $MouseEvent:movementY/write<i32.f32> 
        (param $index                                  i32) 
        (param $value                                  f32) 

        (f32.store (memory $MouseEvent:movementY) (i32.mul local($index) global($MouseEvent.LENGTH_MOVEMENT_Y)) local($value))
    )

    (func $MouseEvent:movementY/get<ref>f32 
        (param $this                          <MouseEvent>) 
        (result $value                                 f32) 

        (apply $self.MouseEvent:movementY/get this f32) 
    )

    (func $MouseEvent:movementY/load<i32>f32 
        (param $offset                                 i32) 
        (result $value                                 f32) 

        (f32.load offset=20 local($offset))
    )

    (func $MouseEvent:movementY/store<i32.f32> 
        (param $offset                                 i32) 
        (param $value                                  f32) 

        (f32.store offset=20 local($offset) local($value))
    )



    (func $MouseEvent:offsetX/read<i32>f32 
        (param $index                                  i32) 
        (result $value                                 f32) 

        (f32.load (memory $MouseEvent:offsetX) (i32.mul local($index) global($MouseEvent.LENGTH_OFFSET_X)))
    )

    (func $MouseEvent:offsetX/write<i32.f32> 
        (param $index                                  i32) 
        (param $value                                  f32) 

        (f32.store (memory $MouseEvent:offsetX) (i32.mul local($index) global($MouseEvent.LENGTH_OFFSET_X)) local($value))
    )

    (func $MouseEvent:offsetX/get<ref>f32 
        (param $this                          <MouseEvent>) 
        (result $value                                 f32) 

        (apply $self.MouseEvent:offsetX/get this f32) 
    )

    (func $MouseEvent:offsetX/load<i32>f32 
        (param $offset                                 i32) 
        (result $value                                 f32) 

        (f32.load offset=24 local($offset))
    )

    (func $MouseEvent:offsetX/store<i32.f32> 
        (param $offset                                 i32) 
        (param $value                                  f32) 

        (f32.store offset=24 local($offset) local($value))
    )



    (func $MouseEvent:offsetY/read<i32>f32 
        (param $index                                  i32) 
        (result $value                                 f32) 

        (f32.load (memory $MouseEvent:offsetY) (i32.mul local($index) global($MouseEvent.LENGTH_OFFSET_Y)))
    )

    (func $MouseEvent:offsetY/write<i32.f32> 
        (param $index                                  i32) 
        (param $value                                  f32) 

        (f32.store (memory $MouseEvent:offsetY) (i32.mul local($index) global($MouseEvent.LENGTH_OFFSET_Y)) local($value))
    )

    (func $MouseEvent:offsetY/get<ref>f32 
        (param $this                          <MouseEvent>) 
        (result $value                                 f32) 

        (apply $self.MouseEvent:offsetY/get this f32) 
    )

    (func $MouseEvent:offsetY/load<i32>f32 
        (param $offset                                 i32) 
        (result $value                                 f32) 

        (f32.load offset=28 local($offset))
    )

    (func $MouseEvent:offsetY/store<i32.f32> 
        (param $offset                                 i32) 
        (param $value                                  f32) 

        (f32.store offset=28 local($offset) local($value))
    )





    (func $MouseEvent:pageX/read<i32>f32 
        (param $index                                  i32) 
        (result $value                                 f32) 

        (f32.load (memory $MouseEvent:pageX) (i32.mul local($index) global($MouseEvent.LENGTH_PAGE_X)))
    )

    (func $MouseEvent:pageX/write<i32.f32> 
        (param $index                                  i32) 
        (param $value                                  f32) 

        (f32.store (memory $MouseEvent:pageX) (i32.mul local($index) global($MouseEvent.LENGTH_PAGE_X)) local($value))
    )

    (func $MouseEvent:pageX/get<ref>f32 
        (param $this                        <MouseEvent>) 
        (result $value                                 f32) 

        (apply $self.MouseEvent:pageX/get this f32) 
    )

    (func $MouseEvent:pageX/load<i32>f32 
        (param $offset                                 i32) 
        (result $value                                 f32) 

        (f32.load offset=32 local($offset))
    )

    (func $MouseEvent:pageX/store<i32.f32> 
        (param $offset                                 i32) 
        (param $value                                  f32) 

        (f32.store offset=32 local($offset) local($value))
    )




    (func $MouseEvent:pageY/read<i32>f32 
        (param $index                                  i32) 
        (result $value                                 f32) 

        (f32.load (memory $MouseEvent:pageY) (i32.mul local($index) global($MouseEvent.LENGTH_PAGE_Y)))
    )

    (func $MouseEvent:pageY/write<i32.f32> 
        (param $index                                  i32) 
        (param $value                                  f32) 

        (f32.store (memory $MouseEvent:pageY) (i32.mul local($index) global($MouseEvent.LENGTH_PAGE_Y)) local($value))
    )

    (func $MouseEvent:pageY/get<ref>f32 
        (param $this                        <MouseEvent>) 
        (result $value                                 f32) 

        (apply $self.MouseEvent:pageY/get this f32) 
    )

    (func $MouseEvent:pageY/load<i32>f32 
        (param $offset                                 i32) 
        (result $value                                 f32) 

        (f32.load offset=36 local($offset))
    )

    (func $MouseEvent:pageY/store<i32.f32> 
        (param $offset                                 i32) 
        (param $value                                  f32) 

        (f32.store offset=36 local($offset) local($value))
    )




    (func $MouseEvent:screenX/read<i32>f32 
        (param $index                                  i32) 
        (result $value                                 f32) 

        (f32.load (memory $MouseEvent:screenX) (i32.mul local($index) global($MouseEvent.LENGTH_SCREEN_X)))
    )

    (func $MouseEvent:screenX/write<i32.f32> 
        (param $index                                  i32) 
        (param $value                                  f32) 

        (f32.store (memory $MouseEvent:screenX) (i32.mul local($index) global($MouseEvent.LENGTH_SCREEN_X)) local($value))
    )

    (func $MouseEvent:screenX/get<ref>f32 
        (param $this                        <MouseEvent>) 
        (result $value                                 f32) 

        (apply $self.MouseEvent:screenX/get this f32) 
    )

    (func $MouseEvent:screenX/load<i32>f32 
        (param $offset                                 i32) 
        (result $value                                 f32) 

        (f32.load offset=40 local($offset))
    )

    (func $MouseEvent:screenX/store<i32.f32> 
        (param $offset                                 i32) 
        (param $value                                  f32) 

        (f32.store offset=40 local($offset) local($value))
    )





    (func $MouseEvent:screenY/read<i32>f32 
        (param $index                                  i32) 
        (result $value                                 f32) 

        (f32.load (memory $MouseEvent:screenY) (i32.mul local($index) global($MouseEvent.LENGTH_SCREEN_Y)))
    )

    (func $MouseEvent:screenY/write<i32.f32> 
        (param $index                                  i32) 
        (param $value                                  f32) 

        (f32.store (memory $MouseEvent:screenY) (i32.mul local($index) global($MouseEvent.LENGTH_SCREEN_Y)) local($value))
    )

    (func $MouseEvent:screenY/get<ref>f32 
        (param $this                        <MouseEvent>) 
        (result $value                                 f32) 

        (apply $self.MouseEvent:screenY/get this f32) 
    )

    (func $MouseEvent:screenY/load<i32>f32 
        (param $offset                                 i32) 
        (result $value                                 f32) 

        (f32.load offset=44 local($offset))
    )

    (func $MouseEvent:screenY/store<i32.f32> 
        (param $offset                                 i32) 
        (param $value                                  f32) 

        (f32.store offset=44 local($offset) local($value))
    )




    (func $MouseEvent:relatedTarget/read<i32>i32 
        (param $index                                  i32) 
        (result $value                                 i32) 

        (i32.load (memory $MouseEvent:relatedTarget) (i32.mul local($index) global($MouseEvent.LENGTH_RELATED_TARGET)))
    )

    (func $MouseEvent:relatedTarget/write<i32.i32> 
        (param $index                                  i32) 
        (param $value                                  i32) 

        (i32.store (memory $MouseEvent:relatedTarget) (i32.mul local($index) global($MouseEvent.LENGTH_RELATED_TARGET)) local($value))
    )

    (func $MouseEvent:relatedTarget/get<ref>i32 
        (param $this                        <MouseEvent>) 
        (result $value                               i32) 

        $ref($MouseEvent:relatedTarget/get<ref>ref( this )) 
    )

    (func $MouseEvent:relatedTarget/get<ref>ref 
        (param $this                        <MouseEvent>) 
        (result $value                          <Object>) 

        (apply $self.MouseEvent:relatedTarget/get this ref) 
    )

    (func $MouseEvent:relatedTarget/load<i32>i32 
        (param $offset                                 i32) 
        (result $value                                 i32) 

        (i32.load offset=48 local($offset))
    )

    (func $MouseEvent:relatedTarget/store<i32.i32> 
        (param $offset                                 i32) 
        (param $value                                  i32) 

        (i32.store offset=48 local($offset) local($value))
    )


