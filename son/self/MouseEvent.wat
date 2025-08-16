    
    (alias $MouseEvent:altKey                  $MouseEvent:altKey<ref>i32)
    (alias $MouseEvent:ctrlKey                $MouseEvent:ctrlKey<ref>i32)
    (alias $MouseEvent:metaKey                $MouseEvent:metaKey<ref>i32)
    (alias $MouseEvent:shiftKey              $MouseEvent:shiftKey<ref>i32)
    (alias $MouseEvent:button                  $MouseEvent:button<ref>i32)
    (alias $MouseEvent:clientX                $MouseEvent:clientX<ref>f32)
    (alias $MouseEvent:clientY                $MouseEvent:clientY<ref>f32)
    (alias $MouseEvent:movementX            $MouseEvent:movementX<ref>f32)
    (alias $MouseEvent:movementY            $MouseEvent:movementY<ref>f32)
    (alias $MouseEvent:offsetX                $MouseEvent:offsetX<ref>f32)
    (alias $MouseEvent:offsetY                $MouseEvent:offsetY<ref>f32)
    (alias $MouseEvent:pageX                    $MouseEvent:pageX<ref>f32)
    (alias $MouseEvent:pageY                    $MouseEvent:pageY<ref>f32)
    (alias $MouseEvent:screenX                $MouseEvent:screenX<ref>f32)
    (alias $MouseEvent:screenY                $MouseEvent:screenY<ref>f32)
    (alias $MouseEvent:relatedTarget    $MouseEvent:relatedTarget<ref>ref)

    (func $MouseEvent:altKey<ref>i32 
        (param $this                          <MouseEvent>) 
        (result $value                                 i32) 

        (apply $self.MouseEvent:altKey/get this i32) 
    )

    (func $MouseEvent:ctrlKey<ref>i32 
        (param $this                          <MouseEvent>) 
        (result $value                                 i32) 

        (apply $self.MouseEvent:ctrlKey/get this i32) 
    )

    (func $MouseEvent:metaKey<ref>i32 
        (param $this                          <MouseEvent>) 
        (result $value                                 i32) 

        (apply $self.MouseEvent:metaKey/get this i32) 
    )

    (func $MouseEvent:shiftKey<ref>i32 
        (param $this                          <MouseEvent>) 
        (result $value                                 i32) 

        (apply $self.MouseEvent:shiftKey/get this i32) 
    )

    (func $MouseEvent:button<ref>i32 
        (param $this                          <MouseEvent>) 
        (result $value                                 i32) 

        (apply $self.MouseEvent:button/get this i32) 
    )

    (func $MouseEvent:clientX<ref>f32 
        (param $this                          <MouseEvent>) 
        (result $clientX                               f32) 

        (apply $self.MouseEvent:clientX/get this f32) 
    )

    (func $MouseEvent:clientY<ref>f32 
        (param $this                          <MouseEvent>) 
        (result $value                                 f32) 

        (apply $self.MouseEvent:clientY/get this f32) 
    )

    (func $MouseEvent:movementX<ref>f32 
        (param $this                          <MouseEvent>) 
        (result $value                                 f32) 

        (apply $self.MouseEvent:movementX/get this f32) 
    )

    (func $MouseEvent:movementY<ref>f32 
        (param $this                          <MouseEvent>) 
        (result $value                                 f32) 

        (apply $self.MouseEvent:movementY/get this f32) 
    )

    (func $MouseEvent:offsetX<ref>f32 
        (param $this                          <MouseEvent>) 
        (result $value                                 f32) 

        (apply $self.MouseEvent:offsetX/get this f32) 
    )

    (func $MouseEvent:offsetY<ref>f32 
        (param $this                          <MouseEvent>) 
        (result $value                                 f32) 

        (apply $self.MouseEvent:offsetY/get this f32) 
    )

    (func $MouseEvent:pageX<ref>f32 
        (param $this                        <MouseEvent>) 
        (result $value                                 f32) 

        (apply $self.MouseEvent:pageX/get this f32) 
    )

    (func $MouseEvent:pageY<ref>f32 
        (param $this                        <MouseEvent>) 
        (result $value                                 f32) 

        (apply $self.MouseEvent:pageY/get this f32) 
    )

    (func $MouseEvent:screenX<ref>f32 
        (param $this                        <MouseEvent>) 
        (result $value                                 f32) 

        (apply $self.MouseEvent:screenX/get this f32) 
    )

    (func $MouseEvent:screenY<ref>f32 
        (param $this                        <MouseEvent>) 
        (result $value                                 f32) 

        (apply $self.MouseEvent:screenY/get this f32) 
    )

    (func $MouseEvent:relatedTarget<ref>ref 
        (param $this                        <MouseEvent>) 
        (result $value                          <Object>) 

        (apply $self.MouseEvent:relatedTarget/get this ref) 
    )
