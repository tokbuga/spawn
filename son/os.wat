(module 
    (import "self" "SHARED_MEMORY" (memory $memory 1 1 shared))
    (import "memory" "malloc" (func $malloc (param $length i32) (result i32)))

    (start $main
        (log <fun> func($malloc))
    )
)