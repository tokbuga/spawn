
    (global $WeakMap.LENGTH                    i32 i32(16))

    (alias $WeakMap:new                  $WeakMap:new<>ref)

    (func $WeakMap:new<>ref 
        (result $this                            <WeakMap>) 
        (new $self.WeakMap<>ref) 
    )

    (func $WeakMap:get<refx2>ref 
        (param $this                             <WeakMap>) 
        (param $key                               <Object>) 
        (result                                   <Object>) 

        (apply $self.WeakMap:get<ref>ref 
            this (param local($key))
        ) 
    )

    (func $WeakMap:get<refx2>i32 
        (param $this                             <WeakMap>) 
        (param $key                               <Object>) 
        (result                                        i32) 

        (apply $self.WeakMap:get<ref>i32 
            this (param local($key))
        ) 
    )

    (func $WeakMap:has<refx2>i32 
        (param $this                             <WeakMap>) 
        (param $key                               <Object>) 
        (result                                        i32) 

        (apply $self.WeakMap:has<ref>i32 
            this (param local($key))
        ) 
    )

    (func $WeakMap:hasnt<refx2>i32 
        (param $this                             <WeakMap>) 
        (param $key                               <Object>) 
        (result                                        i32) 
        $WeakMap:has<refx2>i32( this local($key) )(i32.eqz)
    )

    (func $WeakMap:set<refx3> 
        (param $this                             <WeakMap>) 
        (param $key                               <Object>) 
        (param $value                             <Object>) 

        (apply $self.WeakMap:set<ref.ref> 
            this (param local($key) local($value))
        ) 
    )

    (func $WeakMap:set<refx2.i32> 
        (param $this                             <WeakMap>) 
        (param $key                               <Object>) 
        (param $value                                  i32) 

        (apply $self.WeakMap:set<ref.i32> 
            this (param local($key) local($value))
        ) 
    )

    (func $WeakSet:ifset<refx3>i32 
        (param $this                             <WeakSet>) 
        (param $key                               <Object>) 
        (param $value                             <Object>) 
        (result $boolean                               i32) 

        (if (call $WeakMap:has<refx2>i32 this local($key))
            (then false return)
        )

        $WeakMap:set<refx3>( this 
            local($key) 
            local($value) 
        )
        
        true 
    )
    (func $WeakMap:delete<refx2> 
        (param $this                             <WeakMap>) 
        (param $key                               <Object>) 

        (apply $self.WeakMap:delete<ref> 
            this (param local($key))
        ) 
    )
