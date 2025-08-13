
    (alias $EventTarget:dispatchEvent                    $EventTarget:dispatchEvent<refx2>)
    (alias $EventTarget:addEventListener          $EventTarget:addEventListener<refx2.fun>)
    (alias $EventTarget:removeEventListener    $EventTarget:removeEventListener<refx2.fun>)

    (alias $AddEventListenerOptions.once                $AddEventListenerOptions.once<>ref)
    (alias $AddEventListenerOptions.capture          $AddEventListenerOptions.capture<>ref)
    (alias $AddEventListenerOptions.passive          $AddEventListenerOptions.passive<>ref)

    (func $EventTarget:new<>ref 
        (result $this                      <EventTarget>) 
        (construct $self.EventTarget<>ref)
    )

    (func $EventTarget:dispatchEvent<refx2> 
        (param $this                       <EventTarget>) 
        (param $event                            <Event>) 

        (apply $self.EventTarget:dispatchEvent<ref> 
            this (param local($event))
        )
    )

    (func $EventTarget:dispatchEvent<refx2>i32
        (param $this                       <EventTarget>) 
        (param $event                            <Event>) 
        (result $notcancelable                       i32)

        (apply $self.EventTarget:dispatchEvent<ref>i32 
            this (param local($event))
        )
    )

    (func $EventTarget:addEventListener<refx3> 
        (param $this                       <EventTarget>) 
        (param $eventType                       <string>) 
        (param $listener                      <Function>) 

        (apply $self.EventTarget:addEventListener<refx2> 
            this (param local($eventType) local($listener))
        )
    )

    (func $EventTarget:addEventListener<refx3.i32> 
        (param $this                       <EventTarget>) 
        (param $eventType                       <string>) 
        (param $listener                      <Function>) 
        (param $useCapture                           i32) 

        (apply $self.EventTarget:addEventListener<refx2.i32> 
            this (param local($eventType) local($listener) local($useCapture))
        )
    )

    (func $AddEventListenerOptions:new<i32x3.ref>ref
        (param $capture                              i32)
        (param $once                                 i32)
        (param $passive                              i32)
        (param $signal                     <AbortSignal>)
        (result $options       <AddEventListenerOptions>)

        $Object.fromEntries(
            $Array.of<refx4>ref(
                $Array.of<ref.i32>ref( text("capture") local($capture) )
                $Array.of<ref.i32>ref( text("once") local($once) )
                $Array.of<ref.i32>ref( text("passive") local($passive) )
                $Array.of<ref.ref>ref( text("signal") local($signal) )
            )
        )
    )

    (func $AddEventListenerOptions.capture<>ref        
        (result $options       <AddEventListenerOptions>)

        $AddEventListenerOptions:new<i32x3.ref>ref(
            true
            false
            false
            null
        )
    )

    (func $AddEventListenerOptions.once<>ref        
        (result $options       <AddEventListenerOptions>)

        $AddEventListenerOptions:new<i32x3.ref>ref(
            false
            true
            false
            null
        )
    )

    (func $AddEventListenerOptions.passive<>ref        
        (result $options       <AddEventListenerOptions>)
        $AddEventListenerOptions:new<i32x3.ref>ref(
            false
            false
            true
            null
        )
    )

    (func $EventTarget:addEventListener<refx4> 
        (param $this                       <EventTarget>) 
        (param $eventType                       <string>) 
        (param $listener                      <Function>) 
        (param $options        <AddEventListenerOptions>) 

        (apply $self.EventTarget:addEventListener<refx3> 
            this (param local($eventType) local($listener) local($options))
        )
    )

    (func $EventTarget:addEventListener<refx2.fun> 
        (param $this                        <EventTarget>) 
        (param $eventType                        <string>) 
        (param $listener                          funcref) 

        (apply $self.EventTarget:addEventListener<ref.fun> 
            this (param local($eventType) local($listener))
        )
    )

    (func $EventTarget:removeEventListener<refx3> 
        (param $this                        <EventTarget>) 
        (param $eventType                        <string>) 
        (param $listener                       <Function>) 

        (apply $self.EventTarget:removeEventListener<refx2> 
            this (param local($eventType) local($listener))
        )
    )

    (func $EventTarget:removeEventListener<refx4> 
        (param $this                        <EventTarget>) 
        (param $eventType                        <string>) 
        (param $listener                       <Function>) 
        (param $options            <EventListenerOptions>) 

        (apply $self.EventTarget:removeEventListener<refx3> 
            this (param local($eventType) local($listener) local($options))
        )
    )

    (func $EventTarget:removeEventListener<refx3.i32> 
        (param $this                        <EventTarget>) 
        (param $eventType                        <string>) 
        (param $listener                       <Function>) 
        (param $useCapture                            i32) 

        (apply $self.EventTarget:removeEventListener<refx2.i32> 
            this (param local($eventType) local($listener) local($useCapture))
        )
    )

    (func $EventTarget:removeEventListener<refx2.fun> 
        (param $this                        <EventTarget>) 
        (param $eventType                        <string>) 
        (param $listener                          funcref) 

        (apply $self.EventTarget:removeEventListener<ref.fun> 
            this (param local($eventType) local($listener))
        )
    )

    (func $EventTarget:removeEventListener<refx2.fun.ref> 
        (param $this                        <EventTarget>) 
        (param $eventType                        <string>) 
        (param $listener                          funcref) 
        (param $options            <EventListenerOptions>) 

        (apply $self.EventTarget:removeEventListener<ref.fun.ref> 
            this (param local($eventType) local($listener) local($options))
        )
    )

    (func $EventTarget:removeEventListener<refx2.fun.i32> 
        (param $this                        <EventTarget>) 
        (param $eventType                        <String>) 
        (param $listener                          funcref) 
        (param $useCapture                            i32) 

        (apply $self.EventTarget:removeEventListener<ref.fun.i32> 
            this (param local($eventType) local($listener) local($useCapture))
        )
    )
