
    (alias $Float64Array:new                     $Float64Array:new<ref>ref)
    (alias $Float64Array.of                       $Float64Array.of<i32>ref)
    (alias $Float64Array.from                   $Float64Array.from<ref>ref)
    
    (alias $Float32Array:new                     $Float32Array:new<ref>ref)
    (alias $Float32Array.of                       $Float32Array.of<i32>ref)
    (alias $Float32Array.from                   $Float32Array.from<ref>ref)
    (alias $Float32Array:map<ref.fun>ref       $TypedArray:map<ref.fun>ref)
    (alias $Float32Array:map<refx2>ref           $TypedArray:map<refx2>ref)
    
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
    (alias $TypedArray:fill                   $TypedArray:fill<ref.i32>ref)
    (alias $TypedArray:map                     $TypedArray:map<ref.fun>ref)
    (alias $TypedArray:set                          $TypedArray:set<refx2>)

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

    (func $Float32Array:new<i32>ref 
        (param $length                                 i32) 
        (result $this                       <Float32Array>) 

        (new $self.Float32Array<i32>ref local($length)) 
    )

    (func $Float32Array:new<ref>ref 
        (param $buffer                            <Buffer>) 
        (result $this                       <Float32Array>) 

        (new $self.Float32Array<ref>ref local($buffer)) 
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

    (func $Uint8Array:new<ref.i32>ref 
        (param $buffer                            <Buffer>) 
        (param $byteOffset                             i32) 
        (result $this                         <Uint8Array>) 

        (new $self.Uint8Array<ref.i32>ref local($buffer) local($byteOffset)) 
    )

    (func $Uint8Array:new<ref.i32x2>ref 
        (param $buffer                            <Buffer>) 
        (param $byteOffset                             i32) 
        (param $length                                 i32) 
        (result $this                         <Uint8Array>) 

        (new $self.Uint8Array<ref.i32x2>ref local($buffer) local($byteOffset) local($length)) 
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

    (func $TypedArray:fill<ref.i32>ref
        (param $this                          <TypedArray>) 
        (param $value                                  i32) 
        (result $this                         <TypedArray>) 

        (apply $self.Uint8Array:__proto__.fill<i32>ref 
            this (param local($value))
        )
    )

    (func $TypedArray:map<ref.fun>ref
        (param $this                          <TypedArray>) 
        (param $callback                           funcref) 
        (result $this                         <TypedArray>) 

        (apply $self.Uint8Array:__proto__.map<fun>ref 
            this (param local($callback))
        )
    )

    (func $TypedArray:map<refx2>ref
        (param $this                          <TypedArray>) 
        (param $callback                        <Function>) 
        (result $this                         <TypedArray>) 

        (apply $self.Uint8Array:__proto__.map<ref>ref 
            this (param local($callback))
        )
    )

    (func $TypedArray:set<refx2>
        (param $typedArray                    <TypedArray>) 
        (param $valueArray                         <Array>) 

        (apply $self.Uint8Array:__proto__.set<ref> 
            this (param local($valueArray))
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

    (func $TypedArray:slice<ref>ref
        (param $this                          <TypedArray>) 
        (result $this                         <TypedArray>) 

        (apply $self.Uint8Array:__proto__.slice this ref)
    )

    (func $TypedArray:slice<ref.i32>ref
        (param $this                          <TypedArray>) 
        (param $start                                  i32) 
        (result $this                         <TypedArray>) 

        (apply $self.Uint8Array:__proto__.slice<i32>ref 
            this (param local($start))
        )
    )

    (func $TypedArray:slice<ref.i32x2>ref
        (param $this                          <TypedArray>) 
        (param $start                                  i32) 
        (param $end                                    i32) 
        (result $this                         <TypedArray>) 

        (apply $self.Uint8Array:__proto__.slice<i32x2>ref 
            this (param local($start) local($end))
        )
    )
