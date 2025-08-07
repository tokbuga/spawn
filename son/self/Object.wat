

    (alias $Object:new                    $Object:new<>ref)

    (func $Object:new<>ref 
        (result $this                             <Object>) 
        (new $self.Object<>ref) 
    )

    (func $Object:new<ref>ref 
        (param $scriptURL                            <URL>) 
        (result $this                             <Worker>) 

        (new $self.Worker<ref>ref local($scriptURL)) 
    )

