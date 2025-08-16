(module
    (import "self" "memory"     (memory $memory 100 100 shared))
    (import "self" "memory"     (global $memory <Memory>))
    
    (global $self.screen            ref)
    (global $self.origin            ref)
    (global $self.location          ref)
    (global $self.navigator         ref)
    (global $self.document          ref)
    (global $self.document.body     ref)
    (global $self.devicePixelRatio  f32)
    
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
    
    (include "canvas/main.wat")
    (include "canvas/mouse.wat")
    (include "canvas/screen.wat")
    (include "canvas/listen.wat")
    (include "canvas/canvas.wat")

    (global $workers             new Array)
    (global $workerURL          mut extern)
    (global $workerData         new Object)
    (global $canvas             mut extern)
    (global $body.style         mut extern)
    (global $canvas.style       mut extern)

    (global $MEMORY_HDRLEN     i32 i32(48))

    (start $main
        $malloc()
        $create()
        $settle()

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
                $fork()
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