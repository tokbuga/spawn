
    (alias $Array:new                   $Array:new<ref>ref)
    (alias $Array.of                     $Array.of<ref>ref)
    (alias $Array.from                 $Array.from<ref>ref)

    (func $Array:new<>ref 
        (result $this                              <Array>) 
        (new $self.Array<>ref) 
    )

    (func $Array:new<i32>ref 
        (param $length                                 i32) 
        (result $this                              <Array>) 

        (new $self.Array<i32>ref local($length)) 
    )

    (func $Array:new<ref>ref 
        (param $value                                  ref) 
        (result $this                              <Array>) 

        (new $self.Array<ref>ref local($value)) 
    )

    (func $Array:map<refx2>ref 
        (param $this                               <Array>) 
        (param $callback                        <Function>) 
        (result $this                              <Array>) 

        (apply $self.Array:map<ref>ref this (param local($callback)))
    )

    (func $Array:join<ref>ref 
        (param $this                               <Array>) 
        (result $text                             <string>) 

        (call $Array:join<refx2>ref this (call $self.String<>ref))
    )

    (func $Array:join<refx2>ref 
        (param $this                               <Array>) 
        (param $connector                         <string>) 
        (result $text                             <string>) 

        (apply $self.Array:join<ref>ref this (param local($connector)))
    )

    (func $Array:splice<ref.i32x2.ref> 
        (param $this                               <Array>) 
        (param $index                                  i32) 
        (param $count                                  i32) 
        (param $insert                                 ref) 

        (apply $self.Array:splice<i32x2.ref>
            this 
            (param 
                local($index)
                local($count)
                local($insert)
            )
        )
    )

    (func $Array:map<ref.fun>ref 
        (param $this                               <Array>) 
        (param $callback                           funcref) 
        (result $this                              <Array>) 

        (apply $self.Array:map<fun>ref this (param local($callback)))
    )

    (func $Array.from<ref>ref 
        (param $value                             <Object>) 
        (result $this                              <Array>) 

        (call $self.Array.from<ref>ref local($value))
    )

    (func $Array.of<ref>ref 
        (param $value                             <Object>) 
        (result $this                              <Array>) 

        (call $self.Array.of<ref>ref local($value))
    )

    (func $Array.of<refx2>ref 
        (param $value/0                                ref) 
        (param $value/1                                ref) 
        (result $this                              <Array>) 

        (call $self.Array.of<refx2>ref
            local($value/0) local($value/1)
        )
    )

    (func $Array.of<refx3>ref 
        (param $value/0                                ref) 
        (param $value/1                                ref) 
        (param $value/2                                ref) 
        (result $this                              <Array>) 

        (call $self.Array.of<refx3>ref
            local($value/0) local($value/1) local($value/2)
        )
    )

    (func $Array.of<ref.i32>ref 
        (param $value/0                                ref) 
        (param $value/1                                i32) 
        (result $this                              <Array>) 

        (call $self.Array.of<ref.i32>ref
            local($value/0) local($value/1)
        )
    )
