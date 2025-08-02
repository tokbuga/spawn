(module 
    (import "self" "SHARED_MEMORY" (memory $memory 1 1 shared))

    (start $main
        (i32.atomic.store i32(0) i32(16))
    )

    (func $malloc (export "malloc")
        (param $length i32)
        (result i32)
        (if (i32.eqz this) (then unreachable))
        (i32.atomic.rmw.add i32(0) local($length))
    )

    (func (export "i32_atomic_add_1")
        (param $offset i32)
        (result i32)
        (i32.atomic.rmw.add local($offset) i32(1))
    )

    (func (export "i32_atomic_store_n")
        (param $offset i32)
        (param $value i32)
        (i32.atomic.store local($offset) local($value))
    )

    (func (export "i32_atomic_add_n")
        (param $offset i32)
        (param $value i32)
        (result i32)
        (i32.atomic.rmw.add local($offset) local($value))
    )

    (func (export "i32_store_add_1")
        (param $offset i32)
        (i32.store local($offset) (i32.add i32(1) (i32.load local($offset))))
    )

    (func (export "i32_store_add_n")
        (param $offset i32)
        (param $value i32)

        (i32.store local($offset) 
            (i32.add 
                local($value) 
                (i32.load 
                    local($offset)
                )
            )
        )
    )

    (func (export "f32_convert_i32_load_u")
        (param $offset i32)
        (result f32)
        (f32.convert_i32_u (i32.load local($offset)))
    )

    (func (export "i32_load")
        (param $offset i32)
        (result i32)
        (i32.load local($offset))
    )

    (func (export "i32_store")
        (param $offset i32)
        (param $value i32)
        (i32.store local($offset) local($value))
    )
)