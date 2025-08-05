(module
    (memory 1 1)
    (table (export "SHARED_FUNC") 1 1000 funcref)
    (table (export "SHARED_EXTERN") 1 1000 externref)
)