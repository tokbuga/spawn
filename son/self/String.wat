
    (alias $String:new                   $String:new<ref>ref)

    (func $String:new<>ref 
        (result $this                              <String>) 
        (new $self.String<>ref) 
    )

    (func $String:new<ref>ref 
        (param $value                                   ref) 
        (result $this                              <String>) 

        (new $self.String<ref>ref local($value)) 
    )

    (func $String.fromCharCode<i32>ref 
        (param $charCode                                i32) 
        (result $this                              <String>) 

        (call $self.String.fromCharCode<i32>ref local($charCode))
    )

    (func $String:match<refx2>ref 
        (param $text                               <string>) 
        (param $regexp                             <RegExp>) 
        (result $array                              <Array>) 

        (apply $self.String:match<ref>ref
            this (param local($regexp))
        )
    )

    (func $String:padStart<ref.i32x2>ref 
        (param $text                               <string>) 
        (param $length                                  i32) 
        (param $value                                   i32) 
        (result $text                              <string>) 

        (apply $self.String:padStart<i32x2>ref
            this (param local($length) local($value))
        )
    )
