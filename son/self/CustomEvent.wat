
    (alias $CustomEvent:new                $CustomEvent:new<refx2>ref)
    (alias $CustomEventInit:new          $CustomEventInit:new<ref>ref)

    (func $CustomEvent:new<ref>ref
        (param $eventType                                    <String>)
        (result $cutomEvent                             <CustomEvent>)
        
        (construct $self.CustomEvent<ref>ref 
            local($eventType)
        )
    )

    (func $CustomEvent:new<refx2>ref
        (param $eventType                                    <String>)
        (param $options                             <CustomEventInit>)
        (result $cutomEvent                             <CustomEvent>)
        
        (construct $self.CustomEvent<refx2>ref 
            local($eventType) 
            local($options)
        )
    )

    (func $CustomEventInit:new<ref>ref
        (param $detail                                         <Any>)
        (result $cutomEvent                        <CustomEventInit>)

        $Object.fromEntries(
            $Array.of<ref>ref(
                $Array.of<refx2>ref( 
                    text("detail") local($detail) 
                )
            )
        )
    )