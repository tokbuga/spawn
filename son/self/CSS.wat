
    (alias $CSS.px                     $CSS.px<f32>ref)
    (alias $CSS.vw                     $CSS.vw<f32>ref)
    (alias $CSS.vh                     $CSS.vh<f32>ref)

    (func $CSS.px<f32>ref
        (param $value                              f32)
        (result $value                        <String>)
        (call $self.CSS.px<f32>ref this) 
    )

    (func $CSS.vw<f32>ref
        (param $value                              f32)
        (result $value                        <String>)
        (call $self.CSS.vw<f32>ref this) 
    )

    (func $CSS.vh<f32>ref
        (param $value                              f32)
        (result $value                        <String>)
        (call $self.CSS.vh<f32>ref this) 
    )