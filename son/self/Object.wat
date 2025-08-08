
    (alias $Object:new                      $Object:new<>ref)
    (alias $Object.fromEntries   $Object.fromEntries<ref>ref)

    (func $Object:new<>ref 
        (result $this                             <Object>) 
        (new $self.Object<>ref) 
    )

    (func $Object:new<ref>ref 
        (param $value                             <Object>) 
        (result $this                             <Object>) 

        (new $self.Object<ref>ref local($value)) 
    )

    (func $Object.fromEntries<ref>ref 
        (param $entries                            <Array>) 
        (result $this                             <Object>) 

        (call $self.Object.fromEntries<ref>ref local($entries))
    )

    (func $Object.fromKeyValue<refx2>ref 
        (param $key                               <String>) 
        (param $value                             <Object>) 
        (result $this                             <Object>) 

        $Object.fromEntries<ref>ref(
            $Array:new<ref>ref(
                $Array.of<refx2>ref( 
                    local($key) local($value)
                )
            )
        )
    )
