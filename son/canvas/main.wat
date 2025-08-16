
    (global $MOUSE_OFFSET mut i32)
    (global $SCREEN_OFFSET mut i32)
    (global $CANVAS_OFFSET mut i32)

    (global $OFFSET.MOUSE_OFFSET  i32  i32(8))
    (global $OFFSET.SCREEN_OFFSET i32 i32(12))
    (global $OFFSET.CANVAS_OFFSET i32 i32(16))

    (func $onscreenmain
        (global #MOUSE_OFFSET  (i32.load global($OFFSET.MOUSE_OFFSET)))
        (global #SCREEN_OFFSET (i32.load global($OFFSET.SCREEN_OFFSET)))
        (global #CANVAS_OFFSET (i32.load global($OFFSET.CANVAS_OFFSET)))
    )