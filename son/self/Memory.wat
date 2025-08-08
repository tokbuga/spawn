
    (alias $Memory:new                         $Memory:new<ref>ref)
    (alias $Memory:buffer                   $Memory:buffer<ref>ref)

    (func $Memory:new<i32>ref 
        (param $initial                                i32) 
        (result $this                             <Memory>) 

        $Memory:new<i32x2>ref( local($initial) local($initial) )
    )

    (func $Memory:new<i32x2>ref 
        (param $initial                                i32) 
        (param $maximum                                i32) 
        (result $this                             <Memory>) 

        $Memory:new<i32x3>ref( local($initial) local($maximum) false )
    )

    (func $Memory:new<ref>ref 
        (param $descriptor                        <Object>) 
        (result $this                             <Memory>) 

        (new $self.WebAssembly.Memory<ref>ref local($descriptor)) 
    )

    (func $Memory:buffer<ref>ref 
        (param $this                              <Memory>) 
        (result $buffer                           <Buffer>) 

        (apply $self.WebAssembly.Memory:buffer/get this ref) 
    )

    (func $Memory:new<i32x3>ref 
        (param $initial                                i32) 
        (param $maximum                                i32) 
        (param $shared                                 i32) 
        (result $this                             <Memory>) 

        $Memory:new<ref>ref( 
            $Object.fromEntries<ref>ref(
                $Array.of<refx3>ref(
                    $Array.of<ref.i32>ref( text("initial") local($initial) )
                    $Array.of<ref.i32>ref( text("maximum") local($maximum) )
                    $Array.of<ref.i32>ref( text( "shared")  local($shared) )
                )
            )
        ) 
    )
