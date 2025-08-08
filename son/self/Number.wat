
    (alias $Number:new                   $Number:new<ref>ref)

    (func $Number:new<>ref 
        (result $this                              <Number>) 
        (new $self.Number<>ref) 
    )

    (func $Number:new<ref>ref 
        (param $value                                   ref) 
        (result $this                              <Number>) 

        (new $self.Number<ref>ref local($value)) 
    )

    (func $Number<i32>ref 
        (param $value                                   i32) 
        (result $number                                 ref) 

        (call $self.Number<i32>ref local($value)) 
    )

    (func $Number:toString<i32x2>ref 
        (param $number                                  i32) 
        (param $base                                    i32) 
        (result $string                            <string>) 

        (apply $self.Number:toString<i32>ref 
            $Number<i32>ref( this ) (param local($base))
        )
    )
