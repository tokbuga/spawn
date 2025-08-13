
    (alias $Math.random                $Math.random<>f32)

    (global $self.Math.random                        ref)

    (func $Math.random<>f32 
        (result $value                               f32) 
        (call $self.Math.random<>f32)
    )

