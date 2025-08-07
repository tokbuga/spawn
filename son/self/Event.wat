
    (global $Event.LENGTH                      i32 i32(24))
    (global $Event.HDRLEN                      i32 i32(24))

    (memory $Event:bubbles                      1 1 shared)
    (memory $Event:cancelable                   1 1 shared)
    (memory $Event:composed                     1 1 shared)
    (memory $Event:defaultPrevented             1 1 shared)
    (memory $Event:eventPhase                   1 1 shared)
    (memory $Event:isTrusted                    1 1 shared)
    (memory $Event:type                         2 2 shared)
    (memory $Event:timeStamp                    4 4 shared)
    (memory $Event:currentTarget                4 4 shared)
    (memory $Event:target                       4 4 shared)

    (global $Event.NONE                         i32 i32(0))
    (global $Event.AT_TARGET                    i32 i32(2))
    (global $Event.BUBBLING_PHASE               i32 i32(2))
    (global $Event.CAPTURING_PHASE              i32 i32(3))

    (global $type.Event.POINTERMOVE             i32 i32(5))
    (global $text.Event.POINTERMOVE          "pointermove")
    (global $type.Event.POINTERDOWN             i32 i32(6))
    (global $text.Event.POINTERDOWN          "pointerdown")

    (global $type.Event.EVENT                   i32 i32(0))
    (global $type.Event.DROP                    i32 i32(2))
    (global $type.Event.DRAGSTART               i32 i32(3))
    (global $type.Event.DRAG                    i32 i32(4))

    (global $text.Event.EVENT                      "event")
    (global $text.Event.DROP                        "drop")
    (global $text.Event.DRAGSTART              "dragstart")
    (global $text.Event.DRAG                        "drag")

    (global $Event.OFFSET_BUBBLES               i32 i32(0))
    (global $Event.LENGTH_BUBBLES               i32 i32(1))

    (global $Event.OFFSET_CANCELABLE            i32 i32(1))
    (global $Event.LENGTH_CANCELABLE            i32 i32(1))

    (global $Event.OFFSET_COMPOSED              i32 i32(2))
    (global $Event.LENGTH_COMPOSED              i32 i32(1))

    (global $Event.OFFSET_DEFAULT_PREVENTED     i32 i32(3))
    (global $Event.LENGTH_DEFAULT_PREVENTED     i32 i32(1))

    (global $Event.OFFSET_EVENT_PHASE           i32 i32(4))
    (global $Event.LENGTH_EVENT_PHASE           i32 i32(1))

    (global $Event.OFFSET_IS_TRUSTED            i32 i32(5))
    (global $Event.LENGTH_IS_TRUSTED            i32 i32(1))

    (global $Event.OFFSET_TYPE                  i32 i32(6))
    (global $Event.LENGTH_TYPE                  i32 i32(2))

    (global $Event.OFFSET_TIMESTAMP             i32 i32(8))
    (global $Event.LENGTH_TIMESTAMP             i32 i32(4))

    (global $Event.OFFSET_CURRENT_TARGET       i32 i32(12))
    (global $Event.LENGTH_CURRENT_TARGET        i32 i32(4))

    (global $Event.OFFSET_TARGET               i32 i32(16))
    (global $Event.LENGTH_TARGET                i32 i32(4))

    (global $Event.OFFSET_PADDING              i32 i32(20))
    (global $Event.LENGTH_PADDING               i32 i32(4))


    (global $type.Event<Map>                    mut extern)

    (func $type.Event<Map>:get<ref>i32
        (param $name                              <String>)
        (result $type                                  i32)

        (apply $self.Map:get<ref>i32 
            $type.Event<Map>() (param local($name))
        )
    )

    (func $type.Event<Map>:set<ref.i32>
        (param $name                              <String>)
        (param $type                                   i32)

        (apply $self.Map:set<ref.i32> 
            global($type.Event<Map>)
            (param local($name) local($type))
        )
    )

    (func $type.Event<Map> 
        (result $type                                <Map>) 
        (local $typeMap                              <Map>) 

        (if (ref.is_null global($type.Event<Map>))
            (then
                (global #type.Event<Map> new $self.Map())

                $type.Event<Map>:set<ref.i32>( global($text.Event.EVENT) global($type.Event.EVENT) )
                $type.Event<Map>:set<ref.i32>( global($text.Event.DROP) global($type.Event.DROP) )
                $type.Event<Map>:set<ref.i32>( global($text.Event.DRAGSTART) global($type.Event.DRAGSTART) )
                $type.Event<Map>:set<ref.i32>( global($text.Event.DRAG) global($type.Event.DRAG) )
                $type.Event<Map>:set<ref.i32>( global($text.Event.POINTERMOVE) global($type.Event.POINTERMOVE) )
                $type.Event<Map>:set<ref.i32>( global($text.Event.POINTERDOWN) global($type.Event.POINTERDOWN) )
            )
        ) 

        global($type.Event<Map>)
    )

    (func $Event.from<ref>i32
        (param $this                               <Event>)
        (result $offset                                i32)

        (local $offset                                 i32)
        (local #offset $malloc(global($Event.LENGTH)))

        $Event.store<ref.i32>(
            this local($offset)
        )

        local($offset)
    )

    (func $Event.store<ref.i32>
        (param $event                              <Event>)
        (param $offset                                 i32)
        
        $Event:bubbles/store<i32.i32>( 
            local($offset) $Event:bubbles/get<ref>i32( this )  
        )

        $Event:cancelable/store<i32.i32>( 
            local($offset) $Event:cancelable/get<ref>i32( this )  
        )
        
        $Event:composed/store<i32.i32>( 
            local($offset) $Event:composed/get<ref>i32( this )  
        )
        
        $Event:defaultPrevented/store<i32.i32>( 
            local($offset) $Event:defaultPrevented/get<ref>i32( this )  
        )
        
        $Event:eventPhase/store<i32.i32>( 
            local($offset) $Event:eventPhase/get<ref>i32( this )  
        )
        
        $Event:isTrusted/store<i32.i32>( 
            local($offset) $Event:isTrusted/get<ref>i32( this )  
        )
        
        $Event:timeStamp/store<i32.f32>( 
            local($offset) $Event:timeStamp/get<ref>f32( this )  
        )
        
        $Event:type/store<i32.i32>( 
            local($offset) $Event:type/get<ref>i32( this )
        )
        
        $Event:currentTarget/store<i32.i32>( 
            local($offset) $Event:currentTarget/get<ref>i32( this )
        )
        
        $Event:target/store<i32.i32>( 
            local($offset) $Event:target/get<ref>i32( this )
        )
    )

    (func $Event:bubbles/read<i32>i32 
        (param $index                                 i32) 
        (result $bubbles                               i32) 

        (i32.load8_u (memory $Event:bubbles) local($index))
    )

    (func $Event:bubbles/write<i32.i32> 
        (param $index                                  i32) 
        (param $bubbles                                i32) 

        (i32.store8 (memory $Event:bubbles) local($index) local($bubbles))
    )

    (func $Event:bubbles/load<i32>i32 
        (param $offset                                 i32) 
        (result $bubbles                               i32) 

        (i32.load8_u offset=0 local($offset))
    )

    (func $Event:bubbles/store<i32.i32> 
        (param $offset                                 i32) 
        (param $bubbles                                i32) 

        (i32.store8 offset=0 local($offset) local($bubbles))
    )

    (func $Event:bubbles/get<ref>i32 
        (param $this                               <Event>) 
        (result $isBubblesUp                           i32) 

        (apply $self.Event:bubbles/get this i32)
    )


    (func $Event:cancelable/read<i32>i32 
        (param $index                                  i32) 
        (result $cancelable                            i32) 

        (i32.load8_u (memory $Event:cancelable) local($index))
    )

    (func $Event:cancelable/write<i32.i32> 
        (param $index                                  i32) 
        (param $cancelable                             i32) 

        (i32.store8 (memory $Event:cancelable) local($index) local($cancelable))
    )

    (func $Event:cancelable/get<ref>i32 
        (param $this                               <Event>) 
        (result $isCancelable                          i32) 

        (apply $self.Event:cancelable/get this i32)
    )

    (func $Event:cancelable/load<i32>i32 
        (param $offset                                 i32) 
        (result $cancelable                            i32) 

        (i32.load8_u offset=1 local($offset))
    )

    (func $Event:cancelable/store<i32.i32> 
        (param $offset                                 i32) 
        (param $cancelable                             i32) 

        (i32.store8 offset=1 local($offset) local($cancelable))
    )


    (func $Event:composed/read<i32>i32 
        (param $index                                  i32) 
        (result $composed                              i32) 

        (i32.load8_u (memory $Event:composed) local($index))
    )

    (func $Event:composed/write<i32.i32> 
        (param $index                                  i32) 
        (param $composed                               i32) 

        (i32.store8 (memory $Event:composed) local($index) local($composed))
    )

    (func $Event:composed/get<ref>i32 
        (param $this                               <Event>) 
        (result $isComposed                            i32) 

        (apply $self.Event:composed/get this i32)
    )

    (func $Event:composed/load<i32>i32 
        (param $offset                                 i32) 
        (result $composed                              i32) 

        (i32.load8_u offset=2 local($offset))
    )

    (func $Event:composed/store<i32.i32> 
        (param $offset                                 i32) 
        (param $composed                               i32) 

        (i32.store8 offset=2 local($offset) local($composed))
    )


    (func $Event:defaultPrevented/read<i32>i32 
        (param $index                                  i32) 
        (result $defaultPrevented                      i32) 

        (i32.load8_u (memory $Event:defaultPrevented) local($index))
    )

    (func $Event:defaultPrevented/write<i32.i32> 
        (param $index                                  i32) 
        (param $defaultPrevented                       i32) 

        (i32.store8 (memory $Event:defaultPrevented) local($index) local($defaultPrevented))
    )

    (func $Event:defaultPrevented/get<ref>i32 
        (param $this                               <Event>) 
        (result $isDefaultPrevented                    i32) 

        (apply $self.Event:defaultPrevented/get this i32)
    )

    (func $Event:defaultPrevented/load<i32>i32 
        (param $offset                                 i32) 
        (result $defaultPrevented                      i32) 

        (i32.load8_u offset=3 local($offset))
    )

    (func $Event:defaultPrevented/store<i32.i32> 
        (param $offset                                 i32) 
        (param $defaultPrevented                       i32) 

        (i32.store8 offset=3 local($offset) local($defaultPrevented))
    )


    (func $Event:eventPhase/read<i32>i32 
        (param $index                                  i32) 
        (result $eventPhase                            i32) 

        (i32.load8_u (memory $Event:eventPhase) local($index))
    )

    (func $Event:eventPhase/write<i32.i32> 
        (param $index                                  i32) 
        (param $eventPhase                             i32) 

        (i32.store8 (memory $Event:eventPhase) local($index) local($eventPhase))
    )

    (func $Event:eventPhase/get<ref>i32 
        (param $this                       <Event>) 
        (result $eventPhase                    i32) 

        (apply $self.Event:eventPhase/get this i32)
    )

    (func $Event:eventPhase/load<i32>i32 
        (param $offset                                 i32) 
        (result $eventPhase                            i32) 

        (i32.load8_u offset=4 local($offset))
    )

    (func $Event:eventPhase/store<i32.i32> 
        (param $offset                                 i32) 
        (param $eventPhase                             i32) 

        (i32.store8 offset=4 local($offset) local($eventPhase))
    )


    (func $Event:isTrusted/read<i32>i32 
        (param $index                                  i32) 
        (result $isTrusted                             i32) 

        (i32.load8_u (memory $Event:isTrusted) local($index))
    )

    (func $Event:isTrusted/write<i32.i32> 
        (param $index                                  i32) 
        (param $isTrusted                              i32) 

        (i32.store8 (memory $Event:isTrusted) local($index) local($isTrusted))
    )

    (func $Event:isTrusted/get<ref>i32 
        (param $this                               <Event>) 
        (result $isTrusted                             i32) 

        (get <refx2>i32 this text("isTrusted"))
    )

    (func $Event:isTrusted/load<i32>i32 
        (param $offset                                 i32) 
        (result $isTrusted                             i32) 

        (i32.load8_u offset=5 local($offset))
    )

    (func $Event:isTrusted/store<i32.i32> 
        (param $offset                                 i32) 
        (param $isTrusted                              i32) 

        (i32.store8 offset=5 local($offset) local($isTrusted))
    )


    (func $Event:type/read<i32>i32 
        (param $index                                  i32) 
        (result $type                                  i32) 

        (i32.load16_u (memory $Event:type) (i32.mul local($index) global($Event.LENGTH_TYPE)))
    )

    (func $Event:type/write<i32.i32> 
        (param $index                                  i32) 
        (param $type                                   i32) 

        (i32.store16 (memory $Event:type) (i32.mul local($index) global($Event.LENGTH_TYPE)) local($type))
    )

    (func $Event:type/get<ref>ref 
        (param $this                               <Event>) 
        (result $type                             <String>) 

        (apply $self.Event:type/get this externref)
    )

    (func $Event:type/get<ref>i32 
        (param $this                               <Event>) 
        (result $type                                  i32) 

        $type.Event<Map>:get<ref>i32(
            $Event:type/get<ref>ref( this )
        )
    )

    (func $Event:type/load<i32>i32 
        (param $offset                                 i32) 
        (result $type                                  i32) 

        (i32.load16_u offset=6 local($offset))
    )

    (func $Event:type/store<i32.i32> 
        (param $offset                                 i32) 
        (param $type                                   i32) 

        (i32.store16 offset=6 local($offset) local($type))
    )


    (func $Event:timeStamp/read<i32>f32 
        (param $index                                  i32) 
        (result $timeStamp                             f32) 

        (f32.load (memory $Event:timeStamp) (i32.mul local($index) global($Event.LENGTH_TIMESTAMP)))
    )

    (func $Event:timeStamp/write<i32.f32> 
        (param $index                                  i32) 
        (param $timeStamp                              f32) 

        (f32.store (memory $Event:timeStamp) (i32.mul local($index) global($Event.LENGTH_TIMESTAMP)) local($timeStamp))
    )

    (func $Event:timeStamp/get<ref>f32 
        (param $this                               <Event>) 
        (result $timeStamp                             f32) 

        (apply $self.Event:timeStamp/get this f32)
    )

    (func $Event:timeStamp/load<i32>f32 
        (param $offset                                 i32) 
        (result $timeStamp                             f32) 

        (f32.load offset=8 local($offset))
    )

    (func $Event:timeStamp/store<i32.f32> 
        (param $offset                                 i32) 
        (param $timeStamp                              f32) 

        (f32.store offset=8 local($offset) local($timeStamp))
    )

    
    (func $Event:currentTarget/read<i32>i32 
        (param $index                                  i32) 
        (result $currentTarget                         i32) 

        (i32.load (memory $Event:currentTarget) (i32.mul local($index) global($Event.LENGTH_CURRENT_TARGET)))
    )

    (func $Event:currentTarget/write<i32.i32> 
        (param $index                                  i32) 
        (param $currentTarget                          i32) 

        (i32.store (memory $Event:currentTarget) (i32.mul local($index) global($Event.LENGTH_CURRENT_TARGET)) local($currentTarget))
    )

    (func $Event:currentTarget/get<ref>ref 
        (param $this                               <Event>) 
        (result $target                      <EventTarget>) 

        (apply $self.Event:currentTarget/get this externref) 
    )

    (func $Event:currentTarget/get<ref>i32 
        (param $this                               <Event>) 
        (result $target                                i32) 

        $ref($Event:currentTarget/get<ref>ref( this )) 
    )

    (func $Event:currentTarget/load<i32>i32 
        (param $offset                                 i32) 
        (result $currentTarget                         i32) 

        (i32.load offset=12 local($offset))
    )

    (func $Event:currentTarget/store<i32.i32> 
        (param $offset                                 i32) 
        (param $currentTarget                          i32) 

        (i32.store offset=12 local($offset) local($currentTarget))
    )


    (func $Event:target/read<i32>i32 
        (param $index                                  i32) 
        (result $target                                i32) 

        (i32.load (memory $Event:target) (i32.mul local($index) global($Event.LENGTH_TARGET)))
    )

    (func $Event:target/write<i32.i32> 
        (param $index                                  i32) 
        (param $target                                 i32) 

        (i32.store (memory $Event:target) (i32.mul local($index) global($Event.LENGTH_TARGET)) local($target))
    )

    (func $Event:target/get<ref>ref 
        (param $this                               <Event>) 
        (result $target                      <EventTarget>) 

        (apply $self.Event:target/get this externref)
    )

    (func $Event:target/get<ref>i32 
        (param $this                               <Event>) 
        (result $index                                 i32) 
        
        $ref($Event:target/get<ref>ref( this ))
    )

    (func $Event:target/load<i32>i32 
        (param $offset                                 i32) 
        (result $target                                i32) 

        (i32.load offset=16 local($offset))
    )

    (func $Event:target/store<i32.i32> 
        (param $offset                                 i32) 
        (param $target                                 i32) 

        (i32.store offset=16 local($offset) local($target))
    )


    (func $Event:preventDefault<ref> 
        (param $this                               <Event>) 
        (apply $self.Event:preventDefault this)
    )

    (func $Event:stopPropagation<ref> 
        (param $this                               <Event>) 
        (apply $self.Event:stopPropagation this)
    )

    (func $Event:stopImmediatePropagation<ref> 
        (param $this                               <Event>) 
        (apply $self.Event:stopImmediatePropagation this)
    )

    (func $Event:composedPath<ref>ref 
        (param $this                               <Event>) 
        (result $composedPath                      <Array>) 
        (apply $self.Event:composedPath this externref)
    )
