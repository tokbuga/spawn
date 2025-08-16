(module
    (import "self" "memory"     (memory $memory 100 100 shared))
    (import "self" "memory"     (global $memory <Memory>))
    (import "memory" "buffer"   (global $buffer <SharedArrayBuffer>))
    (import "self" "requestAnimationFrame" (func $requestAnimationFrame (param funcref)))
    
    (global $self.name              ref)
    (global $self.screen            ref)
    (global $self.origin            ref)
    (global $self.location          ref)
    (global $self.navigator         ref)
    (global $self.document          ref)
    (global $self.document.body     ref)
    (global $self.devicePixelRatio  f32)
    (global $self.location.hash     ref)

    (global $deviceUuid (mut v128) (v128.const f32x4 0 0 0 0))

    (include "self/PointerEvent.wat")
    (include "self/MouseEvent.wat")
    (include "self/UIEvent.wat")
    (include "self/Event.wat")
    (include "self/WebAssembly.wat")
    (include "self/Array.wat")
    (include "self/Object.wat")
    (include "self/Promise.wat")
    (include "self/URL.wat")
    (include "self/Blob.wat")
    (include "self/Worker.wat")
    (include "self/Screen.wat")
    (include "self/ScreenOrientation.wat")
    (include "self/Document.wat")
    (include "self/Element.wat")
    (include "self/HTMLElement.wat")
    (include "self/HTMLCanvasElement.wat")
    (include "self/CSSStyleDeclaration.wat")
    (include "self/Crypto.wat")
    (include "self/DragEvent.wat")
    (include "self/DataTransfer.wat")
    (include "self/DataTransferItem.wat")
    (include "self/DataTransferItemList.wat")
    (include "self/IDB.wat")
    (include "self/File.wat")
    (include "self/EventTarget.wat")
    (include "self/TypedArray.wat")
    (include "self/RegExp.wat")
    (include "self/String.wat")
    (include "self/Number.wat")
    (include "self/Math.wat")
    (include "self/ArrayBuffer.wat")

    (include "canvas/main.wat")
    (include "canvas/mouse.wat")
    (include "canvas/screen.wat")
    (include "canvas/listen.wat")
    (include "canvas/canvas.wat")

    (include "core/drop.wat")
    (include "core/uuid.wat")
    (include "core/self.wat")

    (include "mime/stl.wat")

    (global $workers             new Array)
    (global $workerURL          mut extern)
    (global $workerData         new Object)
    (global $canvas             mut extern)
    (global $body.style         mut extern)
    (global $canvas.style       mut extern)

    (global $MEMORY_HDRLEN     i32 i32(48))

    (func $onanimationframe<i32> 
        (param $epoch i32)
        
        $canvas.epoch<i32>( this )
        $canvas.framePerSecond<i32>(
            (i32.div_u (i32.mul i32(1000) $canvas.frameCount++()) this)
        )

        $requestAnimationFrame(
            func($onanimationframe<i32>)
        )
    )

    (func $ondemofilebuffer<ref>
        (param $buffer <ArrayBuffer>)
        $STL:debugArrayBuffer( this )
    )

    (func $onuploadsopen
        $uploads.load(
            text("CaseV1.STL")
            (func $onsuccess<ref>
                (param $event <Event>)
                
                $Promise:then( 
                    $Blob:arrayBuffer( 
                        $IDBRequest:result( 
                            $Event:target( this )
                        )
                    )
                    func($ondemofilebuffer<ref>)
                )
            )
            (func $onerror<ref> 
                (param $error <Error>) 
                (error this)
            )
        )
    )

    (start $main
        $malloc()
        $create()
        $settle()

        $uploads.open()
        $onanimationframe<i32>( i32(1) )
        
        (warn <refx2> text("deviceUuid:") $toUuidString( global($deviceUuid) ))

        $Promise:then(
            $WebAssembly.compile(
                global($wasm:worker)
            )
            (func $onmodulecompiled<ref>
                (param $module <WebAssembly.Module>)
                
                (set <refx3> global($workerData) text("module") local($module))
                (set <refx3> global($workerData) text("memory") global($memory))

                (global #workerURL 
                    $URL.createObjectURL(
                        $Blob:new(
                            $Array:new(
                                global($js:worker)
                            )
                        )
                    )
                )

                $fork()
            )
        )

        (log global($memory))
    )

    (func $malloc
        malloc(global($MEMORY_HDRLEN));

        (i32.store global($OFFSET.MOUSE_OFFSET)  malloc(global($MOUSE_HDRLEN)))
        (i32.store global($OFFSET.SCREEN_OFFSET) malloc(global($SCREEN_HDRLEN)))
        (i32.store global($OFFSET.CANVAS_OFFSET) malloc(global($CANVAS_HDRLEN)))
    )

    (func $settle
        $onscreenmain()

        global($deviceUuid
            $fromUuidString<ref>v128( 
                global($self.name)
            )
        )

        $screen.width<f32>( $Screen:width( global($self.screen) ) )           
        $screen.height<f32>( $Screen:height( global($self.screen) ) )
        $screen.availTop<f32>( $Screen:availTop( global($self.screen) ) )
        $screen.availLeft<f32>( $Screen:availLeft( global($self.screen) ) )
        $screen.availWidth<f32>( $Screen:availWidth( global($self.screen) ) )
        $screen.availHeight<f32>( $Screen:availHeight( global($self.screen) ) )

        $screen.pixelDepth<i32>( $Screen:pixelDepth( global($self.screen) ) )
        $screen.colorDepth<i32>( $Screen:colorDepth( global($self.screen) ) )
        $screen.isExtended<i32>( $Screen:isExtended( global($self.screen) ) )
        
        $screen.devicePixelRatio<f32>( global($self.devicePixelRatio) )
        
        $canvas.clientWidth<f32>( $Element:clientWidth( global($self.document.body) ) )
        $canvas.clientHeight<f32>( $Element:clientHeight( global($self.document.body) ) )
        
        $canvas.width<f32>( (f32.mul $canvas.clientWidth() $screen.devicePixelRatio()) )
        $canvas.height<f32>( (f32.mul $canvas.clientHeight() $screen.devicePixelRatio()) )

        $resize()
    )

    (func $resize
        global($canvas)x2
        $HTMLCanvasElement:width<ref.f32>( $canvas.width() )
        $HTMLCanvasElement:height<ref.f32>( $canvas.height() )    

        global($canvas.style)x2
        $CSSStyleDeclaration:width<ref.f32>( $canvas.clientWidth() )
        $CSSStyleDeclaration:height<ref.f32>( $canvas.clientHeight() )
        
        global($body.style)
        $CSSStyleDeclaration:margin<ref.f32>( f32(0) )
    )

    (func $create
        global($canvas 
            $Document:createElement(
                global($self.document)
                global($HTMLCanvasElement.TAG_NAME)
            )
        )

        $Element:append(
            global($self.document.body)
            global($canvas)
        )

        global($body.style
            $HTMLElement:style(
                global($self.document.body)
            )
        )

        global($canvas.style
            $HTMLElement:style(
                global($canvas)
            )
        )        
    )

    (func $fork
        $Worker:postMessage(
            $Array:append(
                global($workers)
                $Worker:new(
                    global($workerURL)
                )
            )
            global($workerData)
        )
    )

    (data $js:worker "file://canvas.worker.js")
    (data $wasm:worker "wasm://canvas.worker.wat")
)