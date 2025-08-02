(module
    (import "self" "SHARED_MEMORY"  (memory $memory 1 1 shared))
    (import "memory" "malloc"       (func $malloc (param $length i32) (result i32)))
    (import "nil" "array"           (global $nil/array ref))


    (import "memory" "i32_store_add_1"          (func $i32_store_add_1 (param i32)))
    (import "memory" "i32_store_add_n"          (func $i32_store_add_n (param i32 i32)))
    (import "memory" "i32_atomic_add_n"         (func $i32_atomic_add_n (param i32 i32) (result i32)))
    (import "memory" "i32_load"                 (func $i32_load (param i32) (result i32)))
    (import "memory" "f32_convert_i32_load_u"   (func $f32_convert_i32_load_u (param i32) (result f32)))
    (import "memory" "i32_store"                (func $i32_store (param i32 i32) ))

    (global $LENGTH_TICK_COUNT                 i32 i32(4))
    (global $OFFSET_TICK_COUNT           (mut i32) i32(0))

    (global $LENGTH_ELAPSED_TIME               i32 i32(8))
    (global $OFFSET_ELAPSED_TIME         (mut i32) i32(0))

    (global $LENGTH_TIME_ORIGIN                i32 i32(8))
    (global $OFFSET_TIME_ORIGIN          (mut i32) i32(0))

    (global $LENGTH_TIME_SECONDS               i32 i32(4))
    (global $OFFSET_TIME_SECONDS         (mut i32) i32(0))

    (global $LENGTH_TIME_MINUTES               i32 i32(4))
    (global $OFFSET_TIME_MINUTES         (mut i32) i32(0))
    
    (global $self.IdleDeadline                  ref)
    (global $self.IdleDeadline:timeRemaining    ref)
    (global $self.IdleDeadline:didTimeout/get   ref)
    (global $self.performance.timeOrigin        f32)

    (global $requestIdleCallbackOptions mut extern)
    (global $requestIdleCallbackTimeout i32 i32(100))

    (func $IdleDeadline:didTimeout<ref>i32
        (param $idleDeadline ref)
        (result i32)
        
        $self.Reflect.apply<refx3>i32(
            global($self.IdleDeadline:didTimeout/get) 
            this 
            global($nil/array)
        )
    )

    (func $IdleDeadline:timeElapsed<ref>i32
        (param $idleDeadline ref)
        (result i32)
        
        (i32.sub 
            global($requestIdleCallbackTimeout)
            $IdleDeadline:timeRemaining<ref>i32(
                local($idleDeadline)
            )
        )
    )

    (func $IdleDeadline:timeRemaining<ref>i32
        (param $idleDeadline ref)
        (result i32)
        
        $self.Reflect.apply<refx3>i32(
            global($self.IdleDeadline:timeRemaining) 
            this 
            global($nil/array)
        )
    )

    (start $main
        (global.set $requestIdleCallbackOptions 
            $self.Object.fromEntries<ref>ref(
                $self.Array.of<ref>ref(
                    $self.Array.of<ref.i32>ref(
                        text("timeout")
                        global($requestIdleCallbackTimeout)
                    )
                )
            )
        )

        (global.set $OFFSET_TICK_COUNT      $malloc( global($LENGTH_TICK_COUNT) ))
        (global.set $OFFSET_ELAPSED_TIME    $malloc( global($LENGTH_ELAPSED_TIME) ))
        (global.set $OFFSET_TIME_ORIGIN     $malloc( global($LENGTH_TIME_ORIGIN) ))
        (global.set $OFFSET_TIME_SECONDS    $malloc( global($LENGTH_TIME_SECONDS) ))
        (global.set $OFFSET_TIME_MINUTES    $malloc( global($LENGTH_TIME_MINUTES) ))

        $requestIdleCallback<fun>(
            func($nextTick) 
        )
    )

    (func $addElapsedTime<i32>
        (param $miliseconds i32)

        (local $elapsed i32)
        (local $seconds i32)
        (local $minutes i32)

        (local.set $elapsed
            $i32_atomic_add_n( 
                global($OFFSET_ELAPSED_TIME) 
                local($miliseconds)
            )        
        )
        
        (local.set $seconds (i32.div_u local($elapsed) i32(1000)))
        (if (i32.eq $getSeconds() local($seconds)) 
            (then return)
            (else $setSeconds( local( $seconds ) ))
        )
        
        (local.set $minutes (i32.div_u local($seconds) i32(60)))
        (if (i32.eq $getMinutes() local($minutes)) 
            (then return)
            (else $setMinutes( local( $minutes ) ))
        )
    )


    (func $setSeconds (param $seconds i32)
        (i32.store global($OFFSET_TIME_SECONDS) local($seconds) )
    )

    (func $setMinutes (param $minutes i32)
        (i32.store global($OFFSET_TIME_MINUTES) local($minutes) )
    )

    (func $getSeconds (result i32)
        (i32.load global($OFFSET_TIME_SECONDS) )
    )

    (func $getMinutes (result i32)
        (i32.load global($OFFSET_TIME_MINUTES) )
    )

    (func $getTickCount (result i32)
        (i32.load global($OFFSET_TICK_COUNT) )
    )

    (func $getElapsedTime (result i32)
        (i32.load global($OFFSET_ELAPSED_TIME) )
    )

    (func $addTick
        $i32_store_add_1( 
            global($OFFSET_TICK_COUNT) 
        )
    )

    (func $requestIdleCallback<fun>
        (param $callback funcref)
        
        $self.requestIdleCallback<fun.ref>(
            local($callback) 
            global($requestIdleCallbackOptions)
        )
    )

    (func $nextTick 
        (param $idleDeadline ref)

        $addTick()

        ;; (log <i32x4>
        ;;     $getElapsedTime()
        ;;     $getTickCount()
        ;;     $getSeconds()
        ;;     $getMinutes()
        ;; )

        $addElapsedTime<i32>( 
            $IdleDeadline:timeElapsed<ref>i32(
                local( $idleDeadline )
            ) 
        )

        $requestIdleCallback<fun>(
            func($nextTick) 
        )
    )
)