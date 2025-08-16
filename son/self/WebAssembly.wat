
    (alias $WebAssembly.Memory:new                         $WebAssembly.Memory:new<ref>ref)
    (alias $WebAssembly.Memory:buffer                   $WebAssembly.Memory:buffer<ref>ref)
    (alias $WebAssembly.compile                               $WebAssembly.compile<ref>ref)

    (func $WebAssembly.Memory:new<i32>ref 
        (param $initial                                i32) 
        (result $this                             <Memory>) 

        $WebAssembly.Memory:new<i32x2>ref( local($initial) local($initial) )
    )

    (func $WebAssembly.Memory:new<i32x2>ref 
        (param $initial                                i32) 
        (param $maximum                                i32) 
        (result $this                             <Memory>) 

        $WebAssembly.Memory:new<i32x3>ref( local($initial) local($maximum) false )
    )

    (func $WebAssembly.Memory:new<ref>ref 
        (param $descriptor                        <Object>) 
        (result $this                             <Memory>) 

        (new $self.WebAssembly.Memory<ref>ref local($descriptor)) 
    )

    (func $WebAssembly.Memory:buffer<ref>ref 
        (param $this                              <Memory>) 
        (result $buffer                           <Buffer>) 

        (apply $self.WebAssembly.Memory:buffer/get this ref) 
    )

    (func $WebAssembly.compile<ref>ref 
        (param $source                   <ArrayBufferView>) 
        (result $promise                         <Promise>) 

        (apply $self.WebAssembly.compile<ref>ref self (param this)) 
    )

    (func $WebAssembly.Memory:new<i32x3>ref 
        (param $initial                                i32) 
        (param $maximum                                i32) 
        (param $shared                                 i32) 
        (result $this                             <Memory>) 

        $WebAssembly.Memory:new<ref>ref( 
            $Object.fromEntries<ref>ref(
                $Array.of<refx3>ref(
                    $Array.of<ref.i32>ref( text("initial") local($initial) )
                    $Array.of<ref.i32>ref( text("maximum") local($maximum) )
                    $Array.of<ref.i32>ref( text( "shared")  local($shared) )
                )
            )
        ) 
    )
