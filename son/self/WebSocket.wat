
    (alias $WebSocket:new                 $WebSocket:new<ref>ref)
    (alias $WebSocket:send                $WebSocket:send<refx2>)
    (alias $WebSocket:postMessage         $WebSocket:send<refx2>)
    (alias $WebSocket:binaryType   $WebSocket:binaryType<ref>ref)

    (func $WebSocket:new<ref>ref 
        (param $socketURL                            <URL>) 
        (result $this                          <WebSocket>) 

        (new $self.WebSocket<ref>ref local($socketURL)) 
    )

    (func $WebSocket:new<refx2>ref 
        (param $socketURL                            <URL>) 
        (param $protocols                          <Array>) 
        (result $this                          <WebSocket>) 

        (new $self.WebSocket<refx2>ref 
            local($socketURL)
            local($protocols)
        ) 
    )

    (func $WebSocket:send<refx2>
        (param $socket                         <WebSocket>)
        (param $message                           <Object>)

        (apply $self.WebSocket:send<ref>
            this (param local($message))
        )
    )

    (func $WebSocket:binaryType<refx2>
        (param $socket                         <WebSocket>)
        (param $binaryType                        <string>)

        (apply $self.WebSocket:binaryType/set<ref>
            this (param local($binaryType))
        )
    )

    (func $WebSocket:binaryType<ref>ref
        (param $socket                         <WebSocket>)
        (result $binaryType                       <string>)

        (apply $self.WebSocket:binaryType/get this ref)
    )

    (func $WebSocket:onopen<ref.fun>
        (param $socket                         <WebSocket>)
        (param $onopen                             funcref)

        (apply $self.WebSocket:onopen/set<fun>
            this (param local($onopen))
        )
    )

    (func $WebSocket:onopen<ref>fun
        (param $socket                         <WebSocket>)
        (result $onopen                            funcref)

        (apply $self.WebSocket:onopen/get<>fun this (param))
    )

    (func $WebSocket:onmessage<ref.fun>
        (param $socket                         <WebSocket>)
        (param $onmessage                          funcref)

        (apply $self.WebSocket:onmessage/set<fun>
            this (param local($onmessage))
        )
    )

    (func $WebSocket:onmessage<ref>fun
        (param $socket                         <WebSocket>)
        (result $onmessage                         funcref)

        (apply $self.WebSocket:onmessage/get<>fun this (param))
    )
