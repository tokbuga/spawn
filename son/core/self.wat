
    (func $parseInt<ref.i32>i32
        (param $string                  <string>)
        (param $base                         i32)
        (result $integer                     i32)

        (call $self.parseInt<ref.i32>i32 this local($base))
    )


    (alias $dispatchEvent    $dispatchEvent<ref>)

    (func $dispatchEvent<ref>   
        (param $event                    <Event>)
        (call $EventTarget:dispatchEvent<refx2> self this)
    )