
    (alias $Worker:new                 $Worker:new<ref>ref)
    (alias $Worker:postMessage  $Worker:postMessage<refx2>)

    (func $Worker:new<ref>ref 
        (param $scriptURL                            <URL>) 
        (result $this                             <Worker>) 

        (new $self.Worker<ref>ref local($scriptURL)) 
    )

    (func $Worker:new<refx2>ref 
        (param $scriptURL                            <URL>) 
        (param $options                           <Object>) 
        (result $this                             <Worker>) 

        (new $self.Worker<refx2>ref 
            local($scriptURL)
            local($options)
        ) 
    )

    (func $Worker:postMessage<refx2>
        (param $worker                      <Worker>)
        (param $message                     <Object>)

        (apply $self.Worker:postMessage<ref>
            this (param local($message))
        )
    )

    (func $Worker:postMessage<refx3>
        (param $worker                      <Worker>)
        (param $message                     <Object>)
        (param $transferList                 <Array>)

        (apply $self.Worker:postMessage<refx2>
            this 
            (param 
                local($message)
                local($transferList)
            )
        )
    )