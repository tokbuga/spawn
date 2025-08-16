
    (alias $Event:bubbles                                  $Event:bubbles<ref>i32)
    (alias $Event:cancelable                            $Event:cancelable<ref>i32)
    (alias $Event:composed                                $Event:composed<ref>i32)
    (alias $Event:defaultPrevented                $Event:defaultPrevented<ref>i32)
    (alias $Event:eventPhase                            $Event:eventPhase<ref>i32)
    (alias $Event:isTrusted                              $Event:isTrusted<ref>i32)
    (alias $Event:type                                        $Event:type<ref>ref)
    (alias $Event:timeStamp                              $Event:timeStamp<ref>f32)
    (alias $Event:currentTarget                      $Event:currentTarget<ref>ref)
    (alias $Event:target                                    $Event:target<ref>ref)
    (alias $Event:preventDefault                       $Event:preventDefault<ref>)
    (alias $Event:stopPropagation                     $Event:stopPropagation<ref>)
    (alias $Event:stopImmediatePropagation   $Event:stopImmediatePropagation<ref>)
    (alias $Event:composedPath                        $Event:composedPath<ref>ref)

    (func $Event:bubbles<ref>i32 
        (param $this                               <Event>) 
        (result $isBubblesUp                           i32) 

        (apply $self.Event:bubbles/get this i32)
    )

    (func $Event:cancelable<ref>i32 
        (param $this                               <Event>) 
        (result $isCancelable                          i32) 

        (apply $self.Event:cancelable/get this i32)
    )

    (func $Event:composed<ref>i32 
        (param $this                               <Event>) 
        (result $isComposed                            i32) 

        (apply $self.Event:composed/get this i32)
    )

    (func $Event:defaultPrevented<ref>i32 
        (param $this                               <Event>) 
        (result $isDefaultPrevented                    i32) 

        (apply $self.Event:defaultPrevented/get this i32)
    )

    (func $Event:eventPhase<ref>i32 
        (param $this                       <Event>) 
        (result $eventPhase                    i32) 

        (apply $self.Event:eventPhase/get this i32)
    )

    (func $Event:isTrusted<ref>i32 
        (param $this                               <Event>) 
        (result $isTrusted                             i32) 

        (get <refx2>i32 this text("isTrusted"))
    )

    (func $Event:type<ref>ref 
        (param $this                               <Event>) 
        (result $type                             <String>) 

        (apply $self.Event:type/get this externref)
    )

    (func $Event:timeStamp<ref>f32 
        (param $this                               <Event>) 
        (result $timeStamp                             f32) 

        (apply $self.Event:timeStamp/get this f32)
    )

    (func $Event:currentTarget<ref>ref 
        (param $this                               <Event>) 
        (result $target                      <EventTarget>) 

        (apply $self.Event:currentTarget/get this externref) 
    )

    (func $Event:target<ref>ref 
        (param $this                               <Event>) 
        (result $target                      <EventTarget>) 

        (apply $self.Event:target/get this externref)
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
