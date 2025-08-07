
    (global $WeakSet.LENGTH                    i32 i32(16))

    (alias $WeakSet:new                  $WeakSet:new<>ref)

    (func $WeakSet:new<>ref 
        (result $this                            <WeakSet>) 
        (new $self.WeakSet<>ref) 
    )

    (func $WeakSet:new<ref>ref 
        (param $value                              <Array>) 
        (result $this                            <WeakSet>) 

        (new $self.WeakSet<ref>ref
            local($value)
        ) 
    )

    (func $WeakSet:has<refx2>i32 
        (param $this                             <WeakSet>) 
        (param $value                             <Object>) 
        (result                                        i32) 

        (apply $self.WeakSet:has<ref>i32 
            this (param local($value))
        ) 
    )

    (func $WeakSet:add<refx2> 
        (param $this                             <WeakSet>) 
        (param $value                             <Object>) 

        (apply $self.WeakSet:add<ref> 
            this (param local($value))
        ) 
    )

    (func $WeakSet:ifadd<refx2>i32 
        (param $this                             <WeakSet>) 
        (param $value                             <Object>) 
        (result $boolean                               i32) 

        (if (call $WeakSet:has<refx2>i32 this local($value))
            (then false return)
        )

        $WeakSet:add<refx2>( this local($value) )
        
        true 
    )

    (func $WeakSet:delete<refx2> 
        (param $this                             <WeakSet>) 
        (param $value                             <Object>) 

        (apply $self.WeakSet:delete<ref> 
            this (param local($value))
        ) 
    )
