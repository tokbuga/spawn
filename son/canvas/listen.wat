
    (func $onmouseevents<ref> 
        (param $e <PointerEvent>)

        $Event:preventDefault( this )
        $mouse.renew()
        
        $mouse.button<i32>( $MouseEvent:button( this ) )
        $mouse.altKey<i32>( $MouseEvent:altKey( this ) )

        $mouse.ctrlKey<i32>( $MouseEvent:ctrlKey( this ) )
        $mouse.metaKey<i32>( $MouseEvent:metaKey( this ) )

        $mouse.shiftKey<i32>( $MouseEvent:shiftKey( this ) )

        $mouse.pageX<f32>( $MouseEvent:pageX( this ) )
        $mouse.pageY<f32>( $MouseEvent:pageY( this ) )

        $mouse.clientX<f32>( $MouseEvent:clientX( this ) )
        $mouse.clientY<f32>( $MouseEvent:clientY( this ) )
        $mouse.offsetX<f32>( $MouseEvent:offsetX( this ) )
        $mouse.offsetY<f32>( $MouseEvent:offsetY( this ) )
        $mouse.screenX<f32>( $MouseEvent:screenX( this ) )
        $mouse.screenY<f32>( $MouseEvent:screenY( this ) )       

        $mouse.movementX<f32>( $MouseEvent:movementX( this ) )
        $mouse.movementY<f32>( $MouseEvent:movementY( this ) )
    )

    (on $contextmenu<ref> (param ref) 
        $mouse.isContextMenu<i32>( true )
        $onmouseevents<ref>( this ) 
    )

    (on $pointermove<ref> (param ref) 
        $mouse.isMove<i32>( true )
        $onmouseevents<ref>( this ) 
    )

    (on $pointerdown<ref> (param ref) 
        $mouse.isDown<i32>( true )
        $onmouseevents<ref>( this ) 
    )

    (on $pointercancel<ref> (param ref) 
        $mouse.isCancel<i32>( true )
        $onmouseevents<ref>( this ) 
    )

    (on $pointerenter<ref> (param ref) 
        $mouse.isEnter<i32>( true )
        $onmouseevents<ref>( this ) 
    )

    (on $pointerleave<ref> (param ref) 
        $mouse.isLeave<i32>( true )
        $onmouseevents<ref>( this ) 
    )

    (on $pointerout<ref> (param ref) 
        $mouse.isOut<i32>( true )
        $onmouseevents<ref>( this ) 
    )

    (on $pointerover<ref> (param ref) 
        $mouse.isOver<i32>( true )
        $onmouseevents<ref>( this ) 
    )

    (on $pointerup<ref> (param ref) 
        $mouse.isUp<i32>( true )
        $onmouseevents<ref>( this ) 
    )
