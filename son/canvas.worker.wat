(module    
    (import "self" "memory" (memory $memory 100 100 shared))
    (import "self" "memory" (global $memory <Memory>))

    (import "self" "requestAnimationFrame" (func $requestAnimationFrame (param funcref)))
    
    (include "canvas/main.wat")
    (include "canvas/mouse.wat")
    (include "canvas/screen.wat")
    (include "canvas/canvas.wat")

    (start $main
        $onscreenmain()
        $onanimationframe()
    )

    (func $onanimationframe
        (if $mouse.hasnew() 
            (then $render())
        )

        $requestAnimationFrame(
            (ref.func $onanimationframe)
        )
    )

    (func $render
        (log <f32> $mouse.clientX() )
    )

)