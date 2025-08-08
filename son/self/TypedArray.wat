
    (alias $Float64Array:new                     $Float64Array:new<ref>ref)
    (alias $Float64Array.of                       $Float64Array.of<i32>ref)
    (alias $Float64Array.from                   $Float64Array.from<ref>ref)
    
    (alias $BigUint64Array:new                 $BigUint64Array:new<ref>ref)
    (alias $BigUint64Array.of                   $BigUint64Array.of<i32>ref)
    (alias $BigUint64Array.from               $BigUint64Array.from<ref>ref)
    (alias $BigUint64Array:at                   $TypedArray:at<ref.i32>i64)
    (alias $BigUint64Array:at<ref.i32>i64       $TypedArray:at<ref.i32>i64)
    (alias $BigUint64Array:set<refx2.i32>       $TypedArray:set<refx2.i32>)
    
    (alias $Uint8Array:new                         $Uint8Array:new<ref>ref)
    (alias $Uint8Array.of                           $Uint8Array.of<i32>ref)
    (alias $Uint8Array.from                       $Uint8Array.from<ref>ref)
    
    (alias $TypedArray:buffer                   $TypedArray:buffer<ref>ref)

    (alias $Uint8Array:buffer<ref>ref           $TypedArray:buffer<ref>ref)
    (alias $Uint32Array:buffer<ref>ref          $TypedArray:buffer<ref>ref)
    (alias $Float64Array:buffer<ref>ref         $TypedArray:buffer<ref>ref)
    (alias $BigUint64Array:buffer<ref>ref   $BigUint64Array:buffer<ref>ref)

    (func $Float64Array:new<i32>ref 
        (param $length                                 i32) 
        (result $this                       <Float64Array>) 

        (new $self.Float64Array<i32>ref local($length)) 
    )

    (func $Float64Array:new<ref>ref 
        (param $buffer                            <Buffer>) 
        (result $this                       <Float64Array>) 

        (new $self.Float64Array<ref>ref local($buffer)) 
    )

    (func $BigUint64Array:new<i32>ref 
        (param $length                                 i32) 
        (result $this                     <BigUint64Array>) 

        (new $self.BigUint64Array<i32>ref local($length)) 
    )

    (func $BigUint64Array:new<ref>ref 
        (param $buffer                            <Buffer>) 
        (result $this                     <BigUint64Array>) 

        (new $self.BigUint64Array<ref>ref local($buffer)) 
    )

    (func $Uint8Array:new<i32>ref 
        (param $length                                 i32) 
        (result $this                         <Uint8Array>) 

        (new $self.Uint8Array<i32>ref local($length)) 
    )

    (func $Uint8Array:new<ref>ref 
        (param $buffer                            <Buffer>) 
        (result $this                         <Uint8Array>) 

        (new $self.Uint8Array<ref>ref local($buffer)) 
    )

    (func $Uint8Array:new<v128>ref
        (param $v128                                  v128)
        (result $this                         <Uint8Array>) 
        (local $view                          <TypedArray>)

        local($view $BigUint64Array:new<i32>ref(i32(2)))

        (set <ref.i32.i64> local($view) i32(0) (i64x2.extract_lane 0 this))
        (set <ref.i32.i64> local($view) i32(1) (i64x2.extract_lane 1 this))

        local($view $Uint8Array:new<ref>ref(
            $TypedArray:buffer(local($view))
        ))

        local($view)
    )

    (func $Uint8Array.from<ref>ref 
        (param $value                             <Object>) 
        (result $this                         <Uint8Array>) 

        (apply $self.Uint8Array.from<ref>ref 
            self (param local($value))
        )
    )

    (func $Uint8Array.of<i32>ref 
        (param $value                                  i32) 
        (result $this                         <Uint8Array>) 

        (call $self.Uint8Array.of<i32>ref local($value))
    )

    (func $TypedArray:buffer<ref>ref 
        (param $typedArray                    <TypedArray>) 
        (result $this                             <Buffer>) 

        (apply $self.Uint8Array:__proto__.buffer/get this ref)
    )

    (func $TypedArray:byteLength<ref>ref 
        (param $typedArray                    <TypedArray>) 
        (result $byteLength                            i32) 

        (apply $self.Uint8Array:__proto__.byteLength/get this i32)
    )

    (func $TypedArray:byteOffset<ref>ref 
        (param $typedArray                    <TypedArray>) 
        (result $byteOffset                            i32) 

        (apply $self.Uint8Array:__proto__.byteOffset/get this i32)
    )

    (func $TypedArray:length<ref>ref 
        (param $typedArray                    <TypedArray>) 
        (result $length                                i32) 

        (apply $self.Uint8Array:__proto__.length/get this i32)
    )

    (func $TypedArray:at<ref.i32>i64
        (param $typedArray                    <TypedArray>) 
        (param $index                                  i32) 
        (result $value                                 i64) 

        (apply $self.Uint8Array:__proto__.at<i32>i64 
            this (param local($index))
        )
    )

    (func $TypedArray:set<refx2.i32>
        (param $typedArray                    <TypedArray>) 
        (param $valueArray                         <Array>) 
        (param $index                                  i32) 

        (apply $self.Uint8Array:__proto__.set<ref.i32> 
            this (param local($valueArray) local($index))
        )
    )
