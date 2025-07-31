(module 
    (import "self" "memory" (memory $memory 1 1 shared))
    (import "self" "memory" (global $memory ref))

    (start $main
        (log global($memory))
    )
)