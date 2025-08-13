
    (alias $Window:new                      $Window:new<>ref)
    (alias $Window.from                 $Window.from<ref>ref)

    (func $Window:new<>ref 
        (result $this                              <Window>) 
        (new $self.Window<>ref) 
    )

    (func $Window:new<ref>ref 
        (param $value                                  ref) 
        (result $this                              <Window>) 

        (new $self.Window<ref>ref local($value)) 
    )
