
    (alias $Promise:then                   $Promise:then<ref.fun>)
    (alias $Promise:catch                  $Promise:catch<ref.fun>)
    (alias $Promise.withResolvers          $Promise.withResolvers<>ref)

    (func $Promise:then<ref.fun> 
        (param $this                             <Promise>) 
        (param $callback                           funcref) 

        (apply $self.Promise:then<fun> this (param local($callback))) 
    )

    (func $Promise:then<ref.fun>ref 
        (param $this                             <Promise>) 
        (param $callback                           funcref) 
        (result $this                            <Promise>) 

        (apply $self.Promise:then<fun>ref this (param local($callback))) 
    )

    (func $Promise:catch<ref.fun> 
        (param $this                             <Promise>) 
        (param $callback                           funcref) 

        (apply $self.Promise:catch<fun> this (param local($callback))) 
    )

    (func $Promise.withResolvers<>ref 
        (result $withResolvers                    <Object>) 

        (call $self.Promise.withResolvers<ref>ref global($self.Promise)) 
    )

