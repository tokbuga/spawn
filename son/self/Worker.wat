
    (alias $Worker:new                 $Worker:new<ref>ref)
    (alias $Worker:postMessage  $Worker:postMessage<refx2>)
    (alias $WorkerOptions:new      $WorkerOptions:new<>ref)

    (func $Worker:new<ref>ref 
        (param $scriptURL                            <URL>) 
        (result $this                             <Worker>) 

        $Worker:new<refx2>ref( 
            this
            null 
        ) 
    )

    (func $Worker:new<refx2>ref 
        (param $scriptURL                            <URL>) 
        (param $options                    <WorkerOptions>) 
        (result $this                             <Worker>) 

        (if (null === local($options))
            (then local($options $WorkerOptions:new()))
        )

        (new $self.Worker<refx2>ref 
            local($scriptURL)
            local($options)
        ) 
    )

    (func $WorkerOptions:new<refx3>ref
        (param $name                              <Script>) 
        (param $type                              <String>) 
        (param $credentials                       <String>) 
        (result $this                      <WorkerOptions>) 

        (if (null === local($name))
            (then (local #name (get <refx2>ref self text("name"))))
        )

        (if (null === local($type))
            (then (local #type text("classic")))
        )

        (if (null === local($credentials))
            (then (local #credentials (get <ref>ref self) ))
        )
    
        $Object.fromEntries<ref>ref(
            $Array.of<refx3>ref(
                $Array.of<refx2>ref( text("name") local($name) )
                $Array.of<refx2>ref( text("type") local($type) )
                $Array.of<refx2>ref( text("credentials") local($credentials) )
            )
        )
    )

    (func $WorkerOptions:new<refx2>ref
        (param $name                              <Script>) 
        (param $type                              <String>) 
        (result $this                      <WorkerOptions>) 

        $WorkerOptions:new<refx3>ref(
            local($name) local($type) null
        )
    )

    (func $WorkerOptions:new<ref>ref
        (param $name                              <Script>) 
        (result $this                      <WorkerOptions>) 

        $WorkerOptions:new<refx2>ref( local($name) null )
    )

    (func $WorkerOptions:new<>ref
        (result $this                      <WorkerOptions>) 

        $WorkerOptions:new<ref>ref( null )
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