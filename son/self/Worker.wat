
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