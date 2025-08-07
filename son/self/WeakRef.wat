
    (global $WeakRef.LENGTH                    i32 i32(16))

    (func $WeakRef:new<ref>ref 
        (param $value                             <Object>) 
        (result $this                            <WeakRef>) 
        (new $self.WeakRef<ref>ref local($value)) 
    )

    (func $WeakRef:deref<ref>ref 
        (param $this                             <WeakRef>) 
        (result $value                            <Object>) 

        (apply $self.WeakRef:deref this ref) 
    )
