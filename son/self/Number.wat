
    (alias $Number:new                   $Number:new<ref>ref)
    (alias $Number                           $Number<ref>i32)

    (func $Number:new<>ref 
        (result $this                              <Number>) 
        (new $self.Number<>ref) 
    )

    (func $Number:new<ref>ref 
        (param $value                                   ref) 
        (result $this                              <Number>) 

        (new $self.Number<ref>ref local($value)) 
    )

    (func $Number:new<i32>ref 
        (param $value                                   i32) 
        (result $this                              <Number>) 

        (new $self.Number<i32>ref local($value)) 
    )

    (func $Number:new<f32>ref 
        (param $value                                   f32) 
        (result $this                              <Number>) 

        (new $self.Number<f32>ref local($value)) 
    )

    (func $Number:toString<i32>ref 
        (param $integer                                 i32) 
        (result $number                            <string>) 

        (apply $self.Number:toString<i32>ref 
            $Number:new<i32>ref( this ) (param i32(16))
        )
    )

    (func $Number<i32>ref 
        (param $value                                   i32) 
        (result $number                                 ref) 

        (call $self.Number<i32>ref local($value)) 
    )

    (func $Number<ref>i32 
        (param $value                                   ref) 
        (result $number                                 i32) 

        (call $self.Number<ref>i32 local($value)) 
    )

    (func $Number:toString<i32x2>ref 
        (param $number                                  i32) 
        (param $base                                    i32) 
        (result $string                            <string>) 

        (apply $self.Number:toString<i32>ref 
            $Number<i32>ref( this ) (param local($base))
        )
    )
