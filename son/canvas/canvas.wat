    (global $CANVAS_HDRLEN i32 i32(16))

    (alias $canvas.width                          $canvas.width<>f32)
    (alias $canvas.height                        $canvas.height<>f32)
    (alias $canvas.clientWidth              $canvas.clientWidth<>f32)
    (alias $canvas.clientHeight            $canvas.clientHeight<>f32)

    (func $canvas.width<>f32            (result f32) (f32.load offset=0  global($CANVAS_OFFSET)))
    (func $canvas.height<>f32           (result f32) (f32.load offset=4  global($CANVAS_OFFSET)))
    (func $canvas.clientWidth<>f32      (result f32) (f32.load offset=8  global($CANVAS_OFFSET)))
    (func $canvas.clientHeight<>f32     (result f32) (f32.load offset=12 global($CANVAS_OFFSET)))

    (func $canvas.width<f32>            (param f32) (f32.store offset=0  global($CANVAS_OFFSET) local(0)))
    (func $canvas.height<f32>           (param f32) (f32.store offset=4  global($CANVAS_OFFSET) local(0)))
    (func $canvas.clientWidth<f32>      (param f32) (f32.store offset=8  global($CANVAS_OFFSET) local(0)))
    (func $canvas.clientHeight<f32>     (param f32) (f32.store offset=12 global($CANVAS_OFFSET) local(0)))
