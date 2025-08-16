
    (func $onmouseevents<ref> 
        (param $event           <PointerEvent>)

        $Event:preventDefault( local($event) )
        
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
        $mouse.renew<i32>( global($TYPE.EVENT_POINTER_CONTEXT_MENU) )
        $mouse.isContextMenu<i32>( true )
        $onmouseevents<ref>( this ) 
    )

    (on $pointermove<ref> (param ref) 
        $mouse.renew<i32>( global($TYPE.EVENT_POINTER_MOVE) )
        $mouse.isMove<i32>( true )
        $onmouseevents<ref>( this ) 
    )

    (on $pointerdown<ref> (param ref) 
        $mouse.renew<i32>( global($TYPE.EVENT_POINTER_DOWN) )
        $mouse.isDown<i32>( true )
        $onmouseevents<ref>( this ) 
    )

    (on $pointercancel<ref> (param ref) 
        $mouse.renew<i32>( global($TYPE.EVENT_POINTER_CANCEL) )
        $mouse.isCancel<i32>( true )
        $onmouseevents<ref>( this ) 
    )

    (on $pointerenter<ref> (param ref) 
        $mouse.renew<i32>( global($TYPE.EVENT_POINTER_ENTER) )
        $mouse.isEnter<i32>( true )
        $onmouseevents<ref>( this ) 
    )

    (on $pointerleave<ref> (param ref) 
        $mouse.renew<i32>( global($TYPE.EVENT_POINTER_LEAVE) )
        $mouse.isLeave<i32>( true )
        $onmouseevents<ref>( this ) 
    )

    (on $pointerout<ref> (param ref) 
        $mouse.renew<i32>( global($TYPE.EVENT_POINTER_OUT) )
        $mouse.isOut<i32>( true )
        $onmouseevents<ref>( this ) 
    )

    (on $pointerover<ref> (param ref) 
        $mouse.renew<i32>( global($TYPE.EVENT_POINTER_OVER) )
        $mouse.isOver<i32>( true )
        $onmouseevents<ref>( this ) 
    )

    (on $pointerup<ref> (param ref) 
        $mouse.renew<i32>( global($TYPE.EVENT_POINTER_UP) )
        $mouse.isUp<i32>( true )
        $onmouseevents<ref>( this ) 
    )

    (on $dragover<reF> 
        (param $event <DragEvent>) 
        (call $Event:preventDefault<ref> this)
    )

    (on $drop<reF> 
        (param $this                <DragEvent>) 
        (local $dataTransfer     <DataTransfer>)
        (local $items    <DataTransferItemList>)
        (local $length                      i32)
        (local $item/i       <DataTransferItem>)
        (local $file/i                   <File>)
        
        $Event:preventDefault( this )

        local($dataTransfer                 $DragEvent:dataTransfer( this ))
        local($items            $DataTransfer:items( local($dataTransfer) ))
        local($length         $DataTransferItemList:length( local($items) ))

        (if local($length) 
            (then 
            (loop $length--

                (local #length local($length)--)
                
                (local #item/i     
                    $DataTransferItemList:get( 
                        local($items) 
                        local($length)
                    )
                )

                (local #file/i     
                    $DataTransferItem:getAsFile( 
                        local($item/i)
                    )
                )

                $uploads.store<ref.funx2>(
                    local($file/i) 
                    func($onstoreuploadsuccess<ref>)
                    func($onstoreuploaderror<ref>)
                )

                (br_if $length-- local($length))

            ))
        )
    )
