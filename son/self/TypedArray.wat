
    (alias $Uint8Array:new                   $Uint8Array:new<ref>ref)
    (alias $Uint8Array.of                     $Uint8Array.of<ref>ref)
    (alias $Uint8Array.from                 $Uint8Array.from<ref>ref)

    (func $Uint8Array:new<>ref 
        (result $this                              <Uint8Array>) 
        (new $self.Uint8Array<>ref) 
    )

    (func $Uint8Array:new<i32>ref 
        (param $length                                 i32) 
        (result $this                              <Uint8Array>) 

        (new $self.Uint8Array<i32>ref local($length)) 
    )

    (func $Uint8Array:new<ref>ref 
        (param $value                                  ref) 
        (result $this                              <Uint8Array>) 

        (new $self.Uint8Array<ref>ref local($value)) 
    )

    (func $Uint8Array:from<ref>ref 
        (param $value                             <Object>) 
        (result $this                              <Uint8Array>) 

        (call $self.Uint8Array.from<ref>ref local($value))
    )

    (func $Uint8Array.of<ref>ref 
        (param $value                             <Object>) 
        (result $this                              <Uint8Array>) 

        (call $self.Uint8Array.of<ref>ref local($value))
    )

    (func $Uint8Array.of<refx2>ref 
        (param $value/0                                ref) 
        (param $value/1                                ref) 
        (result $this                              <Uint8Array>) 

        (call $self.Uint8Array.of<refx2>ref
            local($value/0) local($value/1)
        )
    )

    (func $Uint8Array.of<refx3>ref 
        (param $value/0                                ref) 
        (param $value/1                                ref) 
        (param $value/2                                ref) 
        (result $this                              <Uint8Array>) 

        (call $self.Uint8Array.of<refx3>ref
            local($value/0) local($value/1) local($value/2)
        )
    )

    (func $Uint8Array.of<ref.i32>ref 
        (param $value/0                                ref) 
        (param $value/1                                i32) 
        (result $this                              <Uint8Array>) 

        (call $self.Uint8Array.of<ref.i32>ref
            local($value/0) local($value/1)
        )
    )
