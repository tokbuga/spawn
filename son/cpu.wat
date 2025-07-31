(module
    (import "self" "memory" (memory $memory 1 1 shared))

    (start $eventLoop
        (log<i32> i32(4))
    )
)